const express = require('express');
const adminController =require('../controllers/admin.controller.js');
// const authMiddleware = require('../middlewares/auth.middleware.js');

const adminRouter = express.Router();

// adminRouter.post('/signup', authController.signup);
// adminRouter.post('/login', authController.login);
// adminRouter.get('/ViewAll',adminController.ViewAll)
adminRouter.post('/AddEmployee',adminController.AddEmp)
// adminRouter.get('/DropEmployee',adminController.DropEmp)
// adminRouter.get('/AddClient',adminController.Addclient)
// adminRouter.get('/DropClient',adminController.DropClient)
// adminRouter.get('/AddAdmin',adminController.AddAdmin)
// adminRouter.get('/DropAdmin',adminController.DropAdmin)
adminRouter.get('/AddSupplier',adminController.AddSup)
// adminRouter.get('/DropSupplier',adminController.DropSupplier)
module.exports=adminRouter;
