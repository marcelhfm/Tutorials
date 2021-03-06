import express from "express";

const asyncWrapper = require("../middleware/async");
const Task = require("../models/Task");
const { createCustomError, CustomAPIError } = require("../errors/custom-error");

const getAllTasks = asyncWrapper(
  async (req: express.Request, res: express.Response) => {
    const tasks = await Task.find({});
    res.status(200).json({ tasks });
  }
);

const createTask = asyncWrapper(
  async (req: express.Request, res: express.Response) => {
    const task = await Task.create(req.body);
    res.status(201).json({ task });
  }
);

const getTask = asyncWrapper(
  async (req: express.Request, res: express.Response, next: Function) => {
    const { id: taskID } = req.params;
    const task = await Task.findById({ _id: taskID });

    if (!task) {
      return next(createCustomError(`No task with id: ${taskID}`, 404));
    }

    res.status(200).json({ task });
  }
);

const deleteTask = asyncWrapper(
  async (req: express.Request, res: express.Response, next: Function) => {
    const { id: taskID } = req.params;
    const task = await Task.findOneAndDelete({ _id: taskID });

    if (!task) {
      return next(createCustomError(`No task with id: ${taskID}`, 404));
    }

    res.status(200).json({ task: null, status: "success" });
  }
);

const updateTask = asyncWrapper(
  async (req: express.Request, res: express.Response, next: Function) => {
    const { id: taskID } = req.params;

    const task = await Task.findOneAndUpdate({ _id: taskID }, req.body, {
      new: true,
      runValidators: true,
    });

    if (!task) {
      return next(createCustomError(`No task with id: ${taskID}`, 404));
    }

    res.status(200).json({ task });
  }
);

module.exports = {
  getAllTasks,
  createTask,
  getTask,
  updateTask,
  deleteTask,
};
