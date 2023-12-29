const express = require('express');
const userController =require('../controllers/user.controller.js');
const userRouter = express.Router();


userRouter.get('/Home',userController.GetHomeScreenInfos);
userRouter.get('/my-biscooter/:id',userController.ViewOfferedBikes);
userRouter.get('/ClientViews1/:client_id',userController.ReviewOrderHistory);
userRouter.get('/transactionsHistory/:client_id',userController.ViewTransactionHistory);
userRouter.get('/ClientViews3/:client_id',userController.TrackingStats);
userRouter.post('/ClientActions1/:client_id',userController.Reserving);
userRouter.post('/ClientActions2',userController.Canceling);
userRouter.post('/offer/bike/:id',userController.OfferHisBike);
userRouter.post('/offer/scooter/:id',userController.OfferHisScooter);
userRouter.delete('/my-biscooter/drop/:id',userController.RemoveHisBiscooter);
userRouter.post('/ClientActions5/:client_id',userController.GiveFeedback);
userRouter.post('/ClientActions6/:client_id',userController.GiveComplaint);
userRouter.get('/complaints/:id',userController.ComplaintResponse);
userRouter.post('/Transactions/:client_id',userController.MakeTransaction);
userRouter.post('/changeProfileImage/:id',userController.ChangeProfileImage);

module.exports=userRouter;
