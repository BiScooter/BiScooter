const express = require("express");
const adminController = require("../controllers/admin.controller.js");
const adminRouter = express.Router();

adminRouter.post("signup", adminController.signup);
adminRouter.post("/login", adminController.login);
// adminRouter.post("/AddEmployee", adminController.AddEmp);
// adminRouter.post("/AddSupplier", adminController.AddSup);

module.exports = adminRouter;
