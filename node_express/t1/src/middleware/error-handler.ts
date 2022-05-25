import express from "express";

const errorHandlerMiddleware = (
  err: Error,
  req: express.Request,
  res: express.Response,
  next: Function
) => {
  return res.status(500).json({ msg: err.message });
};

module.exports = errorHandlerMiddleware;
