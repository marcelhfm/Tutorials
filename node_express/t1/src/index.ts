import express from "express";
const tasks = require("./routes/tasks");
const app = express();

// Middleware
app.use(express.json());

// Routes
app.get(`/hello`, (req, res) => {
  res.send("Task Manager App");
});

app.use("/api/v1/tasks", tasks);

const port = 3000;
app.listen(port);
console.log(`Server is listening on port ${port}...`);
