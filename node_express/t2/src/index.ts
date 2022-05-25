import dotenv from "dotenv";
import express from "express";

const notFoundMiddleware = require("./middleware/not-found");
const errorMiddleware = require("./middleware/error-handler");
const connectDB = require("./db/connect");
const productsRouter = require("./routes/products");
require("express-async-errors");

dotenv.config();

//async errors

const app = express();

//Middleware
app.use(express.json());

//routes
app.get("/", (req, res) => {
  res.send('<h1>Store API</h1><a href="api/v1/products">products route</a>');
});

app.use("/", productsRouter);

// products route
app.use(notFoundMiddleware);
app.use(errorMiddleware);

const port = process.env.PORT || 3000;

const start = async () => {
  try {
    await connectDB(process.env.MONGO_URI);
    app.listen(port, () => console.log(`Server is listening on port: ${port}`));
  } catch (error) {
    console.log(error);
  }
};

start();
