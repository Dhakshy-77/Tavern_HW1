/* Created for: MILES UNIVERSITY, Software Development Bootcamp- DB Class #2
   Created on : Microsoft SQL Server Management Studio 16, Version 13.0.14500.10
   Created Dt : 3/5/19 */

/** REFERENCE: https://baldursgate.fandom.com/wiki/Classes ,
               https://www.udemy.com, 
               https://stackoverflow.com/questions/3156908/using-a-single-common-where-condition-for-union-in-sql
			   https://www.w3schools.com/sql/trymysql.asp?filename=trysql_case
    NOTES:     Tavern is an establishment for the sale of beer and other drinks to be consumed on the premises, sometimes also serving food.
               A public house for travelers and others; inn.**/


/** DROP DATABASE IF EXISTS TAVERNDB;
    CREATE DATABASE TavernDB;
    GO
    USE TavernDB **/
	
Drop table if exists ROOMSTATUS;	
Drop table if exists ROOMSTAY;
Drop table if exists ROOM;
Drop table if exists GuestStatus;
Drop table If exists Guest;
Drop table if exists SalesOrderDetails;
Drop table if exists SalesOrder;
Drop table if exists Customer;
Drop table if exists Code;
Drop table if exists Inventory;
Drop table if exists Item;
Drop table if exists PurchaseOrderDetails;
Drop table if exists PurchaseOrder;
Drop table if exists Supplier;
Drop table if exists TavernLoc;
Drop table if exists TavernRats;
Drop table if exists TavernEmp;
Drop table if exists TavernInfo;

/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ CREATED TABLES AND ALTERED IT @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */

CREATE TABLE TavernInfo(			
       [TavernID] [int] NOT NULL,
       --TavernID INT CONSTRAINT [PK_TavernInfo] PRIMARY KEY IDENTITY(1,1),
       [TavernName] [varchar](100),
	   [TavernLocid] [int],
       [TavernOwner] [varchar](100),
       [NoOfFloors] [int] 
);

ALTER TABLE dbo.TavernInfo ADD CONSTRAINT
	PK_TavernID PRIMARY KEY
	(
	[TavernID]
	) 
GO

--Added new column TavernAddress to the created table TavernInfo using ALTER

ALTER TABLE TavernInfo ADD TavernAddress varchar(100)

--ALTER TABLE TavernInfo ADD CONSTRAINT [PK_TavernInfo] PRIMARY KEY (TavernID);
--ALTER TABLE Guest add foreign key (TavernID) references TavernInfo(TavernID);
--Added values for the new column TavernAddress. Assummed 2 Taverns in the same(Mt laurel) location.


--select * from TavernInfo;
--DROP TABLE TavernEmp;	

CREATE TABLE TavernEmp(	
       [EmpId] [INT] NOT NULL,
       --[EmpId] [INT] CONSTRAINT [PK_EmpId] PRIMARY KEY,
	   [EmpName] [varchar](100),
       [EmpRole] [varchar](100),
	   [TavernID] [INT] NOT NULL
	   --[TavernID] [INT] CONSTRAINT [FK_TavernEmp_TavernInfo] FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

ALTER TABLE dbo.TavernEmp ADD CONSTRAINT
	PK_TE_EmpId PRIMARY KEY
	(
	[EmpId]
	) 
GO

ALTER TABLE dbo.TavernEmp ADD CONSTRAINT
	FK_TE_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	[TavernID]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO
	
--SELECT * FROM TavernEmp; 

CREATE TABLE TavernRats(	
       [RatId] [INT] NOT NULL,
	   --TavernID INT CONSTRAINT [PK_TavernInfo] PRIMARY KEY IDENTITY(1,1),
       [RatName] [VARCHAR](100),
       [FloorNo] [INT],
       [TavernID] [INT] NOT NULL		
);

ALTER TABLE dbo.TavernRats ADD CONSTRAINT
	PK_RatId PRIMARY KEY
	(
	[RatId]
	) 
GO
ALTER TABLE dbo.TavernRats ADD CONSTRAINT
	FK_TR_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	[TavernID]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

--Update TavernRats

--Select * from TavernRats;

--SELECT * FROM TavernInfo as TIn join TavernEmp as TEmp on TIn.TavernID= TEmp.TavernID;


create table TavernLoc(
Locid int PRIMARY KEY,
Locname varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (1,'Merchantville, NJ', 1);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (2, ' Marlton, NJ',2);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (3,'CherryHill, NJ',3);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (4,'Riverside, NJ',4);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (5,'Mt Laurel, NJ',5);
INSERT INTO TavernLoc (Locid, Locname, Tavernid)
	VALUES (5,'Mt Laurel, NJ',6)

--DROP TABLE Supplier

CREATE TABLE Supplier(
       [SupplierID] [int] NOT NULL,
       [Suppliername] [varchar](100),
       [PurchaseOrderId] [int],
       [SupplierAddress] [varchar](300),
       [TavernID] [int] NOT NULL
);

ALTER TABLE dbo.Supplier ADD CONSTRAINT
	PK_SupplierID PRIMARY KEY
	(
	[SupplierID]
	) 
GO

ALTER TABLE dbo.Supplier ADD CONSTRAINT
	FK_S_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	[TavernID]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

--SELECT * FROM Supplier;
	
--DROP TABLE PurchaseOrder;

CREATE TABLE PurchaseOrder(
       [PurchaseOrderId] [int] NOT NULL,
       [PurchaseDt] [DATE],
       [SupplierID] [int],
       [TotalQty] [int],
       [TotalAmt] [int],
       [PurchaseStatus] [varchar](100),
      -- [TavernID] [int] NOT NULL
);

ALTER TABLE dbo.PurchaseOrder ADD CONSTRAINT
	PK_PO_PurchaseOrderId PRIMARY KEY
	(
	[PurchaseOrderId]
	) 
GO
/*ALTER TABLE dbo.PurchaseOrder ADD CONSTRAINT
	FK_PO_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	[TavernID]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO
*/
--select * from PurchaseOrder;

--DROP TABLE PurchaseOrderDetails;

CREATE TABLE PurchaseOrderDetails(
       [PurchaseOrderId] [int] NOT NULL,
       [ItemId] [int],
       [Unitprice] [int],
       [Quantity] [int],
       [Totalprice] [int],
       [PurchaseStatus] [varchar](100),
       [TavernID] [int] NOT NULL
);

ALTER TABLE dbo.PurchaseOrderDetails ADD CONSTRAINT
	PK_POD_PurchaseOrderId PRIMARY KEY
	(
	[PurchaseOrderId]
	) 
GO
ALTER TABLE dbo.PurchaseOrderDetails ADD CONSTRAINT
	FK_POD_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	[TavernID]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

--select * from PurchaseOrderDetails;

--DROP TABLE Item;
CREATE TABLE Item(
       [ItemId] [int] NOT NULL,
       [Itemname] [varchar](100),
       [Unitprice] [int],
       [UnitOfMeasurement] [varchar](100)
);
ALTER TABLE dbo.Item ADD CONSTRAINT
	PK_Item_ItemId PRIMARY KEY
	(
	[ItemId]
	) 
GO

--select * from Item;

--DROP TABLE Inventory;

CREATE TABLE Inventory(
       [ItemId] [int] NOT NULL,
       [Quantity] [int],
       [UnitOfMeasurement] [varchar](100)
);

ALTER TABLE dbo.Inventory ADD CONSTRAINT
	PK_Inv_ItemId PRIMARY KEY
	(
	[ItemId]
	) 
GO

--select * from Inventory;

--DROP TABLE Code;
CREATE TABLE Code(
       [CodeId] [INt] NOT NULL,
       [CodeType] [varchar](100),
       [Code] [varchar](100),
       [CodeDescription] [varchar](100)
);

ALTER TABLE dbo.Code ADD CONSTRAINT
	PK_Code_CodeId PRIMARY KEY
	(
	[CodeId]
	) 
GO
--DROP TABLE Customer;

CREATE TABLE Customer(
       [CustomerId] [int] NOT NULL,
       [CustomerName] [varchar](100),
       [CustomerAddress] [varchar](100),
       [SalesOrderId] [int],
       [TavernID] [int] NOT NULL
);

ALTER TABLE dbo.Customer ADD CONSTRAINT
	PK_Customer_CustomerId PRIMARY KEY
	(
	[CustomerId]
	) 
GO
ALTER TABLE dbo.Customer ADD CONSTRAINT
	FK_Customer_CustomerId FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	TavernID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

CREATE TABLE SalesOrder(
       [SalesOrderId] [int] NOT NULL,
       [SalesDt] [date],
       [CustomerId] [int],
       [TotalQty] [int],
       [TotalAmt] [int],
       [SalesStatus] [varchar](100),
       [TavernID] [int] NOT NULL
);

ALTER TABLE dbo.SalesOrder ADD CONSTRAINT
	PK_SO_SalesOrderId PRIMARY KEY
	(
	[SalesOrderId]
	) 
GO
ALTER TABLE dbo.SalesOrder ADD CONSTRAINT
	FK_SO_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	TavernID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO


--DROP TABLE SalesOrderDetails;

CREATE TABLE SalesOrderDetails(
       [SalesOrderId] [int] NOT NULL,
       [ItemId] [int],
       [Unitprice] [int],
       [Quantity] [int],
       [Totalprice] [int]
       --[TavernID] [int] NOT NULL
);

/*ALTER TABLE dbo.SalesOrderDetails ADD CONSTRAINT
	PK_SOD_SalesOrderId PRIMARY KEY
	(
	[SalesOrderId]
	) 
GO
*/
ALTER TABLE dbo.SalesOrderDetails ADD CONSTRAINT
	FK_SOD_SalesOrderId FOREIGN KEY
	(
	[SalesOrderId]
	) REFERENCES dbo.SalesOrder
	(
	SalesOrderId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO
*/
--SELECT * FROM SalesOrderDetails;

/**
Created Guest table to keep track of guests- their names, notes about them, birthdays, cakedays,class and levels.
created GuestStatus table to keep tract of gueststatus and guestid
**/
--DROP TABLE Gueststatus;
--DROP TABLE Guest;
CREATE TABLE [dbo].[Guest](
	[guestid] [int] NOT NULL,
	[guestname] [varchar](50) NOT NULL,
	[notes] [varchar](200) NULL,
	[birthday] [date] NOT NULL,
	[cakeday] [date] NULL,
	[class] [varchar](50) NOT NULL,
	[lev] [int] NOT NULL,
--	[TavernID] [int] not NULL
) ON [PRIMARY]
GO

ALTER TABLE dbo.Guest ADD CONSTRAINT
	PK_guestid PRIMARY KEY
	(
	[guestid]
	) 
GO

create table [dbo].[GuestStatus](
	[gueststatusid] [int] NOT NULL,
	[gueststatus] [VARCHAR](50) NOT NULL,
	[guestid] [int] NOT NULL,
	[TavernID] [int] not NULL
);

ALTER TABLE dbo.GuestStatus ADD CONSTRAINT
	PK_GS_gueststatusid PRIMARY KEY
	(
	[gueststatusid]
	) 
GO
ALTER TABLE dbo.GuestStatus ADD CONSTRAINT
	FK_GS_TavernID FOREIGN KEY
	(
	[TavernID]
	) REFERENCES dbo.TavernInfo
	(
	TavernID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE dbo.GuestStatus ADD CONSTRAINT
	FK_GS_guestid FOREIGN KEY
	(
	[guestid]
	) REFERENCES dbo.Guest
	(
	guestid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

/* The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There should be a way to track Room Stays which will 
   contain a sale, guest, room, date it was stayed in and the rate.*/

--drop table ROOM;

CREATE TABLE [dbo].[ROOM](
[id] [INT] CONSTRAINT [PK_ROOM_ID] PRIMARY KEY, 
[TavernID] [int] not NULL
)

--drop table ROOMSTATUS;

CREATE TABLE [dbo].[ROOMSTATUS](
[ID][INT] CONSTRAINT [PK_RStatus_ID] PRIMARY KEY,
[Status] [varchar](50) NOT NULL,
Roomid int constraint [FK_RStatus_Roomid] FOREIGN KEY references ROOM(id)
)

--DROP TABLE ROOMSTAY;

CREATE TABLE [dbo].[ROOMSTAY](
[ID][INT] CONSTRAINT [PK_RStay_ID] PRIMARY KEY,
--[SOId][INT] CONSTRAINT [FK_RStay_SalesOderId] FOREIGN KEY REFERENCES SalesOrder(SalesOrderId),
--[GId][INT] CONSTRAINT [FK_RStay_GID] FOREIGN KEY REFERENCES Guest(guestid), 
[SalesOrderId][int],
[guestid][int],
[Room_Id][INT] CONSTRAINT [FK_RStay_RID] FOREIGN KEY REFERENCES ROOM(id) , 
--[Room_Id][INT],
DateOccupied date default GETDATE(), 
Rate money NOT NULL
)

ALTER TABLE [dbo].[ROOMSTAY] ADD CONSTRAINT
	FK_RStay_SOID FOREIGN KEY
	(
	[SalesOrderId]
	) REFERENCES dbo.SalesOrder
	(
	SalesOrderId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

ALTER TABLE [dbo].[ROOMSTAY] ADD CONSTRAINT
	FK_RStay_GuestID FOREIGN KEY
	(
	[guestid]
	) REFERENCES dbo.Guest
	(
	guestid
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	-- [Room_Id][INT] CONSTRAINT [FK_RStay_RID] FOREIGN KEY REFERENCES ROOM(id) 

ALTER TABLE [dbo].[ROOMSTAY] ADD CONSTRAINT
	FK_RStay_Room_Id FOREIGN KEY
	(
	[Room_Id]
	) REFERENCES dbo.ROOM
	(
    [Room_Id]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 


/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ INSERT VALUES INTO TABLES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (1,'Blue Monkey Tavern', 1, 'Maddy', 1);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (2,'Marlton Tavern', 2, 'James',3);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (3,'Farm and Fisherman Tavern', 3, 'Micheal',3);
INSERT INTO TavernInfo (TavernID,TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (4,'Towne Tavern', 4, 'Robert',1);
INSERT INTO TavernInfo (TavernID,TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (5,'Seven Tap-Tavern', 5, 'Phil',3);
INSERT INTO TavernInfo (TavernID,TavernName, TavernLocid,  TavernOwner, NoOfFloors) 
    VALUES (6,'Seven Ravern', 5, 'Phil',3);

UPDATE TavernInfo SET TavernAddress ='1, Merchantville, NJ' WHERE TavernID = 1;
UPDATE TavernInfo SET TavernAddress ='2, Marlton, NJ' WHERE TavernID = 2;
UPDATE TavernInfo SET TavernAddress ='3, CherryHill, NJ' WHERE TavernID = 3;
UPDATE TavernInfo SET TavernAddress ='4, Riverside, NJ' WHERE TavernID = 4;
UPDATE TavernInfo SET TavernAddress ='5, Mt Laurel, NJ' WHERE TavernID = 5;
UPDATE TavernInfo SET TavernAddress ='6, Mt Laurel, NJ' WHERE TavernID = 6;
/*
    INSERT INTO TavernInfo 
	VALUES ('Blue Monkey Tavern', 1, 'Maddy', 1);
	VALUES ('Marlton Tavern', 2, 'James',3);
	VALUES ('Farm and Fisherman Tavern', 3, 'Micheal',3);
	VALUES ('Towne Tavern', 4, 'Robert',1);
	VALUES ('Seven Tap-Tavern', 5, 'Phil',3);
    VALUES ('Seven Ravern', 5, 'Phil',3);
*/


INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (1, 'John', 'Manager', 1);
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (2, 'Maddison', 'Owner', 4);
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (3, 'Murphy', 'Server', 1);
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (4, 'Jay', 'Server', 5);
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (5, 'Jack', 'Doorkeeper', 5);
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (6, 'Auggie', 'Server', 3);

INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (1, 'Mickey',1, 1)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (2, 'Mouse',1, 2)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (3, 'Cheesy',1, 1)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (4, 'Chelsea',2, 5)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (5, 'Martin',2, 3)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (6, 'King',3, 1)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (7, 'Ratty',2, 2)
INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID)
	VALUES (8, 'Mousey',3, 3)

INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (1, 'BeerSupplier', 100, 'Merchantville, NJ', 3)
INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (2, 'VodkaSupplier',  100,' Marlton, NJ', 1)
INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (3, 'WineSupplier', 100,'CherryHill, NJ', 1)
INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (4, 'GinSupplier', 50,'Riverside, NJ', 2)
INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (5, 'RedwineSupplier', 100,'Mt Laurel, NJ', 5)
INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)
	VALUES (6, 'MargaritaSupplier', 100, 'Lumberton, NJ', 2)


INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (1,'2018-01-21',1,5,200,'PENDING')
INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (2, '2018-02-16',2,100,1000,'PENDING')
INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (3, '2018-03-20',3,20,10000,'PURCHASED')
INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (4, '2018-04-18',4,1000,10000,'PENDING')
INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (5,'2018-05-06',5, 10,10000,'PURCHASED')
INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus)
	VALUES (6,'2018-06-21',6,20,20000,'PURCHASED')

	
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (1,1,10,12,120,'PENDING', 3)
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (2,2,20,6,120,'PENDING',1)
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (3,3,30,5, 150,'PURCHASED',1)
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (4,4,40,6,240,'PENDING',2)
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (5,5,50,2,100,'PURCHASED',5)
INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)
	VALUES (6,6,60,1,60,'PURCHASED',5)

Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(1,'beer',10,5)
Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(2,'Redwine',10,10)
Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(3,'Whitewine',10,6)
Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(4,'Gin',10,12)
Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(5,'Margarita',10,2)
Insert into Item(ItemId,Itemname,Unitprice,UnitOfMeasurement)
values(6,'water',10,6)


Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(1,600,24)
Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(2,500,20)
Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(3,400,12)
Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(4,300,10)
Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(5,200,6)
Insert into Inventory(ItemId,Quantity,UnitOfMeasurement)
values(6,100,2)

Insert into Code(CodeId, CodeType,Code,CodeDescription)
values(1,'Status','A','Active');
Insert into Code(CodeId, CodeType,Code,CodeDescription)
values(2,'Status','I','InActive');
Insert into Code(CodeId, CodeType,Code,CodeDescription)
values(3,'Status','A','Active');
Insert into Code(CodeId, CodeType,Code,CodeDescription)
values(4,'Status','I','InActive');
Insert into Code(CodeId, CodeType,Code,CodeDescription)
values(5,'Status','I','InActive');

Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(1,'Jason','Lumberton,NJ',1,1);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(2,'JSP','Mt laurel,NJ',21,2);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(3,'Java','Marlton,NJ',11,3);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(4,'SQL','Cherryhill,NJ',31,4);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(5,'Python','Voorhees,NJ',40,5);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(6,'Git','Lumberton,NJ',50,6);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(6,'Servlet','Mt Laurel,NJ',12,7);
Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID)
values(7,'Oracle','Lumberton,NJ',141,8);

Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID)
values(1,'2018-01-21',1,2,10,'Active',1);
Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID)
values(2,'2018-01-01',2,1,10,'Active',2);
Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID)
values(3,'2018-11-21',3,3,30,'Active',3);
Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID)
values(4,'2018-12-21',4,4,40,'Active',1);
Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID)
values(5,'2018-09-21',5,5,60,'Active',1);


Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice)
values(1,1,2,10,100);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice)
values(2,2,1,20,200);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice)
values(3,2,1,20,200);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice)
values(4,4,4,10,40);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice)
values(5,4,4,10,40);

Insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (1,'John',  'Masters of combat', '2010-01-01', null, 'Fighter',1);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (2,'Scott', 'Cast divine spells', '2010-02-01', '2010-02-01', 'Cleric', 2);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (3,'Aiden', 'Cast arcane spells', '2010-03-01', null, 'Mage', 3);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev)
       values (4,'Micheal','Masters of combat', '2010-04-01', '2010-04-01','Fighter', 1);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (5,'John','Reasonable combat capability','2010-05-01', null, 'Thief', 4);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (6,'John','Reasonable combat capability','2010-05-01', null, 'Thief', 20);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (7,'John','Reasonable combat capability','2010-05-01', null, 'Thief', 15);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (8,'Mike','Cast divine spells','2010-05-01', null, 'Cleric', 19);





--Insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       --values (1,'John',  'Masters of combat', '2010-01-01', null, 'Fighter',1);

/**insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (1,'Hangry', 1,1);
insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (2,'Happy', 2,2);
insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (3,'Fine', 3,3);
insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (4,'Placid', 4,4);
insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (5,'Raging', 2,5);
insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values (6,'sick', 1,2);
**/

insert into GuestStatus(gueststatusid,gueststatus,guestid,TavernID) values 
(1,'Hangry', 1,1),
(2,'Happy', 2,2),
(3,'Fine', 3,3),
(4,'Placid', 4,4),
(5,'Raging', 2,5),
(6,'sick', 1,2);

INSERT INTO ROOM(id,TavernID) VALUES 
   (1,1),
   (2,1),
   (3,2),
   (4,2),
   (5,3)

INSERT INTO ROOMSTATUS(ID,Status,Roomid) VALUES 
   (1,'Available',1),
   (2,'Occupied',2),
   (3,'Occupied',3),
   (4,'Available',4),
   (5,'Available',5)

INSERT INTO ROOMSTAY(ID,SalesOrderId, GuestId, Room_Id,DateOccupied,Rate) VALUES 
   (1,1,1,1,'2010-02-01',90),
   (2,2,2,2,'2000-02-01',100),
   (3,3,3,3,'1999-02-01',80),
   (4,4,4,4,'1987-02-01',200),
   (5,5,5,5,'2018-02-01',300)
  -- SELECT * FROM ROOMSTAY;

/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ VIEW TABLE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
select * from ROOMSTAY;
select * from ROOMSTATUS;
select * from ROOM;

select * from GuestStatus;
select * from  Guest;

select * from SalesOrderDetails;
select * from SalesOrder;
select * from Customer;

select * from Code;
select * from Inventory;
select * from Item;

select * from PurchaseOrderDetails;
select * from PurchaseOrder;
select * from Supplier;

select * from TavernLoc;

select * from TavernRats;
select * from TavernEmp;
select * from TavernInfo

/* Joined Guest and GuestStatus Table to view the table . Used condition to avoid duplicate */

SELECT distinct gs.[gueststatusid],gs.[gueststatus], g.[guestId],t.[TavernID]
  FROM [TavernDB].[dbo].[GuestStatus] gs
  inner join [TavernDB].[dbo].[Guest] g on gs.guestid = g.guestid
  inner join [TavernDB].[dbo].taverninfo t on gs.tavernid = t.tavernid


  
/*   2.Write a query that returns guests with a birthday before 2000. */
 
 SELECT * FROM Guest WHERE YEAR(birthday) > 2000;

/*   3. Write a query to return rooms that cost more than 100 gold a night */

SELECT * FROM ROOMSTAY WHERE Rate >= 100;

/*   4. Write a query that returns UNIQUE guest names. */

SELECT DISTINCT guestname FROM [dbo].[Guest];

/*  5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col] */

SELECT * FROM Guest ORDER BY guestname ASC;

/*  6. Write a query that returns the top 10 highest price sales */

SELECT top 10 * from SalesOrderDetails ORDER BY Totalprice DESC;


/*7. Write a query to return all Lookup Table Names - this is, not the names of the tables but the Names of things like Status/Role/Class,etc. (w/ Union)*/

/* -- for listing tables
SELECT TABLE_NAME FROM INFORMATION_SCHEMA;
*/

SELECT TavernName FROM TavernInfo
UNION
SELECT Suppliername FROM Supplier
UNION
SELECT CustomerName FROM Customer
UNION
SELECT SalesStatus FROM SalesOrder
UNION
SELECT gueststatus FROM GuestStatus

-----------------------------------------------------------------

/* 8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc) */
--ALTER TABLE Lev_group ADD TavernAddress varchar(100)
--(SELECT class,lev FROM GUEST where 0 < lev <= 10);

SELECT lev, class,
CASE WHEN lev < 11 THEN 'LEV(1-10)'
WHEN lev < 21 THEN 'LEV(11-20)'
ELSE 'LEV(21-30)'
END AS Group_lev
FROM Guest;


/*
SELECT
 CASE
   WHEN
       1 <= lev < 10
	   THEN
	       'LEV(1-10)'
   WHEN 
        11 <= lev < 20
		THEN
		    'LEV(11-20)'
   ELSE
       ' HIGH RANGE'
   END AS LEV_Group 
   FROM 
   Guest;

/* IF 1=1
 BEGIN

 SET @PRINTMESSAGE2 = (SELECT name FROM sys.tables where object_id = 1982630106)*/
DECLARE @lev int;
SET @lev = (SELECT top 1 *, lev from Guest)
SELECT
 CASE lev
   WHEN < 10 THEN 'LEV(1-10)'
   WHEN 
        11 <= lev < 20
		THEN
		    'LEV(11-20)'
   ELSE
       ' HIGH RANGE'
   END AS LEV_Group 
   FROM 
   Guest;

   DECLARE @lev1 int
   SET @lev1 = 0
   SELECT CASE @lev1
           WHEN <10 THEN 'LEV(1-10)'
		   WHEN < 20 THEN 'LEV(11-20)'
		   END
*/

/* 9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements 
(See our lab in class - The INSERT commands should be generated). It�s ok if the data doesn�t match or make sense! :) Remember, INSERT Commands look like: INSERT INTO 
Table1 (column1, column2) VALUES (column1, column2)      */

Create table test
(
lev int,
class varchar(20),
Group_lev varchar(20)
)

Insert into test(lev,class,Group_lev)
SELECT lev,class,
CASE WHEN lev < 11 THEN 'LEV(1-10)'
WHEN lev < 21 THEN 'LEV(11-20)'
ELSE 'LEV(21-30)'
END AS Group_lev
FROM Guest;

select * from test;


--End Of File