USE Master
GO
IF DB_ID('BBBusam0093') IS NOT NULL
    BEGIN
        ALTER DATABASE BBBusam0093 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE BBBusam0093
    END
GO
CREATE DATABASE BBBusam0093
GO
USE BBBusam0093
GO

CREATE TABLE [Vaskeri] (
  [Vaskeri_ID]INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  [Navn] VARCHAR(255),
  [Åbner] Datetime,
  [Lukker] Datetime
);


CREATE TABLE [BRUGER] (
  [BRUGER_ID] INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  [Navn] VARCHAR (255),
  [Email] VARCHAR (255),
  [Password] VARCHAR (255),
  [Konto] Decimal, 
  [Vaskeri] INT,
  [Oprettet] Datetime,
  CONSTRAINT [FH_BRUGER.Vaskeri] FOREIGN KEY ([Vaskeri]) REFERENCES [Vaskeri]([Vaskeri_ID])
);

CREATE TABLE [Maskine] (
  [Maskine_Id] INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  [Navn] VARCHAR(255),
  [PrisPrVask] Decimal(5,2),
  [Vasketid] VARCHAR(255),
  [Vaskeri] INT,
  CONSTRAINT [FK_Maskine.Vaskeri] FOREIGN KEY ([Vaskeri]) REFERENCES [Vaskeri]([Vaskeri_ID])
);

CREATE INDEX [UNIQUE] ON  [BRUGER] ([Email]);

CREATE TABLE [Booking] (
  [Booking_ID] INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  [Tidspunkt] Datetime,
  [Bruger] INT,
  [Maskine] INT,

  CONSTRAINT [FK_Booking.Tidspunkt] FOREIGN KEY ([Bruger]) REFERENCES [BRUGER]([BRUGER_ID]),
  CONSTRAINT [FK_Booking.Maskine] FOREIGN KEY ([Maskine]) REFERENCES [Maskine]([Maskine_Id])
);



CREATE INDEX [Fk] ON  [Booking] ([Bruger], [Maskine]);
INSERT INTO Vaskeri VALUES ('Whitewash Inc.','08:00','20:00')
INSERT INTO Vaskeri VALUES ('Double Bubble','02:00','22:00')
INSERT INTO Vaskeri VALUES ('Wash & Coffee','12:00','20:00')

INSERT INTO BRUGER VALUES ('John','john_doe66@gmail.com','password',100.00,2,'2021-02-15')
INSERT INTO BRUGER VALUES ('Neil Armstrong','firstman@nasa.gov','eagleLander69',1000.00,1,'2021-02-10')
INSERT INTO BRUGER VALUES ('Batman','noreply@thecave.com','Rob1n',500.00,3,'2020-03-10')
INSERT INTO BRUGER VALUES ('Goldman Sachs','moneylaundering@gs.com','NotRecognized',100000.00,1,'2021-01-01')
INSERT INTO BRUGER VALUES ('50 Cent','50cent@gmail.com','ItsMyBirthday',0.50,3,'2020-07-06')


INSERT INTO Maskine VALUES ('Mielle 911 Turbo',5.00,60,2)
INSERT INTO Maskine VALUES ('Siemons IClean',10000.00,30,1)
INSERT INTO Maskine VALUES ('Electrolax FX-2',15.00,45,2)
INSERT INTO Maskine VALUES ('NASA Spacewasher 8000',500.00,5,1)
INSERT INTO Maskine VALUES ('The Lost Sock',3.50,90,3)
INSERT INTO Maskine VALUES ('Yo Mama',0.50,120,3)


INSERT INTO Booking VALUES ('2021-02-26 12:00:00',1,1)
INSERT INTO Booking VALUES ('2021-02-26 16:00:00',1,3)
INSERT INTO Booking VALUES ('2021-02-26 08:00:00',2,4)
INSERT INTO Booking VALUES ('2021-02-26 15:00:00',3,5)
INSERT INTO Booking VALUES ('2021-02-26 20:00:00',4,2)
INSERT INTO Booking VALUES ('2021-02-26 19:00:00',4,2)
INSERT INTO Booking VALUES ('2021-02-26 10:00:00',4,2)
INSERT INTO Booking VALUES ('2021-02-26 16:00:00',5,6)

SELECT*FROM BRUGER WHERE Email like '%@%'
SELECT Maskine, count (Booking_ID) FROM Booking GROUP by Maskine
SELECT*FROM Booking
UPDATE BRUGER SET [Password] = 'SeliKyle' WHERE [Password]= 'Robin'

BEGIN TRAN
UPDATE Booking
SET Tidspunkt= '2022-02-26 12:00:00',
Bruger = 4,
Maskine = 2
WHERE Booking_ID = 5
COMMIT TRAN
SELECT @@TRANCOUNT AS OpenTransactions
