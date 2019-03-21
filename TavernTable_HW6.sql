/* Created for: MILES UNIVERSITY, Software Development Bootcamp- DB Class #4
   Created on : Microsoft SQL Server Management Studio 16, Version 13.0.14500.10
   Created Dt : 3/12/19 */

/** REFERENCE: https://baldursgate.fandom.com/wiki/Classes ,
               https://www.udemy.com, 
               https://stackoverflow.com/questions/3156908/using-a-single-common-where-condition-for-union-in-sql
			   https://www.w3schools.com/sql/trymysql.asp?filename=trysql_case
			   https://stackoverflow.com/questions/21824478/reset-identity-seed-after-deleting-records-in-sql-server
    
	NOTES:     Tavern is an establishment for the sale of beer and other drinks to be consumed on the premises, sometimes also serving food.
               A public house for travelers and others; inn.**/


/** DROP DATABASE IF EXISTS TAVERNDB;
    CREATE DATABASE TavernDB;
    GO
    USE TavernDB **/
drop table if exists Level;
drop table if exists Classes;
drop table if exists Users;
drop table if exists Roles;	
Drop table if exists ROOMSTATUS;	
Drop table if exists ROOMSTAY;
Drop table if exists ROOM;
Drop table if exists GuestStatus;
Drop table If exists Guest;
Drop table If exists Services;
Drop table if exists SalesOrderDetails;
Drop table if exists SalesOrder;
Drop table if exists Customer;
Drop table if exists Code;
Drop table if exists Inventory;
Drop table if exists Item;
Drop table if exists PurchaseOrderDetails;
Drop table if exists PurchaseOrder;
Drop table if exists Supplier;
--Drop table if exists TavernLoc;
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


/*create table TavernLoc(
Locid int PRIMARY KEY,
Locname varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
INSERT INTO TavernLoc (Locid, Locname, TavernID)VALUES
(1,'Merchantville, NJ', 1),
(2, ' Marlton, NJ',2),
(3,'CherryHill, NJ',3),
(4,'Riverside, NJ',4),
(5,'Mt Laurel, NJ',5)
	*/

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

CREATE TABLE [dbo].[SalesOrderDetails](
    [SalesOrderId] [int] NOT NULL,
    [ItemId] [int],
    [Unitprice] [int],
    [Quantity] [int],
    [Totalprice] [int],
	[ServiceId] [int]
  );

--Select * from [dbo].[SalesOrderDetails]
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
CREATE TABLE [dbo].[Services](
    [ServiceId] [int] CONSTRAINT [PK_Ser_ServiceId] PRIMARY KEY NOT NULL,
    [ServiceName] [varchar](30) NOT NULL,
    [ServiceAmt] [int] 
)

/**
Created Guest table to keep track of guests- their names, notes about them, birthdays, cakedays,class and levels.
created GuestStatus table to keep tract of gueststatus and guestid
**/
--DROP TABLE GuestStatus;
--DROP TABLE Guest;
CREATE TABLE [dbo].[Guest](
	[guestid] [int] NOT NULL,
	[guestname] [varchar](50) NOT NULL,
	[notes] [varchar](200) NULL,
	[birthday] [date] NOT NULL,
	[cakeday] [date] NULL,
--	[class] [varchar](50) NOT NULL,
	--[lev] [int] NOT NULL,
--	[TavernID] [int] not NULL
) ON [PRIMARY]
GO

ALTER TABLE dbo.Guest ADD CONSTRAINT
	PK_guestid PRIMARY KEY
	(
	[guestid]
	) 

--Select * from Guest;

--select * from GuestStatus

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

Create table Classes(
Classid int constraint [PK_Class_id] PRIMARY KEY IDENTITY(1,1),
Classname varchar(100) NOT NULL CONSTRAINT [UQ_Classes_Classname] Unique (Classname)
);
--select * from classes order by Classid

--delete from classes
--delete from level

--DBCC CHECKIDENT ('classes', RESEED,0);

Create table Level(
Levelid int constraint [PK_Level_Levelid] primary key identity(1,1),
Classid INT NOT NULL CONSTRAINT[FK_LEVEL_Classid] foreign key(Classid) references Classes(Classid),
guestid INT NOT NULL CONSTRAINT[FK_LEVEL_guestid] foreign key(guestid) references Guest(guestid),
guestlevel int not null
)
--Select * from level
/* The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There should be a way to track Room Stays which will 
   contain a sale, guest, room, date it was stayed in and the rate.*/

--drop table ROOM;

CREATE TABLE [dbo].[ROOM](
[Roomid] [INT] CONSTRAINT [PK_ROOM_ID] PRIMARY KEY, 
[TavernID] [int] not NULL
)

--drop table ROOMSTATUS;

CREATE TABLE [dbo].[ROOMSTATUS](
[ID][INT] CONSTRAINT [PK_RStatus_ID] PRIMARY KEY,
[Status] [varchar](50) NOT NULL,
Roomid int constraint [FK_RStatus_Roomid] FOREIGN KEY references [ROOM](Roomid)
)

--DROP TABLE ROOMSTAY;

CREATE TABLE [dbo].[ROOMSTAY](
[ID][INT] CONSTRAINT [PK_RStay_ID] PRIMARY KEY,
--[SOId][INT] CONSTRAINT [FK_RStay_SalesOderId] FOREIGN KEY REFERENCES SalesOrder(SalesOrderId),
--[GId][INT] CONSTRAINT [FK_RStay_GID] FOREIGN KEY REFERENCES Guest(guestid), 
[SalesOrderId][int],
[guestid][int],
[Roomid][INT] CONSTRAINT [FK_RStay_RID] FOREIGN KEY REFERENCES ROOM(Roomid) , 
--[Room_Id][INT],
DateOccupied date default GETDATE(), 
Rate money NOT NULL
)

/*ALTER TABLE [dbo].[ROOMSTAY] ADD CONSTRAINT
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
	 */
ALTER TABLE [dbo].[ROOMSTAY] ADD CONSTRAINT
	FK_RStay_Roomid FOREIGN KEY
	(
	[Roomid]

	) REFERENCES dbo.ROOM
	(
    [Roomid]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	 	 
	 CREATE TABLE [dbo].[Users](
	 [UserId] [INT] CONSTRAINT [PK_User_ID] PRIMARY KEY,
	 [UserName] [VARCHAR](100),
	 [RoleId] [int] 
	 )
	 
	 CREATE TABLE [dbo].[Roles](
	 [RoleId] [tinyint] CONSTRAINT [PK_Role_ID] PRIMARY KEY,
	 [RoleName] [VARCHAR](100),
	 [RoleDescription] [VARCHAR](100) 
	 )
	 
	
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ INSERT VALUES INTO TABLES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors) VALUES 
(1,'Blue Monkey Tavern', 1, 'Maddy', 1),
(2,'Marlton Tavern', 2, 'James',3),
(3,'Farm and Fisherman Tavern', 3, 'Micheal',3),
(4,'Towne Tavern', 4, 'Robert',1),
(5,'Seven Tap-Tavern', 5, 'Phil',3),
(6,'Seven Ravern', 6, 'Murphy',3),
(7,'Otts Tavern', 7, 'Phillips',3),
(8,'Don Tequilla Tavern', 8, 'Joseph',3),
(9,'Voorhees Tvern', 9, 'Mary',3);
GO

UPDATE TavernInfo SET TavernAddress ='1, Merchantville, NJ' WHERE TavernID = 1;
UPDATE TavernInfo SET TavernAddress ='2, Marlton, NJ' WHERE TavernID = 2;
UPDATE TavernInfo SET TavernAddress ='3, CherryHill, NJ' WHERE TavernID = 3;
UPDATE TavernInfo SET TavernAddress ='4, Riverside, NJ' WHERE TavernID = 4;
UPDATE TavernInfo SET TavernAddress ='5, Mt Laurel, NJ' WHERE TavernID = 5;
UPDATE TavernInfo SET TavernAddress ='6, Redrobbinhood, NJ' WHERE TavernID = 6;
UPDATE TavernInfo SET TavernAddress ='7, Merchantville, NJ' WHERE TavernID = 7;
UPDATE TavernInfo SET TavernAddress ='8, North Brunswick, NJ' WHERE TavernID = 8;
UPDATE TavernInfo SET TavernAddress ='9, Voorhees, NJ' WHERE TavernID = 9;

--select * from TavernInfo

INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID) VALUES 
(1, 'John', 'Manager', 1),
(2, 'Maddison', 'Owner', 4),
(3, 'Murphy', 'Server', 1),
(4, 'Jay', 'Server', 5),
(5, 'Jack', 'Doorkeeper', 5),
(6, 'Auggie', 'Server', 3);
GO

INSERT INTO TavernRats (RatID, RatName,FloorNo,TavernID) VALUES
(1, 'Mickey',1, 1),
(2, 'Mouse',1, 2),
(3, 'Cheesy',1, 1),
(4, 'Chelsea',2, 5),
(5, 'Martin',2, 3),
(6, 'King',3, 1),
(7, 'Ratty',2, 2),
(8, 'Mousey',3, 3);
GO

INSERT INTO Supplier (SupplierID, Suppliername, PurchaseOrderId, SupplierAddress, TavernID)VALUES 
(1, 'BeerSupplier', 100, 'Merchantville, NJ', 3),
(2, 'VodkaSupplier',  100,' Marlton, NJ', 1),
(3, 'WineSupplier', 100,'CherryHill, NJ', 1),
(4, 'GinSupplier', 50,'Riverside, NJ', 2),
(5, 'RedwineSupplier', 100,'Mt Laurel, NJ', 5),
(6, 'MargaritaSupplier', 100, 'Lumberton, NJ', 2);
GO

INSERT INTO PurchaseOrder(PurchaseOrderId, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus) VALUES 
(1,'2018-01-21',1,5,200,'PENDING'),
(2, '2018-02-16',2,100,1000,'PENDING'),
(3, '2018-03-20',3,20,10000,'PURCHASED'),
(4, '2018-04-18',4,1000,10000,'PENDING'),
(5,'2018-05-06',5, 10,10000,'PURCHASED'),
(6,'2018-06-21',6,20,20000,'PURCHASED');
GO

INSERT INTO PurchaseOrderDetails(PurchaseOrderID,ItemId,Unitprice,Quantity,Totalprice,PurchaseStatus,TavernID)VALUES 
(1,1,10,12,120,'PENDING', 3),
(2,2,20,6,120,'PENDING',1),
(3,3,30,5, 150,'PURCHASED',1),
(4,4,40,6,240,'PENDING',2),
(5,5,50,2,100,'PURCHASED',5),
(6,6,60,1,60,'PURCHASED',5);
GO

INSERT INTO Item(ItemId,Itemname,Unitprice,UnitOfMeasurement) VALUES
(1,'beer',10,5),
(2,'Redwine',10,10),
(3,'Whitewine',10,6),
(4,'Gin',10,12),
(5,'Margarita',10,2),
(6,'water',10,6);
GO

Insert into Inventory(ItemId,Quantity,UnitOfMeasurement) VALUES
(1,600,24),
(2,500,20),
(3,400,12),
(4,300,10),
(5,200,6),
(6,100,2);

Insert into Code(CodeId, CodeType,Code,CodeDescription) VALUES 
(1,'Status','A','Active'),
(2,'Status','I','InActive'),
(3,'Status','A','Active'),
(4,'Status','I','InActive'),
(5,'Status','I','InActive')
GO

Insert into Customer(CustomerId,CustomerName,CustomerAddress,SalesOrderId,TavernID) VALUES 
(1,'Jason','Lumberton,NJ',1,1),
(2,'JSP','Mt laurel,NJ',21,2),
(3,'Java','Marlton,NJ',11,3),
(4,'SQL','Cherryhill,NJ',31,4),
(5,'Python','Voorhees,NJ',40,5),
(6,'Git','Lumberton,NJ',50,6),
(7,'Servlet','Mt Laurel,NJ',12,7),
(8,'Oracle','Lumberton,NJ',141,8);
GO
--Select * from Customer

Insert into SalesOrder(SalesOrderId,SalesDt,CustomerId,TotalQty,TotalAmt,SalesStatus,TavernID) VALUES 
(1,'2018-01-21',1,60,150,'Active',1),
(2,'2018-01-01',2,90,235,'Active',2),
(3,'2018-11-21',3,70,190,'Active',3),
(4,'2018-06-21',5,30,290,'InActive',1),
(5,'2018-09-21',5,30,290,'Active',1),
(6,'2010-01-01',0,0,0,'InActive',1),
(7,'2010-02-01',0,0,0,'InActive',1),
(8,'2018-02-01',0,0,0,'InActive',1),
(9,'2018-02-01',0,0,0,'InActive',1),
(10,'2010-01-01',5,30,290,'Active',1);
GO
--select * from SalesOrder;

Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,ServiceId) VALUES 
(1,1,2,10,20,0),
(1,3,2,50,100,0),
(1,0,0,0,10,1),
(1,0,0,0,20,2),
(2,1,2,20,40,0),
(2,3,2,50,100,0),
(2,2,3,20,60,0),
(2,0,0,0,10,1),
(2,0,0,0,20,2),
(2,0,0,0,5,5),
(3,2,3,20,60,0),
(3,1,2,50,100,0),
(3,0,0,0,10,1),
(3,0,0,0,20,2),
(4,4,8,10,80,0),
(4,5,9,10,90,0),
(4,0,0,0,10,1),
(4,0,0,0,40,3),
(5,4,8,30,240,0),
(5,0,0,0,50,4);
GO

--Select * from SalesOrderDetails;

INSERT INTO [dbo].[Services] VALUES
(1,'CLEANING', 10),
(2,'CHATTING', 20),
(3,'DANCING', 40),
(4,'SINGING', 50),
(5,'Miscellaneous', 5)
INSERT INTO [dbo].[Services] VALUES
(6,'ROOM_SERVICE', 90)

--select * from Services

/*Insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (1,'John',  'Masters of combat', '2010-01-01', null, 'Fighter',1);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (2,'Scott', 'Cast divine spells', '2010-02-01', '2010-02-01', 'Cleric', 2);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (3,'Aiden', 'Cast arcane spells', '2010-03-01', null, 'Mage', 3);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev)
       values (4,'Micheal','Masters of combat', '2010-04-01', '2010-04-01','Fighter', 1);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (5,'Caleb','Reasonable combat capability','2010-05-01', null, 'Monk', 4);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (6,'Jacob','Reasonable combat capability','2010-05-01', null, 'Sorcerer', 20);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (7,'Ben','Reasonable combat capability','2010-05-01', null, 'Bard', 15);
insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       values (8,'Daniel','Cast divine spells','2010-05-01', null, 'Cleric', 19);
	   */
--Select * from Guest;
--Insert into Guest(guestid,guestname,notes,birthday,cakeday,class,lev) 
       --values (1,'John',  'Masters of combat', '2010-01-01', null, 'Fighter',1);

INSERT INTO GuestStatus(gueststatusid,gueststatus,guestid,TavernID) VALUES
(1,'Hangry', 1,1),
(2,'Happy', 2,2),
(3,'Fine', 3,3),
(4,'Placid', 4,4),
(5,'Raging', 2,5),
(6,'sick', 1,2);
--SELECT * FROM GuestStatus

INSERT INTO Guest(guestid,guestname,notes,birthday,cakeday) VALUES 
 (1,'John',  'Masters of combat', '2010-01-01', null),
 (2,'Scott', 'Cast divine spells', '2010-02-01', '2010-02-01'),
 (3,'Aiden', 'Cast arcane spells', '2010-03-01', null),	   
 (4,'Micheal','Masters of combat', '2010-04-01', '2010-04-01'),	   
 (5,'Caleb','Reasonable combat capability','2010-05-01', null),	   
 (6,'Jacob','Reasonable combat capability','2010-05-01', null),	
 (7,'Ben','Reasonable combat capability','2010-05-01', null),   
 (8,'Daniel','Cast divine spells','2010-05-01', null) ;
 GO

INSERT INTO classes(Classname) VALUES 
('Fighter'),
('Cleric'),
('Mage'),
('Wizard'),
('Monk'),
('Sorcerer'),
('Bard'),
('Drunk'),
('Archer'),
('Warrior');
GO

INSERT INTO level(Classid,guestid,guestlevel) 
VALUES 
(1,1,11),
(1,2,6),
(2,2,12),
(2,2,10),
(3,3,20),
(4,4,14),
(5,5,30),
(6,6,15),
(7,7,25),
(8,8,23)
GO

INSERT INTO ROOM(Roomid,TavernID) VALUES 
(1,1),
(2,1),
(3,2),
(4,2),
(5,3),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1);
--SELECT * from ROOM
UPDATE ROOM SET TavernID = 3 WHERE Roomid = 9 

INSERT INTO ROOMSTATUS(ID,Status,Roomid) VALUES 
(1,'Available',1),
(2,'Occupied',2),
(3,'Occupied',3),
(4,'Available',4),
(5,'Available',5),
(6,'Available',6),
(7,'Available',7),
(8,'Available',8),
(9,'Available',9),
(10,'Occupied',10)

-- select * from ROOMSTATUS

INSERT INTO ROOMSTAY(ID,SalesOrderId, GuestId, Roomid,DateOccupied,Rate) VALUES 
(1,1,1,1,'2010-02-01',90),
(2,2,2,2,'2000-02-01',100),
(3,3,3,3,'1999-02-01',80),
(4,4,4,4,'1987-02-01',200),
(5,5,5,5,'2018-02-01',300),

(6,0,0,6,'2010-01-01',00.00),
(7,0,0,8,'2010-02-01',00.00),
(8,0,0,6,'2018-02-01',00.00),
(9,0,0,7,'2018-02-01',00.00),
(10,8,9,9,'2010-01-01',90.00);

UPDATE ROOMSTAY SET Rate = 89.99 WHERE ID = 10 

-- SELECT * FROM ROOMSTAY;
--  SELECT * from SalesOrder

INSERT INTO [dbo].[Users]([UserId],[UserName],[RoleId]) VALUES 
(1, 'Admin1',1),
(2, 'Developer1',2),
(3, 'FrontLine1',3),
(4, 'Admin2',1),
(5, 'Developer2',2),
(6, 'FrontLine2',3),
(7, 'Admin3',1),
(8, 'Developer3',2),
(9, 'FrontLine3',3);

INSERT INTO [dbo].[Roles]([RoleId],[RoleName],[RoleDescription]) VALUES 
(1, 'Administration','Maintains Admin Works'),
(2, 'Developer','Maintains and fixes bugs in the System'),
(3, 'FrontLine','Uses the system');

--select * from TavernEmp


/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ VIEW TABLE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ */
Select * from Roles;
Select * from Users;

select * from ROOMSTAY;
select * from ROOMSTATUS;
select * from ROOM;

select * from GuestStatus;
select * from  Guest;

Select * from Services;
select * from SalesOrderDetails;
select * from SalesOrder;
select * from Customer;

select * from Code;
select * from Inventory;
select * from Item;

select * from PurchaseOrderDetails;
select * from PurchaseOrder;
select * from Supplier;

--select * from TavernLoc;

select * from TavernRats;
select * from TavernEmp;
select * from TavernInfo
/*#############################################QUERIES###################################################*/
/* Joined Guest and GuestStatus Table to view the table . Used condition to avoid duplicate */

/*SELECT distinct gs.[gueststatusid],gs.[gueststatus], g.[guestId],t.[TavernID]
  FROM [TavernDB].[dbo].[GuestStatus] gs
  inner join [TavernDB].[dbo].[Guest] g on gs.guestid = g.guestid
  inner join [TavernDB].[dbo].taverninfo t on gs.tavernid = t.tavernid
  */

  
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
FROM test;


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
(See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :) Remember, INSERT Commands look like: INSERT INTO 
Table1 (column1, column2) VALUES (column1, column2)      */
/* Changed the guest table ,added class and level table so problem works with previous project version*/
drop table test;
Create table test
(
lev int,
class varchar(20),
Group_lev varchar(20)
)

Insert into test(lev,class,Group_lev) values
(1,1,10),
(1,2,20),
(2,3,40),
(20,4,50),
(13,3,40)

SELECT lev,class,
CASE WHEN lev < 11 THEN 'LEV(1-10)'
WHEN lev < 21 THEN 'LEV(11-20)'
ELSE 'LEV(21-30)'
END AS Group_lev
FROM test;

select * from test;

-----------------------------------------------------------------------------------------------------------------------------------------------
/* DB Class #4 - Assignment
   Created By: Crystal Vu on 03/11/2019 10:11 PM 

1. Write a query to return users who have admin roles 
2. Write a query to return users who have admin roles and information about their taverns 
3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels 
4. Write a query that returns the top 10 sales in terms of sales price and what the services were 
5. Write a query that returns guests with 2 or more classes 
6. Write a query that returns guests with 2 or more classes with levels higher than 5 
7. Write a query that returns guests with ONLY their highest level class 
8. Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them) 

9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it. 

 LAB 
SELECT * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
select * from INFORMATION_SCHEMA.COLUMNS 
select * from INFORMATION_SCHEMA.TABLES 
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 

select sysObj.name, sysCol.name 
from sys.objects sysObj inner join sys.columns sysCol on sysObj.object_id = sysCol.object_id 
where sysCol.is_identity = 1
*/
--------------------------------------------------------------------------------------------------------------------------------------

--1. Write a query to return users who have admin roles 

SELECT U.UserId, U.UserName, R.RoleName,R.RoleId,U.RoleId
FROM Users U JOIN Roles R
ON R.RoleId = U.RoleId AND R.RoleName = 'Administration';
--------------------------------------------------------------------------------------------------------------------------------------
--2. Write a query to return users who have admin roles and information about their taverns 

SELECT U.UserName, R.RoleName, T.TavernName, T.TavernAddress, T.TavernID
FROM Users U JOIN Roles R
ON  R.RoleId = U.RoleId AND R.RoleName = 'Administration'
JOIN TavernInfo T
ON T.TavernID = U.UserId;
---------------------------------------------------------------------------------------------------------------------------------------

--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels 

SELECT guestname ,Classname,guestlevel 
FROM Guest g join Level l on  g.guestid = l.guestid 
join classes c on c.Classid = l.classid
ORDER BY guestname ASC;
------------------------------------------------------------------------------------------------------------------------------------------
--4. Write a query that returns the top 10 sales in terms of sales price and what the services were 

Select top 10 
Case when s.ServiceName is null then i.Itemname
		else s.ServiceName end as Service, Sum(TotalPrice) as Salesprice
FROM SalesOrderDetails o
left join services s on o.ServiceId = s.ServiceId
left join Item i on o.ItemId = i.ItemId
--where o.SalesOrderId = 1
Group By  s.ServiceName, i.Itemname
Order By Salesprice Desc

-------------------------------------------------------------------------------------------------------------------------------------
--5. Write a query that returns guests with 2 or more classes 

Select  g.guestname from guest g 
join level l on g.guestid = l.guestid
join classes c on l.classid = c.classid
group by g.guestname having count(*)  > 1
order by g.guestname;

------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Write a query that returns guests with 2 or more classes with levels higher than 5 

-- select * from level

select g.guestname from guest g
join level l on g.guestid = l.guestid
join classes c on c.classid = l.classid
where l.guestlevel > 5
group by g.guestname having count(*) >= 2
--------------------------------------------------------------------------------------------------------------------------------------------
/*7. Write a query that returns guests with ONLY their highest level class */

select max(guestlevel) as high_level,g.guestname from guest g
join level l on g.guestid = l.guestid
join classes c on c.classid = l.classid
group by guestname

--------------------------------------------------------------------------------------------------------------------------------------------
/*8. Write a query that returns guests that stay within a date range. Please 
remember that guests can stay for more than one night AND not all of the dates 
they stay have to be in that range (just some of them) 
*/
--select * from ROOMSTAY;

Select g.guestname, rs.DateOccupied from guest g
join ROOMSTAY rs ON g.guestid = rs.guestid
where rs.DateOccupied BETWEEN '2000-01-01' AND '2018-01-01'
--------------------------------------------------------------------------------------------------------------------------------------------
/*9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it. */

/*SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'TavernInfo'

 UNION ALL 
 
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, (CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL Then CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') Else '' END), ',') as queryPiece 
FROM INFORMATION_SCHEMA.COLUMNS as cols 
WHERE TABLE_NAME = 'TavernInfo' 

UNION ALL 

SELECT ')'; 
*/
/* Used this select statement " SELECT * FROM sys.tables;" to find the object_id of the table. For examples the object_id for my table Tavern_Info is 1495676376 
  
OUTPUT: GENERATED Without column number

CREATE TABLE TavernInfo(TavernID int,TavernName varchar,TavernLocid int);*/
  
  DECLARE @PRINTMESSAGE2 nvarchar(30), @PRINTMESSAGE4 nvarchar(30), @PRINTMESSAGE3 nvarchar(30),@PRINTMESSAGE5 nvarchar(30),@PRINTMESSAGE6 nvarchar(30),
          @PRINTMESSAGE7 nvarchar(30),@PRINTMESSAGE8 nvarchar(30), @identity nvarchar(20) , @constaint nvarchar(100);
 IF 1=1
 BEGIN

 SET @PRINTMESSAGE2 = (SELECT t.name FROM sys.tables t where t.name = 'TavernInfo')
 SET @PRINTMESSAGE4 = (SELECT name  FROM sys.all_columns where object_id = 1597248745 AND column_id= 1)
 SET @PRINTMESSAGE3 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernID')
 set @identity = 'IDENTITY(1,1)'
 SET @PRINTMESSAGE5 = (SELECT name  FROM sys.all_columns where object_id = 1597248745 AND column_id= 2)
 SET @PRINTMESSAGE6 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernName')
 SET @PRINTMESSAGE7 = (SELECT name  FROM sys.all_columns where object_id = 1597248745 AND column_id= 3)
 SET @PRINTMESSAGE8 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernLocid')
 set @constaint = 'CONSTRAINT [PK_'+@PRINTMESSAGE4+'] PRIMARY KEY CLUSTERED ('+@PRINTMESSAGE4+' ASC )'

 PRINT N'CREATE TABLE ' + @PRINTMESSAGE2 + '(' + CHAR(13) + @PRINTMESSAGE4 +' ' + @PRINTMESSAGE3 +' '+ @identity+ ',' + CHAR(13) + @PRINTMESSAGE5 + ' ' 
       + @PRINTMESSAGE6 + ',' + CHAR(13) + @PRINTMESSAGE7 + ' ' +  @PRINTMESSAGE8 +','+ CHAR(13) + @constaint + char(13)+')' + ';';
 END

--End Of File
/*HOMEWORK_#5
1. Write a query to return a “report” of all users and their roles 
2. Write a query to return all classes and the count of guests that hold those classes 
3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a
 penny - thereby making the new room the cheapest one
Nice and short ;D
*/

--1. Write a query to return a “report” of all users and their roles 
select * from Users
select * from Roles
Select U.UserName, U.UserId, R.RoleId, R.RoleName from Users U 
JOIN Roles R 
on U.RoleId = R. RoleId

/*###########    OUTPUT ###########  
UserName UserId	RoleId RoleName
Admin1	    1	1	Administration
Developer1	2	2	Developer
FrontLine1	3	3	FrontLine
Admin2	    4	1	Administration
Developer2	5	2	Developer
FrontLine2	6	3	FrontLine
Admin3	    7	1	Administration
Developer3	8	2	Developer
FrontLine3	9	3	FrontLine
#################################*/

--2. Write a query to return all classes and the count of guests that hold those classes 

SELECT Classname,count(guestid) as guest_count_class 
FROM Classes JOIN Level
ON  Classes.Classid = Level.Classid
group by Classname

Go
--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. 
--Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
select * from GuestStatus

SELECT guestname ,Classname , guestlevel,
case
   when 
     guestlevel BETWEEN 1 AND 5 THEN 'Beginner'
   when 
     guestlevel BETWEEN 5 AND 10 THEN 'Intermediate'
   when
     guestlevel > 10 THEN 'Expert'
ELSE
   NULL
END AS guestKnowledge
From Classes JOIN Level on Classes.Classid = Level.Classid
JOIN Guest on Guest.guestid = Level.guestid 
ORDER BY guestname asc

/*###########    OUTPUT ###########  
guestname	Classname	guestlevel	guestKnowledge
Aiden	        Mage	      20	Expert
Ben	            Bard          25	Expert
Caleb        	Monk          30	Expert
Daniel	       Drunk	      23	Expert
Jacob	      Sorcerer        15	Expert
John	       Fighter        11	Expert
Micheal	      Wizard          14	Expert
Scott	      Fighter         6	    Intermediate
Scott	      Cleric	     12	    Expert
Scott	      Cleric         10	    Intermediate
#################################*/

--4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)

/*IF OBJECT_ID (N'dbo.Groupinglevel', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.Groupinglevel; 
GO*/

CREATE FUNCTION [dbo].[Groupinglevel](@guestlevel INT) 
RETURNS VARCHAR(20)
AS
  BEGIN
     RETURN
       CASE
         when 
           @guestlevel BETWEEN 1 AND 5 THEN 'Beginner'
         when 
           @guestlevel BETWEEN 5 AND 10 THEN 'Intermediate'
         when
           @guestlevel > 10 THEN 'Expert'
          ELSE
           NULL
    END 
END

SELECT [dbo].[Groupinglevel](20) as Groupinglevel
GO
/*###########    OUTPUT ###########  
Groupinglevel
Expert
#################################*/

--5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 

ALTER table ROOMSTAY alter column
RATE money null

--Solution 1(WIITHOUT USING FUNCTION):

SELECT TavernID,ROOM.Roomid, ROOMSTATUS.Status,ROOMSTAY.DateOccupied as Date
FROM ROOM INNER JOIN ROOMSTATUS
ON ROOM.Roomid = ROOMSTATUS.Roomid 
INNER JOIN ROOMSTAY 
ON ROOMSTAY.Roomid = ROOM.Roomid 
WHERE  DateOccupied = '2010-01-01' AND ROOMSTATUS.Status = 'Available';
GO

--Solution 2(WITHOUT USING FUNCTION):

IF OBJECT_ID (N'dbo.Rooms_Availability', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.Rooms_Availability; 
GO

CREATE FUNCTION [dbo].[Rooms_Availability](@DateOccupied DATE) 
RETURNS TABLE
AS
RETURN
(       
SELECT TavernID,ROOM.Roomid, ROOMSTATUS.Status
FROM ROOM INNER JOIN ROOMSTATUS
ON ROOM.Roomid = ROOMSTATUS.Roomid 
INNER JOIN ROOMSTAY 
ON ROOMSTAY.Roomid = ROOM.Roomid 
WHERE  DateOccupied =@DateOccupied AND ROOMSTATUS.Status = 'Available'
)
GO

SELECT *  FROM dbo.Rooms_Availability('2010-01-01')
GO
/*###########    OUTPUT ###########  
TavernID	Roomid	Status
1	6	Available
3	9	Available
#################################*/
/*
6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their 
   taverns based on price inputs
*/
IF OBJECT_ID (N'dbo.Price_Ranges', N'IF') IS NOT NULL  
   DROP FUNCTION dbo.Price_Ranges; 
GO

CREATE FUNCTION [dbo].[Price_Ranges](@min money, @max money ) 
RETURNS TABLE
AS 
RETURN
(       
SELECT TavernName,ROOM.Roomid,Rate
FROM ROOM 
Join ROOMSTAY ON ROOM.Roomid = ROOMSTAY.Roomid
JOIN ROOMSTATUS ON ROOMSTATUS.Roomid = ROOM.Roomid
JOIN TavernInfo ON TavernInfo.TavernID = ROOM.TavernID
WHERE ROOMSTAY.Rate BETWEEN @min and @max AND ROOMSTATUS.Status = 'Available'
)
GO

SELECT * FROM dbo.Price_Ranges(50,100)
GO

/*###########    OUTPUT ###########  
TavernID	Roomid	Rate
1	        1	    90.00
3	        9	    89.99
#################################*/

/*
7.Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room 
  by a penny - thereby making the new room the cheapest one
  Nice and short ;D */

IF OBJECT_ID (N'dbo.Price_Ranges', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.Price_Ranges; 
GO

CREATE FUNCTION [dbo].[Price_Ranges](@min money, @max money ) 
RETURNS TABLE
AS 
RETURN
(       
SELECT TavernID,ROOM.Roomid,Rate
FROM ROOM 
Join ROOMSTAY ON ROOM.Roomid = ROOMSTAY.Roomid
JOIN ROOMSTATUS ON ROOMSTATUS.Roomid = ROOM.Roomid
WHERE ROOMSTAY.Rate BETWEEN @min and @max AND ROOMSTATUS.Status = 'Available'
)
GO
--Note: Aggregate Function works even if col not in GROUP BY when there is no other col selected.
--SELECT min(Rate)  FROM dbo.Price_Ranges(50,100)

SELECT TavernName,Rate 
FROM dbo.Price_Ranges(50,100)
JOIN TavernInfo ON TavernInfo.TavernID = Price_Ranges.TavernID 
WHERE Rate = (SELECT min(Rate) FROM Price_Ranges(50,100))


/*###########    OUTPUT ###########  
TavernName	                Rate
Farm and Fisherman Tavern	89.99
###################################*/
/*
DB Class #6 - Assignment
Created By: Crystal Vu on 03/18/2019 10:15 PM 

Write a stored procedure that takes a class name and returns all guests that have any levels of that class

Write a stored procedure that takes a guest id and returns the total that guest spent on services

Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level and higher or that level and lower

Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )

Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it

Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, and automatically book the lowest price room with a guest for one day

Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)
*/

--1.Write a stored procedure that takes a class name and returns all guests that have any levels of that class

CREATE PROCEDURE Classes_of_guest
  @classname varchar(30) 
AS
BEGIN
  SELECT guestname, guestlevel, classname 
  from Guest join Level ON Guest.guestid =Level.guestid 
  JOIN Classes ON Classes.Classid = Level.Classid 
  WHERE classname = @classname
END

EXEC Classes_of_guest 'Fighter' 

select * from Classes

--2.Write a stored procedure that takes a guest id and returns the total that guest spent on services
select * from SalesOrderDetails
select * from SalesOrder

CREATE PROCEDURE Guest_services_cost
  @guestid INT
AS
BEGIN
SELECT SUM(Totalprice) 
FROM SalesOrderDetails JOIN SalesOrder ON SalesOrderDetails.SalesOrderid = SalesOrder.SalesOrderid
WHERE Customerid = @guestid AND Serviceid != 0
END

EXEC Guest_services_cost 5

/*SELECT SUM(Totalprice) 
FROM SalesOrderDetails join SalesOrder on SalesOrderDetails.SalesOrderid = SalesOrder.SalesOrderid
Where Customerid = 1 and Serviceid != 0
--Group By Serviceid
*/
----------------------------------------------------------------------------------------------
--3.Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level
--  and higher or that level and lower

drop procedure guest_level_higher
CREATE PROCEDURE guest_level_higher
  @level INT,
  @key varchar(10)
AS
BEGIN
    IF  @Key ='High'
       SELECT guestname,guestlevel FROM Guest JOIN Level ON Guest.guestid = Level.guestid
       WHERE guestlevel >= @level 
    ELSE 
       SELECT guestname,guestlevel FROM Guest JOIN Level ON Guest.guestid = Level.guestid
       WHERE guestlevel <= @level
END
--select * from Level

EXEC guest_level_higher 25, 'High' 

/*SELECT guestname,guestlevel
FROM Guest JOIN Level
ON Guest.guestid = Level.guestid
WHERE guestlevel >= 25
*/
--------------------------------------------------------------------------------------------------------------
--4.Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )

Alter PROCEDURE Delete_tavern
 @TavernID int
 as
BEGIN  

Begin tran

 DELETE TavernInfo where TavernID = @TavernID

 --select @@error 

 IF @@ERROR = 0
   BEGIN
      PRINT 'Commit' 
	  commit
	END
ELSE
   BEGIN
    print 'rollback'
	rollback
   END

END 

EXEC Delete_tavern 10

COMMIT
ROLLBACK T
---------------------------------------------------------------------------------------------------------
--5.Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it
--======================================

INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors,TavernAddress) VALUES 
(10,'ABC Tavern', 1, 'Gaddy', 1,'50,Mt Laurel,NJ')

INSERT INTO GuestStatus(gueststatusid,gueststatus,guestid,TavernID) VALUES
(7,'Hangry', 1,10)

DROP TRIGGER if exists dbo.tr_tavern_delete

CREATE TRIGGER dbo.tr_tavern_delete 
   ON  dbo.taverninfo 
   INSTEAD OF DELETE
AS 
Begin

	Declare @tavernid int

	select @tavernid = deleted.tavernid
	from deleted

	Delete GuestStatus where TavernID = @tavernid
	Delete Customer where TavernID = @tavernid
	Delete PurchaseOrderDetails where TavernID = @tavernid
	Delete SalesOrder where TavernID = @tavernid
	Delete Supplier where TavernID = @tavernid
	Delete TavernEmp where TavernID = @tavernid
	Delete TavernEmp where TavernID = @tavernid
	Delete TavernRats where TavernID = @tavernid
End
GO

DELETE  FROM  TavernInfo
WHERE TavernID = 10

select * from TavernInfo
select * from GuestStatus
-----------------------------------------------------------------------------------------------------------------------------------
--6.Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, 
--and automatically book the lowest price room with a guest for one day
IF OBJECT_ID (N'dbo.Price_Ranges', N'IF') IS NOT NULL  
    DROP FUNCTION dbo.Price_Ranges; 
GO

CREATE FUNCTION [dbo].[Price_Ranges](@min money, @max money ) 
RETURNS TABLE
AS 
RETURN
(       
SELECT TavernID,ROOM.Roomid,Rate
FROM ROOM 
Join ROOMSTAY ON ROOM.Roomid = ROOMSTAY.Roomid
JOIN ROOMSTATUS ON ROOMSTATUS.Roomid = ROOM.Roomid
WHERE ROOMSTAY.Rate BETWEEN @min and @max AND ROOMSTATUS.Status = 'Available'
)
GO
--drop procedure sp_bookroom 

Create procedure sp_bookroom 
@guestid int,
@date date

as
Begin

Declare  
@tavernid int,
@roomid int,
@rate decimal(5,2)

	SELECT @tavernid = a.TavernID, @roomid =a.Roomid, @rate = a.Rate	
	FROM dbo.Price_Ranges(50,100) a
	WHERE Rate = (SELECT min(Rate) FROM Price_Ranges(50,100))

	Update [dbo].[ROOMSTATUS] set status = 'Occupied'
	where [Roomid] = @roomid
	and [Status] = 'Available'

	insert into [dbo].[ROOMSTAY] ([guestid], [Roomid], [DateOccupied], [Rate])
	values (@guestid, @roomid, @date, @rate)

End

EXEC sp_bookroom 10 ,'2010-01-01'


--select * from ROOMSTATUS
--SELECT * FROM ROOMSTAY

alter table [dbo].[ROOMSTAY] alter column [ID] int not null 

DBCC CHECKIDENT ('classes', RESEED,0);
-------------------------------------------------------------------------------------------------------------
--7.Write a trigger that watches for new bookings and adds a new sale for the guest for a service
-- (for free if you can in your schema)


DROP TRIGGER if exists dbo.tr_Room_booking

CREATE TRIGGER dbo.tr_Room_booking ON dbo.ROOMSTAY
FOR INSERT
AS
BEGIN
DECLARE 
@SalesOrderid int,
@Itemid int,
@Serviceid int 

select @SalesOrderid = isnull(max([SalesOrderId]),0) + 1
from  SalesOrder

INSERT INTO SalesOrder(SalesOrderid ,SalesDt, CustomerId,[TotalQty],TotalAmt, SalesStatus, TavernID) 
SELECT @SalesOrderid, getdate(), inserted.guestid, 1, inserted.Rate, 'Active', room.TavernID 
FROM INSERTED 
inner join room on inserted.Roomid = room.Roomid

select @Serviceid
 From Services Where ServiceName = 'ROOM_SERVICE'

select @Itemid = isnull(max([Itemid]),0) + 1
from  Item
INSERT INTO SalesOrderDetails(SalesOrderid ,ItemId, Unitprice,Quantity,Totalprice,Serviceid) 
SELECT @SalesOrderid,@Itemid,90,1,inserted.Rate,@Serviceid 
FROM INSERTED 
inner join room on inserted.Roomid = room.Roomid

END

INSERT INTO ROOMSTAY values(13,13,9,'2018-02-20',89.00)
INSERT INTO ROOMSTAY values(15,15,9,'2019-02-20',70.00)

select * FROM ROOMSTAY
select * from SalesOrder
select * from SalesOrderDetails
select * from Services
SELECT * FROM ITEM

--END OF FILE