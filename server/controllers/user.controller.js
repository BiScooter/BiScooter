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

  res
    .status(200)
    .send({
      Message: "Stations'info is retrieved",
      Stations_Bikesinfo: BikeCountResult.rows[0],
    });
});

exports.ReviewOrderHistory = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;

  // const RentalHistory = await db.query(`SELECT * FROM RENTALS,RENT_BISCOOT
  //  WHERE CLIENT_ID='${client_id}' AND RENTAL_ID=RENTALS.ID;`);
  const RentalHistory =
    await db.query(`SELECT * FROM RENT_BISCOOT NATURAL JOIN RENTALS AS RENTALS(RENTAL_ID,COST,STATUS,DATE_OF_RENTAL,DURATION,KICKOFF_STATION_ID,DISTINATION_STATION_ID)
     WHERE CLIENT_ID='${client_id}';`);

  res
    .status(200)
    .send({
      Message: `Rental for user with id ='${client_id}'`,
      Rentalsinfo: RentalHistory.rows[0],
    });
});

exports.ViewTransactionHistory = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const ViewTransaction = await db.query(
    `SELECT * FROM TRANS_ACTION WHERE CLIENT_ID  = '${client_id}'`
  );
  res
    .status(200)
    .send({
      Message: `All Transactions for user with id ='${client_id}'`,
      Transactioninfo: ViewTransaction.rows,
    });
});

exports.TrackingStats = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const OverAll = await db.query(
    `SELECT Overall_Time FROM CLIENT WHERE ID= '${client_id}'`
  );
  res
    .status(200)
    .send({
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

  res
    .status(200)
    .send({
      Message: `Feedback has been given on bike with id '${BISCOOT_ID}'`,
    });
});

exports.GiveComplaint = catchAsync(async (req, res, next) => {
  const { DATE, DESCRIPTION, TYPE } = req.body;

  if (!DATE || !DESCRIPTION || !TYPE) {
    return next(new ErrorHandling("Fill All Fields to give complaint!", 409));
  }
  const { client_id } = req.params;
  await db.query(
    `INSERT INTO COMPLAINT VALUES(DEFAULT,'${DATE}','${DESCRIPTION}','PENDING','${TYPE}','${client_id}');`
  );

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
  }
  else if(STATUS == "Deposit")
  {
    let sum = numericValue + numericAmount;
      await db.query(
        `UPDATE CLIENT SET WALLET = '${sum}' WHERE ID='${client_id}'; `
      );
      await db.query(
        `INSERT INTO TRANS_ACTION VALUES(DEFAULT,'${CARDOTP}','${STATUS}','${AMOUNT}','${DATE}','${client_id}');`);
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
    User.phoneCheck(BISCOOT_ID)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  const rent_id =
    await db.query(`INSERT INTO RENTALS VALUES(DEFAULT,'${COST}','${STATUS}','${DATE_OF_RENTAL}',
      '${DURATION}','${KICKOFF_STATION_ID}','${DISTINATION_STATION_ID}')RETURNING ID;`);

  await db.query(
    `INSERT INTO RENT_BISCOOT VALUES ('${rent_id.rows[0].id}',${client_id},${BISCOOT_ID});`
  );

  res
    .status(200)
    .send({
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
  const { TYPE_OF_BIKE, GEARS_NUM, BRAND, WEIGHT, RNT_COST, SIZE, PRICE, IMG } =
    req.body;

  if (
    !TYPE_OF_BIKE ||
    !GEARS_NUM ||
    !BRAND ||
    !WEIGHT ||
    !RNT_COST ||
    !SIZE ||
    !PRICE
  ) {
    return next(new ErrorHandling("Fill All Fields to Offer your bike!", 409));
  }
  if (
    !User.phoneCheck(GEARS_NUM) ||
    !User.phoneCheck(WEIGHT) ||
    !User.phoneCheck(RNT_COST) ||
    !User.phoneCheck(SIZE) ||
    User.phoneCheck(PRICE)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }

  const { client_id } = req.params;

  const offered_biscoot_id = await db.query(
    `INSERT INTO BISCOOT VALUES (DEFAULT,'${RNT_COST}','${SIZE}','${PRICE}','${IMG}','${client_id}',null,'0')RETURNING ID;`
  );
  await db.query(
    `INSERT INTO BIKE VALUES ('${TYPE_OF_BIKE}','${GEARS_NUM}','${BRAND}','${WEIGHT}','${offered_biscoot_id.rows[0].id}')RETURNING BIKE_ID;`
  );
  res
    .status(200)
    .send({
      Message: `Your bike has been inserted successfully with id '${offered_biscoot_id.rows[0].id}'!`,
    });
});

exports.OfferHisScooter = catchAsync(async (req, res, next) => {
  const { BATTERY_CAPACITY, RANGE, MAX_SPEED, RNT_COST, SIZE, PRICE, IMG } =
    req.body;

  if (
    !BATTERY_CAPACITY ||
    !RANGE ||
    !MAX_SPEED ||
    !RNT_COST ||
    !RNT_COST ||
    !SIZE ||
    !PRICE
  ) {
    return next(
      new ErrorHandling("Fill All Fields to Offer your scooter!", 409)
    );
  }
  const { client_id } = req.params;
  if (
    !User.phoneCheck(BATTERY_CAPACITY) ||
    !User.phoneCheck(RANGE) ||
    !User.phoneCheck(MAX_SPEED) ||
    !User.phoneCheck(RNT_COST) ||
    User.phoneCheck(SIZE) ||
    User.phoneCheck(PRICE)
  ) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  const offered_biscoot_id = await db.query(
    `INSERT INTO BISCOOT VALUES (DEFAULT,'${RNT_COST}','${SIZE}','${PRICE}','${IMG}','${client_id}',null,'0')RETURNING ID;`
  );
  await db.query(
    `INSERT INTO Scooter VALUES ('${BATTERY_CAPACITY}','${RANGE}','${MAX_SPEED}','${offered_biscoot_id.rows[0].id}')RETURNING SCOOTER_ID;`
  );
  res
    .status(200)
    .send({
      Message: `Your scooter has been inserted successfully with id '${offered_biscoot_id.rows[0].id}'!`,
    });
});

exports.RemoveHisScooter = catchAsync(async (req, res, next) => {
  const { SCOOTER_ID } = req.body;

  if (!SCOOTER_ID) {
    return next(
      new ErrorHandling("Fill All Fields to REMOVE your scooter!", 409)
    );
  }
  const { client_id } = req.params;
  if (!User.phoneCheck(SCOOTER_ID)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  await db.query(`DELETE FROM BISCOOT WHERE BISCOOT.OWNER_ID='${client_id}';`);

  res
    .status(200)
    .send({ Message: `SCOOTER WITH ID '${SCOOTER_ID} HAS BEEN REMOVED` });
});

exports.RemoveHisBike = catchAsync(async (req, res, next) => {
  const { BIKE_ID } = req.body;

  if (!BIKE_ID) {
    return next(new ErrorHandling("Fill All Fields to REMOVE your bike!", 409));
  }
  const { client_id } = req.params;
  if (!User.phoneCheck(BIKE_ID)) {
    return next(new ErrorHandling("Enter numbers only!!!!", 400));
  }
  await db.query(`DELETE FROM BISCOOT WHERE BISCOOT.OWNER_ID='${client_id}';`);

  res
    .status(200)
    .send({ Message: `BIKE WITH ID '${BIKE_ID} HAS BEEN REMOVED` });
});

exports.ViewOfferedBikes = catchAsync(async (req, res, next) => {
  const { client_id } = req.params;
  const offeredBikes = await db.query(`SELECT * FROM BIKE,BISCOOT
   WHERE BISCOOT.OWNER_ID='${client_id}' AND BIKE.BIKE_ID=BISCOOT.ID;`);
  const offeredScooters = await db.query(`SELECT * FROM SCOOTER,BISCOOT
   WHERE BISCOOT.OWNER_ID='${client_id}' AND SCOOTER.SCOOTER_ID=BISCOOT.ID;`);
  console.log(offeredBikes);
  res
    .status(200)
    .send({
      Message: `Offered bikes and Scooters`,
      Bikes: offeredBikes.rows[0],
      Scooters: offeredScooters.rows[0],
    });
});
