import express from "express";
import mongoose from "mongoose";
const Product: mongoose.Model<any> = require("../models/product");

const getAllProductsStatic = async (
  req: express.Request,
  res: express.Response
) => {
  const search = "ab";
  const products = await Product.find({
    name: { $regex: search, $options: "i" },
  });
  res.status(200).json({ products, nbHits: products.length });
};

const getAllProducts = async (req: express.Request, res: express.Response) => {
  const { featured, company, name, sort, fields, numericFilters } = req.query;
  const queryObject: any = {};

  if (featured) {
    queryObject.featured = featured === "true" ? true : false;
  }
  if (company) {
    queryObject.company = company;
  }
  if (name) {
    queryObject.name = { $regex: name, $options: "i" };
  }

  if (numericFilters) {
    const operatorMap: any = {
      ">": "$gt",
      ">=": "$gte",
      "=": "$eq",
      "<": "$lt",
      "<=": "$lte",
    };

    const regEx = /\b(<|>|>=|=|<|<=)\b/g;
    if (typeof numericFilters === "string") {
      let filters: any = numericFilters.replace(
        regEx,
        (match) => `-${operatorMap[match]}-`
      );
      const options = ["price", "rating"];
      filters = filters.split(",").forEach((item: any) => {
        const [field, operator, value] = item.split("-");
        if (options.includes(field)) {
          queryObject[field] = { [operator]: Number(value) };
        }
      });
    }
  }

  let result = Product.find(queryObject);

  //sort
  if (sort && typeof sort === "string") {
    const sortList = sort.split(",").join(" ");
    result = result.sort(sortList);
  } else {
    result = result.sort({ createdAt: -1 });
  }

  //fields
  if (fields && typeof fields === "string") {
    const fieldsList = fields.split(",").join(" ");
    result = result.select(fieldsList);
  }

  //limit
  const page = Number(req.query.page) || 1;
  const limit = Number(req.query.limit) || 10;
  const skip = (page - 1) * limit;

  result = result.skip(skip).limit(limit);

  const products = await result;

  res.status(200).json({ products, nbHits: products.length });
};

module.exports = { getAllProducts, getAllProductsStatic };
