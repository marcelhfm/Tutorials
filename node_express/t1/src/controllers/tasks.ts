const Task = require("../models/Task");

const getAllTasks = (req: any, res: any) => {
  res.send("all itmes form the file");
};

const createTask = (req: any, res: any) => {
  res.json(req.body);
};

const getTask = (req: any, res: any) => {
  res.json({ id: req.params.id });
};

const updateTask = (req: any, res: any) => {
  res.send("Update Task");
};

const deleteTask = (req: any, res: any) => {
  res.send("delete Task");
};

module.exports = {
  getAllTasks,
  createTask,
  getTask,
  updateTask,
  deleteTask,
};
