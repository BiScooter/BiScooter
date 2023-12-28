const express = require('express');
const authController =require('../controllers/auth.controller.js');

const authRouter = express.Router();

authRouter.post('/signup', authController.signup);
authRouter.post('/login', authController.login);
// authRouter.get('/me',  authController.me);

module.exports=authRouter;
