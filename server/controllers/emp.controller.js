const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const ErrorHandling = require("./Error");
const db = require("../Database/index");
const catchAsync = require("./catchAsync.js");

exports.signup = catchAsync(async (req, res, next) => {
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
  res.status(200).send({ status: "Employee Signed Up Successfully" });
});

exports.login = catchAsync(async (req, res, next) => {
  const email = req.body.email;
  const password = req.body.password;

  if (!email || !password) {
    return next(new ErrorHandling("Please enter Email & password", 400));
  }

  if (!User.checkEmail(email)) {
    return next(new ErrorHandling("Incorrect email or password", 401));
  }

  const user = await db.query(
    `SELECT password FROM Employee WHERE email = '${email}';`
  );

  const newUserId = await db.query(
    `SELECT ID FROM Employee WHERE EMAIL = '${email}';`
  );
  const truePassword = user["rows"][0]["password"] + "";

  const correct = await User.checkPassword(password, truePassword);
  if (correct == -1)
    return next(new ErrorHandling("some thing went wrong try again", 500));

  if (user["rowCount"] == 0 || !correct) {
    return next(new ErrorHandling("incorrect email or password", 401));
  }
  const result = await db.query(
    `SELECT	EMAIL,			
    USERNAME,	
    TELEPHONE	,	
    FNAME	,			
    MNAME	,		
    LNAME	,				
    INVITED_CLIENT FROM client where Email='${email}';`
  );
  res
    .status(200)
    .send({ status: "Successfully Logged in", user_info: result.rows[0] });
});
exports.conductMain = catchAsync(async (req, res, next) => {
  const { TYPE_OF_MNT, DATE_OF_MNT, DESCRIPTION, COST, STATUS, BISCOOT_ID } =
    req.body;
  if (
    !TYPE_OF_MNT ||
    !DATE_OF_MNT ||
    !DESCRIPTION ||
    !COST ||
    !STATUS ||
    !BISCOOT_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  if (!User.phoneCheck(BISCOOT_ID) || !User.phoneCheck(COST)) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  const { emp_id } = req.params;

  const m_id = await db.query(
    `INSERT INTO MAINTAINENCE VALUES (DEFAULT,'${TYPE_OF_MNT}','${DATE_OF_MNT}','${DESCRIPTION}','${COST}','${STATUS}') RETURNING ID;`
  );
  console.log(emp_id);
  await db.query(
    `INSERT INTO CONDUCT_MAINTAINENCE VALUES (${m_id.rows[0].id},'${emp_id}','${BISCOOT_ID}');`
  );
  res.status(200).send({ status: "Successful" });
});

exports.ViewStationInfo = catchAsync(async (req, res, next) => {
  const allStations = await db.query(`SELECT * FROM STATION;`);
  res.status(200).send({ status: "Successful", stations: allStations.rows });
});

exports.ViewUserAccount = catchAsync(async (req, res, next) => {
  const allClients = await db.query(`SELECT * FROM CLIENT;`);
  res.status(200).send({ status: "Successful", stations: allClients.rows });
});

exports.ViewbiscootHistory = catchAsync(async (req, res, next) => {
  const allBiscs = await db.query(`SELECT * FROM BISCOOT;`);
  res.status(200).send({ status: "Successful", stations: allBiscs.rows });
});

exports.ReviewFeedBacks = catchAsync(async (req, res, next) => {
  const allfeeds = await db.query(`SELECT * FROM FEEDBACK;`);
  res.status(200).send({ status: "Successful", stations: allfeeds.rows });
});

exports.DealingWithSuppliers = catchAsync(async (req, res, next) => {
  const {
    DELIVERY_DATE,
    DEADLINE_DATE,
    COST,
    BIKES_AMOUNT,
    SCOOTERS_AMOUNT,
    SUPPLIER_ID,
  } = req.body;
  if (
    !DELIVERY_DATE ||
    !COST ||
    !DEADLINE_DATE ||
    !BIKES_AMOUNT ||
    !SCOOTERS_AMOUNT ||
    !SUPPLIER_ID
  ) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  const { emp_id } = req.params;
  const ship_id = await db.query(`INSERT INTO 
SHIPMENT VALUES 
(DEFAULT,'${DELIVERY_DATE}','${DEADLINE_DATE}','${COST}','${BIKES_AMOUNT}','${SCOOTERS_AMOUNT}') RETURNING ID;`);
  await db.query(
    `INSERT INTO SHIPMENT_ORDER VALUES('${ship_id.rows[0].id}','${emp_id}','${SUPPLIER_ID}');`
  );

  res.status(200).send({ status: "SHIPMENT INSERTED SUCCESSFULLY" });
});

exports.DealingWithComplaints = catchAsync(async (req, res, next) => {
  const { COMPLAINT_ID, RESPONSE } = req.body;
  if (!COMPLAINT_ID) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  const { emp_id } = req.params;
  await db.query(
    `UPDATE COMPLAINT SET RESPONSE ='${RESPONSE}',EMPLOYEE_ID='${emp_id}' WHERE ID='${COMPLAINT_ID}';`
  );
  res.status(200).send({ status: "RESPONDED SUCCCESSFULLY" });
});

exports.DistributeOnStation = catchAsync(async (req, res, next) => {
  const { STATION_ID, BISCOOT_ID, TYPE } = req.body;
  if (!STATION_ID) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  const station_id = await db.query(
    `UPDATE BISCOOT SET STATION_ID ='${STATION_ID}'WHERE ID='${BISCOOT_ID}'RETURNING STATION_ID;`
  );
  if (TYPE == "bike") {
    let n_b = await db.query(
      `SELECT NO_BIKES FROM STATION WHERE ID='${STATION_ID}';`
    );
    let moneyString = n_b.rows[0].no_bikes;
    let numericValue = parseInt(moneyString, 10);
    numericValue = numericValue + 1;
    console.log(numericValue);
    await db.query(
      `UPDATE STATION SET NO_BIKES ='${numericValue}' WHERE ID='${station_id.rows[0].station_id}';`
    );
  } else {
    let n_b = await db.query(
      `SELECT NO_SCOOTERS FROM STATION WHERE ID='${STATION_ID}';`
    );
    let moneyString = n_b.rows[0].no_scooters;
    let numericValue = parseInt(moneyString, 10);
    numericValue = numericValue + 1;
    await db.query(
      `UPDATE STATION SET NO_SCOOTERS ='${numericValue}',WHERE ID='${station_id}';`
    );
  }
  res.status(200).send({ status: "DONE" });
});

exports.AddStation = catchAsync(async (req, res, next) => {
  const { CITY, STREET, ZIP, NAME } = req.body;
  if (!CITY || !STREET || !ZIP || !NAME) {
    return next(new ErrorHandling("Fill All Fields!", 409));
  }
  await db.query(`INSERT INTO STATION VALUES(DEFAULT,'${CITY}','${STREET}','${ZIP}','${NAME}','0','0');`);
  res.status(200).send({ status: "DONE" });
});
