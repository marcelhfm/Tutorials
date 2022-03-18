import express from "express";
import connectDB from "./db/connectDB";
const tasks = require("./routes/tasks");
import dotenv from "dotenv";

dotenv.config();
const app = express();

// Middleware
app.use(express.json());

// Routes
app.get(`/hello`, (req, res) => {
  res.send("Task Manager App");
});

app.use("/api/v1/tasks", tasks);

const port = 3000;

const start = async () => {
  try {
    await connectDB(process.env.DB_URI);
    app.listen(port);
    console.log(`Server is listening on port ${port}...`);
  } catch (error) {
    console.log(error);
  }
};

start();
