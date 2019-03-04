CREATE DATABASE TavernDB
GO
USE TavernDB

Drop table TavernInfo;

create table TavernInfo(			
TavernID int PRIMARY KEY,
TavernName varchar(100),
TavernLocid varchar(100),
TavernOwner varchar(100),
NoOfFloors int 
);

INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (1, 'Blue Monkey Tavern', '1', 'Maddy', 1);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (2, 'Marlton Tavern', '2', 'James',3);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (3, 'Farm and Fisherman Tavern', '3', 'Micheal',3);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (4, 'Towne Tavern', '4', 'Robert',1);
INSERT INTO TavernInfo (TavernID, TavernName, TavernLocid,  TavernOwner, NoOfFloors)
	VALUES (5, 'Seven Tap-Tavern', '5', 'Phil',3);
	
select * from TavernInfo;

Drop table TavernEmp;
	
Create table TavernEmp(	
EmpId int PRIMARY KEY,
EmpName varchar(100),
EmpRole varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID) 		
);

INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (1, 'John', 'Manager', 1)
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (2, 'Maddison', 'Owner', 4)
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (3, 'Murphy', 'Server', 1)
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (4, 'Jay', 'Server', 5)
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (5, 'Jack', 'Doorkeeper', 5)
INSERT INTO TavernEmp (EmpID, EmpName, EmpRole,TavernID)
	VALUES (6, 'Auggie', 'Server', 3)

Drop table TavernRats;
	
create table TavernRats(	
RatId int PRIMARY KEY,
RatName varchar(100),
FloorNo int,
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID) 		
);
--Update TavernRats

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

Select * from TavernRats;
Drop table TavernLoc;

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


Drop table Supplier;

create table Supplier(
SupplierID int PRIMARY KEY,
Suppliername varchar(100),
PurchaseOrderId int,
SupplierAddress varchar(300),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);


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
	
Drop table PurchaseOrder;

create table PurchaseOrder(
PurchaseOrderId int PRIMARY KEY,
PurchaseDt DATE,
SupplierID int,
TotalQty int,
TotalAmt int,
PurchaseStatus varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (1,'2018-01-21',1,5,200,'PENDING', 3)
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (2, '2018-02-16',2,100,1000,'PENDING',1)
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (3, '2018-03-20',3,20,10000,'PURCHASED',1)
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (4, '2018-04-18',4,1000,10000,'PENDING',2)
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (5,'2018-05-06',5, 10,10000,'PURCHASED',5)
INSERT INTO PurchaseOrder(PurchaseOrderID, PurchaseDt, SupplierID, TotalQty,TotalAmt,PurchaseStatus, TavernID)
	VALUES (6,'2018-06-21',6,20,20000,'PURCHASED',6)

Drop table PurchaseOrderDetails;

create table PurchaseOrderDetails(
PurchaseOrderId int PRIMARY KEY,
ItemId int,
Unitprice int,
Quantity int,
Totalprice int,
PurchaseStatus varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

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


Drop table Item;

create table Item(
ItemId int PRIMARY KEY,
Itemname varchar(100),
Unitprice int,
UnitOfMeasurement varchar(100)
);

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

--Drop table Inventory;

create table Inventory(
ItemId int Primary key,
Quantity int,
UnitOfMeasurement varchar(100)
);

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

--Drop table Code;

Create table Code(
CodeId int Primary key,
CodeType  varchar(100),
Code varchar(100),
CodeDescription varchar(100)
);
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

Drop table Customer;

create table Customer(
CustomerId int PRIMARY KEY,
CustomerName varchar(100),
CustomerAddress varchar(100),
SalesOrderId int,
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
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

Drop table SalesOrder;

create table SalesOrder(
SalesOrderId int PRIMARY KEY,
SalesDt date,
CustomerId int,
TotalQty int,
TotalAmt int,
SalesStatus varchar(100),
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);

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


Drop table SalesOrderDetails;

create table SalesOrderDetails(
SalesOrderId int PRIMARY KEY,
ItemId int,
Unitprice int,
Quantity int,
Totalprice int,
TavernID int FOREIGN KEY REFERENCES TavernInfo(TavernID)
);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,TavernID)
values(1,1,2,10,100,1);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,TavernID)
values(2,2,1,20,200,2);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,TavernID)
values(3,2,1,20,200,1);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,TavernID)
values(4,4,4,10,40,1);
Insert into SalesOrderDetails(SalesOrderId,ItemId,Unitprice,Quantity,Totalprice,TavernID)
values(5,4,4,10,40,1);

