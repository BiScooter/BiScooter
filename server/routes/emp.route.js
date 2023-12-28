const express = require('express');
const empController =require('../controllers/emp.controller.js');
// const authMiddleware = require('../middlewares/auth.middleware.js');

const empRouter = express.Router();

// authRouter.post('/signup', authController.signup);
// authRouter.post('/login', authController.login);


module.exports=empRouter;
