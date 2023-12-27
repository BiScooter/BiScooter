const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const ErrorHandling = require("./Error");
const db = require("../Database/index");
const catchAsync=require("./catchAsync.js");




//  exports.ViewAll=catchAsync ( async (req, res, next) => {

// const clientData=await db.query("SELECT *");
// res.status(200).send({status:"success",SignUp_Retrivals:data.rows[0]});


//   });

  exports.AddEmp=catchAsync (async (req, res, next) => {
const{
    NATIONAL_ID	,	
	USERNAME,		
	TELEPHONE,		
	EMAIL	,		
	PASSWORD,		
	SALARY	,		
	BIRTHDATE,		
	FNAME	,		
	MNAME	,		
	LNAME	,																			
	STATION_ID		
}=req.body

if (
    !FNAME ||
    !MNAME ||
    !LNAME ||
    !EMAIL ||
    !PASSWORD ||
    !USERNAME ||
    !TELEPHONE ||
    !BIRTHDATE||
    !SALARY||
    !STATION_ID||
    !NATIONAL_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  
  if (!User.phoneCheck(NATIONAL_ID)
  ||!User.phoneCheck(TELEPHONE)||!User.phoneCheck(SALARY)||!User.phoneCheck(STATION_ID)) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!User.checkEmail(EMAIL)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const hashedPassword = await User.hashPassword(PASSWORD);
  if (hashedPassword == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));
   await db.query(`INSERT INTO EMPLOYEE VALUES('${NATIONAL_ID}','${USERNAME}','${TELEPHONE}','${EMAIL}',
   '${hashedPassword}','${SALARY}','${BIRTHDATE}','${FNAME}','${MNAME}','${LNAME}',null,'${STATION_ID}');`);
   res.status(200).send({status:"Employee inserted Successfully"});

  });

  exports.AddSup=catchAsync (async (req, res, next) => {
    const{
        EMAIL,
        PHONE_NUMBER,
        FNAME,MNAME,LNAME
    }=req.body
    
    if (
        !FNAME ||
        !MNAME ||
        !LNAME ||
        !EMAIL ||
        !PHONE_NUMBER
      ) {
        return next(new ErrorHandling("Fill All Fields!", 409));
      }
      
      if (!User.phoneCheck(PHONE_NUMBER)) {
        return next(new ErrorHandling("Invalid Phone number!", 400));
      }
      if (!User.checkEmail(EMAIL)) {
        return next(new ErrorHandling("Email is invalid", 400));
      }
       await db.query(`INSERT INTO SUPPLIER 
       VALUES(DEFAULT,'${EMAIL}','${PHONE_NUMBER}','${FNAME}','${MNAME}','${LNAME}');`);
       res.status(200).send({status:"Supplier inserted Successfully"});
    
      });



