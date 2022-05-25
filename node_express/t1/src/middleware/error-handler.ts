import express from "express";
const { CustomAPIError } = require("../errors/custom-error");

const errorHandlerMiddleware = (
  err: any,
  req: express.Request,
  res: express.Response,
  next: Function
) => {
  if (err instanceof CustomAPIError) {
    return res.status(err.statusCode).json({ msg: err.message });
  }
  return res.status(500).json({ msg: err.message });
};

module.exports = errorHandlerMiddleware;
