USE TEMP_DB
Go

CREATE TABLE CLIENT 
(
	ID				INT													PRIMARY KEY,
	CARD_ID			INT						NOT NULL					UNIQUE,
	EMAIL			NVARCHAR(100)			NOT NULL					UNIQUE,
	USERNAME		NVARCHAR(50)			NOT NULL					UNIQUE,
	TELEPHONE		VARCHAR(15)				NOT NULL					UNIQUE,
	INVITATION_CODE VARCHAR(8)											UNIQUE,
	FNAME			VARCHAR(20)				NOT NULL,	
	MNAME			VARCHAR(20)				NOT NULL,
	LNAME			VARCHAR(20)				NOT NULL,
	PASSWORD		NVARCHAR(256)			NOT NULL,
	STATUS			VARCHAR(20)				NOT NULL,										-- Renter/Owner	
	WALLET			MONEY,
	INVITED_CLIENT	INT													FOREIGN KEY REFERENCES CLIENT(ID)
);


CREATE TABLE STATION
(
	ID				INT													PRIMARY KEY,
	CITY			VARCHAR(50)				NOT NULL,
	STREET			VARCHAR(50)				NOT NULL,
	ZIP				INT						NOT NULL,
																		CONSTRAINT ADDRESS UNIQUE (CITY,STREET,ZIP),
	NAME			VARCHAR(50)				NOT NULL					UNIQUE
);

CREATE TABLE SHIPMENT
(
	ID				  INT												PRIMARY KEY,
	DELIVERY_DATE	  DATE					NOT NULL,
	DEADLINE_DATE	  DATE					NOT NULL,
	COST			  INT					NOT NULL,
	BIKES_AMOUNT      VARCHAR(20),
	SCOOTERS_AMOUNT	  VARCHAR(20)
);

CREATE TABLE BISCOOT
(
    ID				INT													PRIMARY KEY,
    RNT_COST		INT						NOT NULL,
    SIZE			INT						NOT NULL,
    PRICE			INT						NOT NULL,
    IMAGE			VARCHAR(256)			NOT NULL					UNIQUE,
	OWNER_ID		INT													FOREIGN KEY REFERENCES CLIENT
																		ON DELETE SET NULL
																		ON UPDATE CASCADE,

	STATION_ID		INT													FOREIGN KEY REFERENCES STATION
																		ON DELETE SET NULL
																		ON UPDATE CASCADE,

	SHIPMENT_ID		INT						NOT NULL					FOREIGN KEY REFERENCES SHIPMENT
																		ON DELETE NO ACTION
																		ON UPDATE CASCADE
);

CREATE TABLE TRANS_ACTION
(
	ID				INT													PRIMARY KEY,
	CARDOTP			INT						NOT NULL					UNIQUE,
	STATUS			VARCHAR(20)				NOT NULL,					-- Deposit/Withdraw
	AMOUNT			INT						NOT NULL,
	DATE			DATE					NOT NULL,
	CLIENT_ID		INT													FOREIGN KEY REFERENCES CLIENT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE
);




CREATE TABLE FEEDBACK
(
	ID				INT													PRIMARY KEY,
	RATING			INT,
	DATE			DATE					NOT NULL,
	DESCRIPTION		NVARCHAR(256)
);

CREATE TABLE SUPPLIER
(
	ID				INT													PRIMARY KEY,
	EMAIL			NVARCHAR(256)			NOT NULL					UNIQUE,
	PHONE_NUMBER	VARCHAR(20)				NOT NULL					UNIQUE,
	FNAME			VARCHAR(20)				NOT NULL,
	MNAME			VARCHAR(20)				NOT NULL,
	LNAME			VARCHAR(20)				NOT NULL
);

CREATE TABLE EMPLOYEE
(
	NATIONAL_ID		INT													PRIMARY KEY,
	USERNAME		NVARCHAR(50)										UNIQUE,
	TELEPHONE		VARCHAR(15)				NOT NULL					UNIQUE,
	EMAIL			NVARCHAR(100)			NOT NULL					UNIQUE,
	PASSWORD		NVARCHAR(256)			NOT NULL,
	SALARY			FLOAT,
	BIRTHDATE		DATE					NOT NULL,
	FNAME			VARCHAR(20)				NOT NULL,
	MNAME			VARCHAR(20)				NOT NULL,
	LNAME			VARCHAR(20)				NOT NULL,
	MGR_ID			INT													FOREIGN KEY REFERENCES EMPLOYEE
																		ON DELETE SET NULL
																		ON UPDATE CASCADE ,
	STATION_ID		INT													FOREIGN KEY REFERENCES STATION
																		ON DELETE SET NULL
																		ON UPDATE CASCADE
);

CREATE TABLE COMPLAINT
(
	ID				INT													PRIMARY KEY,
	DATE			DATE					NOT NULL,
	DESCRIPTION		NVARCHAR(256),
	STATUS			VARCHAR(20)				NOT NULL,					-- Responded/Pending Complaint
	TYPE			VARCHAR(20),										--	Complaint to be OnBike/OnScooter/On GENERAL Service
	CLIENT_ID		INT						NOT NULL					FOREIGN KEY REFERENCES CLIENT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,
	EMPLOYEE_ID		INT													FOREIGN KEY REFERENCES EMPLOYEE
																		ON DELETE SET NULL
																		ON UPDATE CASCADE
);

CREATE TABLE ADMIN
(
	ADMIN_ID INT PRIMARY KEY ,
	FOREIGN KEY(ADMIN_ID) REFERENCES EMPLOYEE
);

CREATE TABLE RENTALS
(
    ID						INT											PRIMARY KEY,
    COST					MONEY			NOT NULL,
    STATUS					VARCHAR(50),
    DATE_OF_RENTAL			DATE			NOT NULL,
    DURATION				INT				NOT NULL,
	KICKOFF_STATION_ID		INT				NOT NULL					FOREIGN KEY REFERENCES STATION
																		ON DELETE NO ACTION
																		ON UPDATE CASCADE,
	DISTINATION_STATION_ID  INT											FOREIGN KEY REFERENCES STATION	
																		ON DELETE SET NULL
																		ON UPDATE CASCADE
);

CREATE TABLE BIKE
(
	TYPE_OF_BIKE		VARCHAR(50)			NOT NULL,
	GEARS_NUM			INT					NOT NULL,
	BRAND				VARCHAR(50)			NOT NULL,
	WEIGHT				INT					NOT NULL,
	BIKE_ID				INT												PRIMARY KEY,
																		FOREIGN KEY (BIKE_ID) REFERENCES BISCOOT (ID)
																		ON DELETE CASCADE 
																		ON UPDATE CASCADE
)

CREATE TABLE SCOOTER
(
	BATTERY_CAPACITY	VARCHAR(20)			NOT NULL,
	RANGE				INT					NOT NULL,
	MAX_SPEED			INT					NOT NULL,
	SCOOTER_ID			INT												PRIMARY KEY,
																		FOREIGN KEY (SCOOTER_ID) REFERENCES BISCOOT (ID)
																		ON DELETE CASCADE 
																		ON UPDATE CASCADE
);

CREATE TABLE MAINTAINENCE
(
    ID					INT												PRIMARY KEY,
    TYPE_OF_MNT			VARCHAR(50)			NOT NULL ,
    DATE_OF_MNT			DATE				NOT NULL,
    DESCRIPTION			VARCHAR(256),
    COST				MONEY				NOT NULL,
    STATUS				VARCHAR(50)			NOT NULL				-- The maintainence is finished OR not
)

CREATE TABLE RENT_BISCOOT
(
	RENTAL_ID			INT												PRIMARY KEY,
																		FOREIGN KEY(RENTAL_ID) REFERENCES RENTALS
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,
	CLIENT_ID			INT												FOREIGN KEY	REFERENCES CLIENT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,
	BISCOOT_ID			INT												FOREIGN KEY REFERENCES BISCOOT	
																		ON DELETE CASCADE
																		ON UPDATE CASCADE
);

CREATE TABLE CONDUCT_MAINTAINENCE
(
	MNT_ID			    INT												PRIMARY KEY,
																		FOREIGN KEY (MNT_ID) REFERENCES MAINTAINENCE
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,

	EMPLOYEE_ID			INT												FOREIGN KEY REFERENCES EMPLOYEE
																		ON DELETE SET NULL
																		ON UPDATE CASCADE,

	BISCOOT_ID		    INT												FOREIGN KEY REFERENCES BISCOOT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE
);	

CREATE TABLE SHIPMENT_ORDER
(
	SHIPMENT_ID			INT												PRIMARY KEY,
																		FOREIGN KEY(SHIPMENT_ID) REFERENCES SHIPMENT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,

	EMPLOYEE_ID			INT												FOREIGN KEY REFERENCES EMPLOYEE
																		ON DELETE SET NULL
																		ON UPDATE CASCADE,

	SUPPLIER_ID		    INT					NOT NULL					FOREIGN KEY	REFERENCES SUPPLIER
																		ON DELETE CASCADE
																		ON UPDATE CASCADE
);

CREATE TABLE FEEDBACK_BISCOOT
(
	FEEDBACK_ID			INT												PRIMARY KEY,
																		FOREIGN KEY(FEEDBACK_ID) REFERENCES FEEDBACK
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,

	CLIENT_ID			INT												FOREIGN KEY	REFERENCES CLIENT
																		ON DELETE SET NULL
																		ON UPDATE CASCADE,

	BISCOOT_ID			INT												FOREIGN KEY REFERENCES BISCOOT
																		ON DELETE CASCADE
																		ON UPDATE CASCADE
);

CREATE TABLE BIKES_NUMBERS
(
	STATION_ID			INT												PRIMARY KEY,
																		FOREIGN KEY(STATION_ID) REFERENCES STATION
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,
	NUM					INT												
);

CREATE TABLE SCOOTERS_NUMBERS
(
	STATION_ID			INT												PRIMARY KEY,
																		FOREIGN KEY(STATION_ID) REFERENCES STATION
																		ON DELETE CASCADE
																		ON UPDATE CASCADE,
	NUM					INT												
);




GO
CREATE TRIGGER COUNT_BIKES
ON STATION
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
    UPDATE BIKES_NUMBERS
	SET NUM = (SELECT COUNT(*)
	  FROM BISCOOT ,BIKE ,STATION
	  WHERE BISCOOT.ID = BIKE.BIKE_ID AND BISCOOT.STATION_ID = STATION.ID AND STATION.ID = BIKES_NUMBERS.STATION_ID)
END;

GO
CREATE TRIGGER COUNT_SCOOTERS
ON STATION
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
    UPDATE SCOOTERS_NUMBERS
	SET NUM = (SELECT COUNT(*)
	  FROM BISCOOT ,SCOOTER ,STATION
	  WHERE BISCOOT.ID = SCOOTER.SCOOTER_ID AND BISCOOT.STATION_ID = STATION.ID AND STATION.ID = SCOOTERS_NUMBERS.STATION_ID)
END;
GO