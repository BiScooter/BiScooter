const express = require('express');
const adminController =require('../controllers/admin.controller.js');
// const authMiddleware = require('../middlewares/auth.middleware.js');

const adminRouter = express.Router();

adminRouter.post('/signup', adminController.signup);
adminRouter.post('/login', adminController.login);
//adminRouter.get('/ViewAll',adminController.ViewAll)
adminRouter.post('/AddEmployee',adminController.AddEmp)
adminRouter.post('/DropEmployee',adminController.DropEmp)
adminRouter.post('/AddClient',adminController.AddClient)
adminRouter.post('/DropClient',adminController.DropClient)
adminRouter.post('/AddAdmin',adminController.AddAdmin)
adminRouter.post('/DropAdmin',adminController.DropAdmin)
adminRouter.post('/AddSupplier',adminController.AddSup)
adminRouter.post('/DropSupplier',adminController.DropSupplier)
module.exports=adminRouter;
