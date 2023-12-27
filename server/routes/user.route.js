const express = require('express');
const userController =require('../controllers/user.controller.js');
const userRouter = express.Router();


userRouter.get('/Home',userController.GetHomeScreenInfos);
userRouter.get('/ClientViews1/:client_id',userController.ReviewOrderHistory);
userRouter.get('/ClientViews2/:client_id',userController.ViewTransactionHistory);
userRouter.get('/ClientViews3/:client_id',userController.TrackingStats);
userRouter.post('/ClientActions1',userController.Reserving);
userRouter.post('/ClientActions2',userController.Canceling);
userRouter.post('/ClientActions3',userController.OfferHisBike).
userRouter.post('/ClientActions4',userController.RemoveHisBike).
userRouter.post('/ClientActions5/:client_id',userController.GiveFeedback);
userRouter.post('/ClientActions6/:client_id',userController.GiveComplaint);
userRouter.post('/Transactions',userController.MakeTransaction);

module.exports=userRouter;
