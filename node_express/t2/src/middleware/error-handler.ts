import express from "express";

const errorHandlerMiddleware = async (
  err: Error,
  req: express.Request,
  res: express.Response,
  next: Function
) => {
  console.log(err);
  return res.status(500).json({ msg: err.message });
};

module.exports = errorHandlerMiddleware;
