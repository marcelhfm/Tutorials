import express from "express";
import connectDB from "./db/connectDB";
import dotenv from "dotenv";

const tasks = require("./routes/tasks");
const notFound = require("./middleware/not-found");
const errorHandlerMiddleware = require("./middleware/error-handler");

dotenv.config();
const app = express();

// Middleware
app.use(express.json());

// Routes
app.use("/api/v1/tasks", tasks);
app.use(notFound);
app.use(errorHandlerMiddleware);

const port = process.env.PORT || 3000;

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
