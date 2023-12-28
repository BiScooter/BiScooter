const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const ErrorHandling = require("./Error");
const db = require("../Database/index");
const catchAsync = require("./catchAsync.js");

 exports.ViewAll=catchAsync ( async (req, res, next) => {

const clientData=await db.query("SELECT *");
res.status(200).send({status:"success",SignUp_Retrivals:data.rows[0]});

  });
exports.signup=catchAsync ( async (req, res, next) => {
    const {
    NATIONAL_ID,
    USERNAME,
    TELEPHONE,
    EMAIL,
    PASSWORD,
    SALARY,
    BIRTHDATE,
    FNAME,
    MNAME,
    LNAME,
    STATION_ID,
  } = req.body;

  if (
    !FNAME ||
    !MNAME ||
    !LNAME ||
    !EMAIL ||
    !PASSWORD ||
    !USERNAME ||
    !TELEPHONE ||
    !BIRTHDATE ||
    !SALARY ||
    !STATION_ID ||
    !NATIONAL_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }

  if (
    !User.phoneCheck(NATIONAL_ID) ||
    !User.phoneCheck(TELEPHONE) ||
    !User.phoneCheck(SALARY) ||
    !User.phoneCheck(STATION_ID)
  ) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!User.checkEmail(EMAIL)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const hashedPassword = await User.hashPassword(PASSWORD);
  if (hashedPassword == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));
  const NID = await db.query(
    `SELECT NATIONAL_ID FROM EMPLOYEE WHERE NATIONAL_ID='${NATIONAL_ID}'`
  );

  if (NID.rowCount == 0)
    NID =
      await db.query(`INSERT INTO EMPLOYEE VALUES('${NATIONAL_ID}','${USERNAME}','${TELEPHONE}','${EMAIL}',
           '${hashedPassword}','${SALARY}','${BIRTHDATE}','${FNAME}','${MNAME}','${LNAME}',null,'${STATION_ID}') RETURNING NATIONAL_ID;`);

  await db.query(`INSERT INTO ADMIN VALUES('${NID.rows[0].national_id}')`);
  res.status(200).send({ status: "Signed Up Successfully" });

});

exports.login=catchAsync (async (req, res, next) => {
  const email = req.body.email;
  const password = req.body.password;

  if (!email || !password) {
    return next(new ErrorHandling("Please enter Email & password", 400));
  }

  if (!User.checkEmail(email)) {
    return next(new ErrorHandling("Incorrect email or password", 401));
  }

  const user = await db.query(
    `SELECT PASSWORD FROM EMPLOYEE WHERE EMAIL = '${email}';`
  );

  const newUserId = await db.query(
    `SELECT NATIONAL_ID FROM EMPLOYEE WHERE EMAIL = '${email}';`
  );
  const truePassword = user["rows"][0]["password"] + "";
 
  const correct = await User.checkPassword(password, truePassword);
  if (correct == -1)
    return next(new ErrorHandling("Something went wrong try again", 500));
  
  if (user["rowCount"] == 0 || !correct) {
    return next(new ErrorHandling("Incorrect email or password", 401));
  }
  const result = await db.query(`SELECT *FROM EMPLOYEE where Email='${email}';`);
  res.status(200).send({status:"Successfully Logged in",user_info:result.rows[0]});
});

exports.AddEmp = catchAsync(async (req, res, next) => {
  const {
    NATIONAL_ID,
    USERNAME,
    TELEPHONE,
    EMAIL,
    PASSWORD,
    SALARY,
    BIRTHDATE,
    FNAME,
    MNAME,
    LNAME,
    MGR_ID,
    STATION_ID,
  } = req.body;

  if (
    !FNAME ||
    !MNAME ||
    !LNAME ||
    !EMAIL ||
    !PASSWORD ||
    !USERNAME ||
    !TELEPHONE ||
    !BIRTHDATE ||
    !SALARY ||
    !MGR_ID ||
    !STATION_ID ||
    !NATIONAL_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }

  if (
    !User.phoneCheck(NATIONAL_ID) ||
    !User.phoneCheck(TELEPHONE) ||
    !User.phoneCheck(SALARY) ||
    !User.phoneCheck(STATION_ID)
  ) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!User.checkEmail(EMAIL)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const hashedPassword = await User.hashPassword(PASSWORD);
  if (hashedPassword == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));
  await db.query(`INSERT INTO EMPLOYEE VALUES('${NATIONAL_ID}','${USERNAME}','${TELEPHONE}','${EMAIL}',
   '${hashedPassword}','${SALARY}','${BIRTHDATE}','${FNAME}','${MNAME}','${LNAME}','${MGR_ID}','${STATION_ID}');`);
  res.status(200).send({ status: "Employee inserted Successfully" });
});

exports.AddSup = catchAsync(async (req, res, next) => {
  const { EMAIL, PHONE_NUMBER, FNAME, MNAME, LNAME } = req.body;

  if (!FNAME || !MNAME || !LNAME || !EMAIL || !PHONE_NUMBER) {
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
  res.status(200).send({ status: "Supplier inserted Successfully" });
});

exports.AddAdmin = catchAsync(async (req, res, next) => {
  const {
    NATIONAL_ID,
    USERNAME,
    TELEPHONE,
    EMAIL,
    PASSWORD,
    SALARY,
    BIRTHDATE,
    FNAME,
    MNAME,
    LNAME,
    STATION_ID,
  } = req.body;

  if (
    !FNAME ||
    !MNAME ||
    !LNAME ||
    !EMAIL ||
    !PASSWORD ||
    !USERNAME ||
    !TELEPHONE ||
    !BIRTHDATE ||
    !SALARY ||
    !STATION_ID ||
    !NATIONAL_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }

  if (
    !User.phoneCheck(NATIONAL_ID) ||
    !User.phoneCheck(TELEPHONE) ||
    !User.phoneCheck(SALARY) ||
    !User.phoneCheck(STATION_ID)
  ) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!User.checkEmail(EMAIL)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const hashedPassword = await User.hashPassword(PASSWORD);
  if (hashedPassword == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));
  const NID = await db.query(
    `SELECT NATIONAL_ID FROM EMPLOYEE WHERE NATIONAL_ID='${NATIONAL_ID}'`
  );
  console.log(NID);
  if (NID.rowCount == 0)
    NID =
      await db.query(`INSERT INTO EMPLOYEE VALUES('${NATIONAL_ID}','${USERNAME}','${TELEPHONE}','${EMAIL}',
           '${hashedPassword}','${SALARY}','${BIRTHDATE}','${FNAME}','${MNAME}','${LNAME}',null,'${STATION_ID}') RETURNING NATIONAL_ID;`);

  await db.query(`INSERT INTO ADMIN VALUES('${NID.rows[0].national_id}')`);
  res.status(200).send({ status: "ADMIN inserted Successfully" });
});

exports.DropAdmin = catchAsync(async (req, res, next) => {
  const { ADMIN_ID } = req.body;
  if (!User.phoneCheck(ADMIN_ID)) {
    return next(new ErrorHandling("Enter numbers only!", 400));
  }
  const Admin_id = await db.query(
    `SELECT ADMIN_ID FROM ADMIN WHERE ADMIN_ID='${ADMIN_ID}'`
  );
  if (Admin_id.rowCount == 0)
    res.status(200).send({ status: "ADMIN does not exist" });
  else {
    await db.query(`DELETE FROM ADMIN WHERE ADMIN_ID='${ADMIN_ID}'`);
    res.status(200).send({ status: "ADMIN Deleted" });
  }
});

exports.DropEmp = catchAsync(async (req, res, next) => {
  const { NATIONAL_ID } = req.body;

  const Emp_id = await db.query(
    `SELECT NATIONAL_ID FROM EMPLOYEE WHERE NATIONAL_ID='${NATIONAL_ID}'`
  );
  if (Emp_id.rowCount == 0)
    res.status(200).send({ status: "Employee does not exist" });
  else {
    await db.query(`DELETE FROM EMPLOYEE WHERE NATIONAL_ID='${NATIONAL_ID}'`);
    res.status(200).send({ status: "EMPLOYEE Deleted" });
  }
});


exports.DropClient = catchAsync(async (req, res, next) => {
  const { ID } = req.body;
  if (!User.phoneCheck(ID)) {
    return next(new ErrorHandling("Enter numbers only!", 400));
  }
  const client_id = await db.query(
    `SELECT ID FROM CLIENT WHERE ID='${ID}'`
  );
  if (client_id.rowCount == 0)
    res.status(200).send({ status: "Client does not exist" });
  else {
    await db.query(`DELETE FROM Client WHERE ID='${ID}'`);
    res.status(200).send({ status: "Client Deleted" });
  }
});

exports.DropSupplier = catchAsync(async (req, res, next) => {
  const { ID } = req.body;
  if (!User.phoneCheck(ID)) {
    return next(new ErrorHandling("Enter numbers only!", 400));
  }
  const supplier_id = await db.query(
    `SELECT ID FROM SUPPLIER WHERE ID='${ID}'`
  );
  if (supplier_id.rowCount == 0)
    res.status(200).send({ status: "Supplier does not exist" });
  else {
    await db.query(`DELETE FROM Supplier WHERE ID='${ID}'`);
    res.status(200).send({ status: "Supplier Deleted" });
  }
});

exports.AddClient= catchAsync(async (req, res, next) => {
  function generateRandomString(length) {
    return Math.random().toString(36).substring(2, 2 + length);
  }
  
  // Example: Generate a random string of length 8
  const randomString = generateRandomString(8);
  const {
    FName,
    MName,
    LName,
    Email,
    Username,
    Telephone,
    Password
  } = req.body;

  if (
    !FName ||
    !LName ||
    !MName ||
    !Email ||
    !Password ||
    !Username ||
    !Telephone ||
    !Password
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }

  if (!User.phoneCheck(Telephone)) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!User.checkEmail(Email)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const hashedPassword = await User.hashPassword(Password);
  if (hashedPassword == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));
  const newUser =
    await db.query(`INSERT INTO client Values(DEFAULT,'${Email}', '${Username}',
      '${Telephone}','${randomString}', '${FName}', '${MName}',' ${LName}', '${hashedPassword}','5',7,null)RETURNING ID,invitation_code;`);

       res.status(200).send({status:"success",Added_User_Retrivals:newUser.rows[0]});
  });