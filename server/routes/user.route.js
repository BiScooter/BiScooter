const express = require('express');
const userController =require('../controllers/user.controller.js');
const userRouter = express.Router();


userRouter.get('/Home',userController.GetHomeScreenInfos);
userRouter.get('/ViewOfferedBikes/:client_id',userController.ViewOfferedBikes);
userRouter.get('/ClientViews1/:client_id',userController.ReviewOrderHistory);
userRouter.get('/transactionsHistory/:client_id',userController.ViewTransactionHistory);
userRouter.get('/ClientViews3/:client_id',userController.TrackingStats);
userRouter.post('/ClientActions1/:client_id',userController.Reserving);
userRouter.post('/ClientActions2',userController.Canceling);
userRouter.post('/ClientActions3/OfferBike/:client_id',userController.OfferHisBike);
userRouter.post('/ClientActions3/OfferScooter/:client_id',userController.OfferHisScooter);
userRouter.post('/ClientActions4/RemoveBike/:client_id',userController.RemoveHisBike);
userRouter.post('/ClientActions4/RemoveScooter/:client_id',userController.RemoveHisScooter);
userRouter.post('/ClientActions5/:client_id',userController.GiveFeedback);
userRouter.post('/ClientActions6/:client_id',userController.GiveComplaint);
// userRouter.get('/ComplaintResponse/:client_id',userController.ComplaintResponse);
userRouter.post('/Transactions/:client_id',userController.MakeTransaction);
userRouter.post('/changeProfileImage/:id',userController.ChangeProfileImage);

module.exports=userRouter;
