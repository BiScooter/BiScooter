const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const ErrorHandling = require("./Error");
const db = require("../Database/index");
const catchAsync = require("./catchAsync.js");
const { use } = require("../routes/user.route.js");

exports.GetHomeScreenInfos = catchAsync(async (req, res, next) => {
  // Retrieve the needed data to be presented in the home screen

  const BikeCountResult =
    await db.query(`Select STATION.ID AS Station_ID,STATION.NAME AS Station_Name,COUNT(*) AS Bikes_Numbers FROM STATION,
  BISCOOT,BIKE WHERE BIKE.BIKE_ID=BISCOOT.ID AND BISCOOT.STATION_ID=STATION.ID GROUP BY STATION.ID, STATION.NAME;`);
  console.log("helloooooo!!!");
  const ScooterCountResult =
    await db.query(`Select STATION.ID ,STATION.NAME,COUNT(*) AS Scooters_Numbers FROM STATION,
  BISCOOT,SCOOTER WHERE SCOOTER.SCOOTER_ID=BISCOOT.ID AND BISCOOT.STATION_ID=STATION.ID GROUP BY STATION.ID, STATION.NAME;`);
  // console.log(ScooterCountResult);
  BikeCountResult.rows[0].scooters_numbers =
    ScooterCountResult.rows[0]["scooters_numbers"];

  res.status(200).send({
    Message: "Stations'info is retrieved",
    Stations_Bikesinfo: BikeCountResult.rows,
  });
});

exports.ReviewOrderHistory = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const RentalHistory =
    await db.query(`SELECT * FROM RENT_BISCOOT NATURAL JOIN RENTALS AS RENTALS(RENTAL_ID,COST,STATUS,DATE_OF_RENTAL,DURATION,KICKOFF_STATION_ID,DISTINATION_STATION_ID)
     WHERE CLIENT_ID='${client_id}';`);

  res.status(200).send({
    Message: `Rental for user with id ='${client_id}'`,
    Rentalsinfo: RentalHistory.rows[0],
  });
});

exports.ViewTransactionHistory = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const ViewTransaction = await db.query(
    `SELECT * FROM TRANS_ACTION WHERE CLIENT_ID  = '${client_id}'`
  );
  res.status(200).send({
    Message: `All Transactions for user with id ='${client_id}'`,
    Transactioninfo: ViewTransaction.rows,
  });
});

exports.TrackingStats = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const OverAll = await db.query(
    `SELECT Overall_Time FROM CLIENT WHERE ID= '${client_id}'`
  );
  res.status(200).send({
    Message: `All overall time for user with id ='${client_id}'`,
    Statsinfo: OverAll.rows[0],
  });
});

exports.GiveFeedback = catchAsync(async (req, res, next) => {
  const { RATING, DATE, DESCRIPTION, BISCOOT_ID } = req.body;

  if (!RATING || !DATE || !DESCRIPTION || !BISCOOT_ID) {
    return next(new ErrorHandling("Fill All Fields to give feedback!", 409));
  }
  const { client_id } = req.params;
  const feedback_id = await db.query(
    `INSERT INTO FEEDBACK VALUES(DEFAULT,'${RATING}','${DATE}','${DESCRIPTION}')RETURNING ID;`
  );
  await db.query(
    `INSERT INTO FEEDBACK_BISCOOT VALUES('${feedback_id.rows[0].id}','${client_id}','${BISCOOT_ID}')`
  );

  res.status(200).send({
    Message: `Feedback has been given on bike with id '${BISCOOT_ID}'`,
  });
});

exports.GiveComplaint = catchAsync(async (req, res, next) => {
  const { DATE, DESCRIPTION, TYPE } = req.body;

  if (!DATE || !DESCRIPTION || !TYPE) {
    return next(new ErrorHandling("Fill All Fields to give complaint!", 409));
  }
  let date = new Date(DATE);
  let formattedDate = date.toISOString().split("T")[0];
  const { client_id } = req.params;
  await db.query(
    `INSERT INTO COMPLAINT VALUES(DEFAULT, $1, $2, 'PENDING', $3, $4);`,
    [formattedDate, DESCRIPTION, TYPE, client_id]
  );
  console.log("I am here");

  res.status(200).send({ Message: `Complaint filed successfully!!` });
});

exports.MakeTransaction = catchAsync(async (req, res, next) => {
  const { CARDOTP, STATUS, AMOUNT, DATE } = req.body;

  if (!CARDOTP || !STATUS || !AMOUNT || !DATE) {
    return next(new ErrorHandling("Fill All Fields to make transaction!", 409));
  }
  if (!User.phoneCheck(CARDOTP) || !User.phoneCheck(AMOUNT)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  const { client_id } = req.params;

  const ret_wallet = await db.query(
    `SELECT WALLET FROM CLIENT WHERE ID='${client_id}';`
  );
  let moneyString = ret_wallet.rows[0].wallet;
  let numericValue = parseInt(moneyString.replace("$", ""), 10);
  let numericAmount = parseInt(AMOUNT, 10);
  if (STATUS == "Withdraw") {
    if (numericValue < numericAmount) {
      res.status(400).send({ Message: `Not enough money!` });
    } else {
      let diff = numericValue - numericAmount;
      await db.query(
        `UPDATE CLIENT SET WALLET = '${diff}' WHERE ID='${client_id}'; `
      );
      await db.query(
        `INSERT INTO TRANS_ACTION VALUES(DEFAULT,'${CARDOTP}','${STATUS}','${AMOUNT}','${DATE}','${client_id}');`
      );
    }
  } else if (STATUS == "Deposit") {
    let sum = numericValue + numericAmount;
    await db.query(
      `UPDATE CLIENT SET WALLET = '${sum}' WHERE ID='${client_id}'; `
    );
    await db.query(
      `INSERT INTO TRANS_ACTION VALUES(DEFAULT,'${CARDOTP}','${STATUS}','${AMOUNT}','${DATE}','${client_id}');`
    );
  }

  res.status(200).send({ Message: `Transaction Done!` });
});

exports.Reserving = catchAsync(async (req, res, next) => {
  const {
    COST,
    STATUS,
    DATE_OF_RENTAL,
    DURATION,
    KICKOFF_STATION_ID,
    DISTINATION_STATION_ID,
    BISCOOT_ID,
  } = req.body;

  if (
    !COST ||
    !STATUS ||
    !DATE_OF_RENTAL ||
    !DURATION ||
    !KICKOFF_STATION_ID ||
    !DISTINATION_STATION_ID ||
    !BISCOOT_ID
  ) {
    return next(new ErrorHandling("Fill All Fields to RENT!", 409));
  }
  const { client_id } = req.params;
  if (
    !User.phoneCheck(COST) ||
    !User.phoneCheck(DURATION) ||
    !User.phoneCheck(KICKOFF_STATION_ID) ||
    !User.phoneCheck(DISTINATION_STATION_ID) ||
    !User.phoneCheck(BISCOOT_ID)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  const rent_id =
    await db.query(`INSERT INTO RENTALS VALUES(DEFAULT,'${COST}','${STATUS}','${DATE_OF_RENTAL}',
      '${DURATION}','${KICKOFF_STATION_ID}','${DISTINATION_STATION_ID}')RETURNING ID;`);

  await db.query(
    `INSERT INTO RENT_BISCOOT VALUES ('${rent_id.rows[0].id}',${client_id},${BISCOOT_ID});`
  );

  res.status(200).send({
    Message: `SUCCESSFULLY RENTED BIKE ${BISCOOT_ID} TO CLIENT WITH ID ${client_id}!`,
  });
});

exports.Canceling = catchAsync(async (req, res, next) => {
  const { ID } = req.body;

  if (!ID) {
    return next(new ErrorHandling("Fill All Fields to CANCEL RENTAL!", 409));
  }
  const Check_id_existance = await db.query(
    `SELECT ID FROM RENTALS WHERE ID='${ID}';`
  );
  if (!User.phoneCheck(ID)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  if (Check_id_existance.rowCount == 0) {
    res.status(300).send({ Message: `RENTAL DOES NOT EXIST!` });
  } else {
    await db.query(`DELETE FROM RENTALS WHERE ID='${ID}';`);
    res
      .status(200)
      .send({ Message: `RENTAL WITH ID '${ID}' HAS BEEN CANCELLED!` });
  }
});

exports.OfferHisBike = catchAsync(async (req, res, next) => {
  const { TYPE_OF_BIKE, GEARS_NUM, BRAND, WEIGHT, SIZE } = req.body;

  if (!TYPE_OF_BIKE || !GEARS_NUM || !BRAND || !WEIGHT || !SIZE) {
    return next(new ErrorHandling("Fill All Fields to Offer your bike!", 409));
  }
  if (
    !User.phoneCheck(GEARS_NUM) ||
    !User.phoneCheck(WEIGHT) ||
    !User.phoneCheck(SIZE)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }

  const { id } = req.params;

  let RNT_COST = 10;
  let IMG = "assets/imgs/bike.png";
  let PRICE = 120;
  const offered_biscoot_id = await db.query(
    `INSERT INTO BISCOOT VALUES (DEFAULT,'${RNT_COST}','${SIZE}','${PRICE}','${IMG}','${id}',null,'1')RETURNING ID;`
  );
  await db.query(
    `INSERT INTO BIKE VALUES ('${TYPE_OF_BIKE}','${GEARS_NUM}','${BRAND}','${WEIGHT}','${offered_biscoot_id.rows[0].id}')RETURNING BIKE_ID;`
  );
  res.status(200).send({
    Message: `Your bike has been inserted successfully with id '${offered_biscoot_id.rows[0].id}'!`,
  });
});

exports.OfferHisScooter = catchAsync(async (req, res, next) => {
  const { BATTERY_CAPACITY, RANGE, MAX_SPEED, SIZE } = req.body;
  console.log(req.body);
  if (!BATTERY_CAPACITY || !RANGE || !MAX_SPEED || !SIZE) {
    return next(
      new ErrorHandling("Fill All Fields to Offer your scooter!", 409)
    );
  }
  const { id } = req.params;
  if (
    !User.phoneCheck(BATTERY_CAPACITY) ||
    !User.phoneCheck(RANGE) ||
    !User.phoneCheck(MAX_SPEED) ||
    !User.phoneCheck(SIZE)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  let PRICE = 200;
  let RNT_COST = 15;
  let IMG = "assets/imgs/MiScooter.png";
  const offered_biscoot_id = await db.query(
    `INSERT INTO BISCOOT VALUES (DEFAULT,'${RNT_COST}','${SIZE}','${PRICE}','${IMG}','${id}',null,'1')RETURNING ID;`
  );
  await db.query(
    `INSERT INTO Scooter VALUES ('${BATTERY_CAPACITY}','${RANGE}','${MAX_SPEED}','${offered_biscoot_id.rows[0].id}')RETURNING SCOOTER_ID;`
  );
  res.status(200).send({
    Message: `Your scooter has been inserted successfully with id '${offered_biscoot_id.rows[0].id}'!`,
  });
});

exports.RemoveHisBiscooter = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  await db.query(`DELETE FROM BISCOOT WHERE BISCOOT.OWNER_ID='${id}';`);

  res.status(200).send({ Message: `Biscooter dropped successfully` });
});

exports.ViewOfferedBikes = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const offeredBikes = await db.query(`SELECT * FROM BIKE,BISCOOT
   WHERE BISCOOT.OWNER_ID='${id}' AND BIKE.BIKE_ID=BISCOOT.ID;`);
  const offeredScooters = await db.query(`SELECT * FROM SCOOTER,BISCOOT
   WHERE BISCOOT.OWNER_ID='${id}' AND SCOOTER.SCOOTER_ID=BISCOOT.ID;`);
  const myBiscooter = offeredBikes.rows[0] ?? offeredScooters.rows[0];
  myBiscooter.type = offeredBikes.rows[0] ? "bike" : "scooter";
  console.log(myBiscooter);
  res.status(200).send({
    Message: `Offered bikes and Scooters`,
    Biscooter: myBiscooter,
  });
});

exports.ChangeProfileImage = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const { img_url } = req.body;
  const changedImg = await db.query(`update client 
  set profile_img = '${img_url}'
  where id = ${id};`);
  res.status(200).send();
});

exports.ComplaintResponse = catchAsync(async (req, res, next) => {
  const { id } = req.params;
  const complaints = await db.query(
    `select * from complaint where client_id = '${id}'`
  );
  res.status(200).send(complaints.rows);
});
exports.ChangePassword = catchAsync(async (req, res, next) => {
  const { NeededPassword } = req.body;
  const { client_id } = req.params;

  if (!User.phoneCheck(client_id)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  console.log(client_id);
  const Check_id_existance = await db.query(
    "SELECT ID FROM CLIENT WHERE ID = $1;",
    [client_id]
  );
  if (Check_id_existance["rowCount"] == 0) {
    return next(new ErrorHandling("Client does not exist!", 401));
  }
  if (!NeededPassword) {
    return next(new ErrorHandling("Fill All Fields to change password!", 409));
  }
  const hashNeededPassword = await User.hashPassword(NeededPassword);
  if (hashNeededPassword == -1) {
    return next(
      new ErrorHandling("Password is not hashed and something went wrong", 500)
    );
  }

  const newPassword = await db.query(
    ` UPDATE CLIENT SET PASSWORD= '${hashNeededPassword}' WHERE ID='${client_id}';`
  );
  res.status(200).send({
    Message: `Password has been changed successfully!`,
    New_Password: newPassword.rows[0],
  });
});

exports.StationListingBikes = catchAsync(async (req, res, next) => {
  const { station_id } = req.params;

  if (!User.phoneCheck(station_id)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }

  const Check_id_existance = await db.query(
    `SELECT ID FROM STATION WHERE ID = '${station_id}';`
  );
  if (Check_id_existance["rowCount"] == 0) {
    return next(new ErrorHandling("Station does not exist!", 401));
  }

  const Bikes = await db.query(
    ` SELECT * FROM BIKE,BISCOOT WHERE BISCOOT.STATION_ID='${station_id}' AND BIKE.BIKE_ID=BISCOOT.ID;`
  );
  res.status(200).send({
    Message: `Bikes in station with id '${station_id}'`,
    Bikesinfo: Bikes.rows[0],
  });
});

exports.StationListingScooters = catchAsync(async (req, res, next) => {
  const { station_id } = req.params;

  if (!User.phoneCheck(station_id)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }

  const Check_id_existance = await db.query(
    `SELECT ID FROM STATION WHERE ID = '${station_id}';`
  );
  if (Check_id_existance["rowCount"] == 0) {
    return next(new ErrorHandling("Station does not exist!", 401));
  }

  const Scooters = await db.query(
    `SELECT * FROM SCOOTER,BISCOOT WHERE BISCOOT.STATION_ID='${station_id}' AND SCOOTER.SCOOTER_ID=BISCOOT.ID;`
  );
  res.status(200).send({
    Message: `Scooters in station with id '${station_id}'`,
    Scootersinfo: Scooters.rows[0],
  });
});
