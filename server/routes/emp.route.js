const express = require('express');
const empController =require('../controllers/emp.controller.js');
// const authMiddleware = require('../middlewares/auth.middleware.js');

const empRouter = express.Router();

empRouter.post('/signup', empController.signup);
empRouter.post('/login', empController.login);
empRouter.post('/ConductMaintain/:emp_id',empController.conductMain);
empRouter.get('/viewBiscootHistory',empController.ViewbiscootHistory);
empRouter.get('/ReviewFeedBacks',empController.ReviewFeedBacks);
empRouter.post('/DealingWithSuppliers/:emp_id',empController.DealingWithSuppliers);
empRouter.post('/AddStation',empController.AddStation);
empRouter.post('/DealingWithComplaints/:emp_id',empController.DealingWithComplaints);
empRouter.get('/ViewStationInfo',empController.ViewStationInfo);
empRouter.get('/ViewUserAccount',empController.ViewUserAccount);
empRouter.post('/DistributeBiscootOnStation',empController.DistributeOnStation);

empRouter.get('/AllBikesID',empController.AllBikesID);
empRouter.get('/AllScootersID',empController.AllScootersID);

empRouter.get('/AllClientsUsername',empController.AllClientsUsername);
empRouter.get('/AllEmployeesUsername',empController.AllEmployeesUsername);
empRouter.get('/AllAdminsUsername',empController.AllAdminsUsername);

empRouter.post('/ModularDeletion/:id/:type',empController.ModularDeletion);

module.exports=empRouter;