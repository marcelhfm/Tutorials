const CustomAPIError = require("../errors/custom-error");
import express from "express";

const errorHandlerMiddleware = (
  err: any,
  req: express.Request,
  res: express.Response,
  next: any
) => {
  if (err instanceof CustomAPIError) {
    return res.status(err.statusCode).json({ msg: err.message });
  }
  return res.status(500).send("Something went wrong try again later");
};

module.exports = errorHandlerMiddleware;
