import mongoose from "mongoose";

const connectDB = (url: string) => {
  return mongoose.connect(url).then(() => console.log("DB Connected"));
};

module.exports = connectDB;
