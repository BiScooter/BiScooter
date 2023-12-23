// import express from "express";
const express = require('express');
const dotenv=require('dotenv');
// import dotenv from "dotenv";
const db = require('./Database/index');
const authRouter = require ('./routes/auth.route.js');
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
// app.use('/users', authMiddleware, isAdminMiddleware, userRouter);
// app.use('/posts', authMiddleware, postRouter);


app.listen(PORT, (err) => {
  if (err) return console.error(err);
  console.log(`Server started listening at port ${PORT}`);
});
app.use(globalErrorHandler);
