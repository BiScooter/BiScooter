// import express from "express";
const express = require('express');
const dotenv=require('dotenv');
// import dotenv from "dotenv";
const db = require('./Database/index');
const authRouter = require ('./routes/auth.route.js');
const userRouter = require ('./routes/user.route.js');
const adminRouter=require('./routes/admin.route.js');
const empRouter=require('./routes/Emp.route.js');
const globalErrorHandler = require('./controllers/ErrorController');
// import authMiddleware from './middlewares/auth.middleware.js';
// import userRouter from './routes/user.route.js';
// import postRouter from "./routes/post.route.js";
// import { isAdminMiddleware } from "./middlewares/permissions.middleware.js";

dotenv.config();
const app = express();

const PORT = process.env.PORT || 8080;


app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/auth', authRouter);
app.use('/users',userRouter);
app.use('/admin', adminRouter);
app.use('/emp',empRouter);

app.listen(PORT, (err) => {
  if (err) return console.error(err);
  console.log(`Server started listening at port ${PORT}`);
});
app.use(globalErrorHandler);
