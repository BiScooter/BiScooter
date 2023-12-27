const bcrypt = require("bcrypt");
const User = require("../Models/FormatChecks.js");
const ErrorHandling = require("./Error");
const db = require("../Database/index");
const catchAsync=require("./catchAsync.js");


 exports.GetHomeScreenInfos=catchAsync ( async (req, res, next) => {
    // Retrieve the needed data to be presented in the home screen
 
  const BikeCountResult = await db.query(`Select STATION.ID AS Station_ID,STATION.NAME AS Station_Name,COUNT(*) AS Bikes_Numbers FROM STATION,
  BISCOOT,BIKE WHERE BIKE.BIKE_ID=BISCOOT.ID AND BISCOOT.STATION_ID=STATION.ID GROUP BY STATION.ID, STATION.NAME;`);
  console.log("helloooooo!!!");
  const ScooterCountResult = await db.query(`Select STATION.ID ,STATION.NAME,COUNT(*) AS Scooters_Numbers FROM STATION,
  BISCOOT,SCOOTER WHERE SCOOTER.SCOOTER_ID=BISCOOT.ID AND BISCOOT.STATION_ID=STATION.ID GROUP BY STATION.ID, STATION.NAME;`);
  // console.log(ScooterCountResult);
  BikeCountResult.rows[0].scooters_numbers=ScooterCountResult.rows[0]["scooters_numbers"];

  res.status(200).send({Message:"Stations'info is retrieved",Stations_Bikesinfo:BikeCountResult.rows[0]});

  });

  exports.ReviewOrderHistory=catchAsync (async (req, res, next) => {

  const {client_id}=req.params;

    // const RentalHistory = await db.query(`SELECT * FROM RENTALS,RENT_BISCOOT
    //  WHERE CLIENT_ID='${client_id}' AND RENTAL_ID=RENTALS.ID;`);
    const RentalHistory = await db.query(`SELECT * FROM RENT_BISCOOT NATURAL JOIN RENTALS AS RENTALS(RENTAL_ID,COST,STATUS,DATE_OF_RENTAL,DURATION,KICKOFF_STATION_ID,DISTINATION_STATION_ID)
     WHERE CLIENT_ID='${client_id}';`);

    res.status(200).send({Message:`Rental for user with id ='${client_id}'`,Rentalsinfo:RentalHistory.rows[0]});

  });

  exports.ViewTransactionHistory = catchAsync(async(req,res,next)=>{
    const {client_id}=req.params;
    const ViewTransaction = await db.query(`SELECT * FROM TRANS_ACTION WHERE CLIENT_ID  = '${client_id}'`);
    res.status(200).send({Message:`All Transactions for user with id ='${client_id}'`,Transactioninfo:ViewTransaction.rows[0]})
  });

    exports.TrackingStats= catchAsync(async(req,res,next)=>{
      const {client_id}=req.params;
      const OverAll = await db.query(`SELECT Overall_Time FROM CLIENT WHERE ID= '${client_id}'`);
      res.status(200).send({Message:`All overall time for user with id ='${client_id}'`,Statsinfo:OverAll.rows[0]})
    });


    exports.GiveFeedback= catchAsync(async(req,res,next)=>{
      const {
        RATING,
        DATE,
        DESCRIPTION,
        BISCOOT_ID
      } = req.body;
  
      if (
        !RATING ||
        !DATE ||
        !DESCRIPTION ||
        !BISCOOT_ID 
      ){
        return next(new ErrorHandling("Fill All Fields to give feedback!", 409));
      }
      const {client_id}=req.params;
      const feedback_id =
      await db.query(`INSERT INTO FEEDBACK VALUES(DEFAULT,'${RATING}','${DATE}','${DESCRIPTION}')RETURNING ID;`);
     await db.query(`INSERT INTO FEEDBACK_BISCOOT VALUES('${feedback_id.rows[0].id}','${client_id}','${BISCOOT_ID}')`);

      res.status(200).send({Message:`Feedback has been given on bike with id '${BISCOOT_ID}'`})
  
    });
  

    exports.GiveComplaint=catchAsync(async(req,res,next)=>{
      const {
       DATE,
       DESCRIPTION,
       STATUS,
       TYPE
      } = req.body;
  
      if (
        !DATE||
        !DESCRIPTION||
        !STATUS||
        !TYPE
      ){
        return next(new ErrorHandling("Fill All Fields to give complaint!", 409));
      }
      const {client_id}=req.params;
      await db.query(`INSERT INTO COMPLAINT VALUES(DEFAULT,'${DATE}','${DESCRIPTION}','${STATUS}','${TYPE}','${client_id}');`);


      res.status(200).send({Message:`Complaint filed successfully!!`})
  
    });
    
    
    exports.MakeTransaction= catchAsync(async(req,res,next)=>{
      const {
        CARDOTP,
        STATUS,
        AMOUNT,
        DATE,
      } = req.body;
  
      if (
        !CARDOTP||
        !STATUS||
        !AMOUNT||
        !DATE
      ){
        return next(new ErrorHandling("Fill All Fields to make transaction!", 409));
      }
      const {client_id}=req.params;

      await db.query(`INSERT INTO TRANS_ACTION VALUES(DEFAULT,'${CARDOTP}','${STATUS}','${AMOUNT}','${DATE}',null);`);

      res.status(200).send({Message:`Transaction Done!`})
  
    });
    exports.Reserving= catchAsync(async(req,res,next)=>{
      const {
        COST,
        STATUS,
        DATE_OF_RENTAL,
        DURATION,
        KICKOFF_STATION_ID,
        DISTINATION_STATION_ID,
        BISCOOT_ID
      } = req.body;
  
      if (
        !COST ||
        !STATUS ||
        !DATE_OF_RENTAL ||
        !DURATION ||
        !KICKOFF_STATION_ID||
        !DISTINATION_STATION_ID||
        !BISCOOT_ID
      ){
        return next(new ErrorHandling("Fill All Fields to RENT!", 409));
      }
      const {client_id}=req.params;

      const rent_id=await db.query(`INSERT INTO RENTALS VALUES(DEFAULT,'${COST}','${STATUS}','${DATE_OF_RENTAL}',
      '${DURATION}','${KICKOFF_STATION_ID}','${DISTINATION_STATION_ID}')RETURNING ID;`);
 
      await db.query(`INSERT INTO RENT_BISCOOT VALUES ('${rent_id.rows[0].id}',${client_id},${BISCOOT_ID});`);


      res.status(200).send({Message:`SUCCESSFULLY RENTED BIKE ${BISCOOT_ID} TO CLIENT WITH ID ${client_id}!`})
  
    });

exports.Canceling=catchAsync catchAsync(async(req,res,next)=>{
  const {
    ID
  } = req.body;

  if (
    !ID 
  ){
    return next(new ErrorHandling("Fill All Fields to RENT!", 409));
  }
  const {client_id}=req.params;

  const rent_id=await db.query(`INSERT INTO RENTALS VALUES(DEFAULT,'${COST}','${STATUS}','${DATE_OF_RENTAL}',
  '${DURATION}','${KICKOFF_STATION_ID}','${DISTINATION_STATION_ID}')RETURNING ID;`);

  await db.query(`INSERT INTO RENT_BISCOOT VALUES ('${rent_id.rows[0].id}',${client_id},${BISCOOT_ID});`);


  res.status(200).send({Message:`SUCCESSFULLY RENTED BIKE ${BISCOOT_ID} TO CLIENT WITH ID ${client_id}!`})

});

