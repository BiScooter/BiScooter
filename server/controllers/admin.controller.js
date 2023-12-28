const bcrypt = require("bcrypt");
const admin = require("../Models/FormatChecks.js");
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
    CONFIRMPASSWORD,
  } = req.body;

  if (
    !NATIONAL_ID ||
    !TELEPHONE ||
    !EMAIL ||
    !USERNAME ||
    !PASSWORD ||
    !BIRTHDATE ||
    !FNAME ||
    !MNAME ||
    !LNAME ||
    !CONFIRMPASSWORD
  ) {
    return next(new ErrorHandling("Fill all the important fields!", 409));
  }

  if (!admin.phoneCheck(TELEPHONE)) {
    return next(new ErrorHandling("Invalid Phone number!", 400));
  }
  if (!admin.checkEmail(EMAIL)) {
    return next(new ErrorHandling("Email is invalid", 400));
  }
  const HASHED_PASSWORD = await User.hashPassword(PASSWORD);
  if (HASHED_PASSWORD == -1)
    return next(new ErrorHandling("Something is Wrong!!", 500));

  await db.query(`INSERT INTO EMPLOYEE Values('${NATIONAL_ID}','${USERNAME}', '${TELEPHONE}',
        '${EMAIL}','${HASHED_PASSWORD}', '${SALARY}', '${BIRTHDATE}',' ${FNAME}', '${MNAME}','${MNAME}','${LNAME}','${MGR_ID}','${STATION_ID}')RETURNING *;`);

  const newAdmin = await db.query(
    $1`INSERT INTO ADMIN VALUES('${NATIONAL_ID}'`
  );

  res
    .status(200)
    .send({ status: "success", SignUp_Retrivals: newAdmin.rows[0] });
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
    `SELECT password FROM client WHERE email = '${email}';`
  );

  const newUserId = await db.query(
    `SELECT id FROM client WHERE email = '${email}';`
  );
  const truePassword = user["rows"][0]["password"] + "";

  const correct = await User.checkPassword(password, truePassword);
  if (correct == -1)
    return next(new ErrorHandling("some thing went wrong try again", 500));

  if (user["rowCount"] == 0 || !correct) {
    return next(new ErrorHandling("incorrect email or password", 401));
  }
  const result = await db.query(`SELECT * FROM client where Email='${email}';`);
  res
    .status(200)
    .send({ status: "Successfully Logged in", user_info: result.rows[0] });
});
