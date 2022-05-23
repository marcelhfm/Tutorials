import mongoose from "mongoose";

const connectDB = (url: string) => {
  return mongoose.connect(url).then(() => console.log("Connected to DB"));
};

export default connectDB;
