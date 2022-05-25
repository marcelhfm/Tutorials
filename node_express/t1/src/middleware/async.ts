import express from "express";

const asyncWrapper = (fn: Function) => {
  return async (
    req: express.Request,
    res: express.Response,
    next: Function
  ) => {
    try {
      await fn(req, res, next);
    } catch (error) {
      next(error);
    }
  };
};

module.exports = asyncWrapper;
