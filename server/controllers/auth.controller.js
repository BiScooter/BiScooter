const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const AppError = require("./Error");
const db = require("../Database/index");
const catchAsync=require("./catchAsync.js");
 exports.signup=catchAsync ( async (req, res, next) => {
    // Validate the request body against the sign up schema
    const {
      FName,
      MName,
      LName,
      Email,
      Username,
      Telephone,
      Password,
      ConfirmPassword,
    } = req.body;

    if (
      !FName ||
      !LName ||
      !MName ||
      !Email ||
      !Password ||
      !Username ||
      !Telephone ||
      !ConfirmPassword
    ) {
      return next(new AppError("Fill All Fields!", 409));
    }

    if (!User.phoneCheck(Telephone)) {
      return next(new AppError("Invalid Phone number!", 400));
    }
    if (!User.checkEmail(Email)) {
      return next(new AppError("Email is invalid", 400));
    }
    const hashedPassword = await User.hashPassword(Password);
    if (hashedPassword == -1)
      return next(new AppError("Something is Wrong!!", 500));
    const newUser =
      await db.query(`INSERT INTO client Values(DEFAULT,1,'${Email}', '${Username}',
        '${Telephone}','56789', '${FName}', '${MName}',' ${LName}', '${hashedPassword}','5',7,null);`);

         res.status(200).send("successful");

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
    res.status(200).send("Successfully Logged in");
  });


  exports.me=catchAsync(async (req, res) => {
    const email=req.body.email;
    const result = await db.query(`SELECT * FROM client where Email='${email}';`);
    res.json({
      status: 200,
      message: result.rows
    });
  });




