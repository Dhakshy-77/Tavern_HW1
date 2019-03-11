  
/* Used this select statement " SELECT * FROM sys.tables;" to find the object_id of the table. For examples the object_id for my table Tavern_Info is 1495676376 
  
OUTPUT: GENERATED Without column number

CREATE TABLE TavernInfo(TavernID int,TavernName varchar,TavernLocid int);*/
  
  DECLARE @PRINTMESSAGE2 nvarchar(30), @PRINTMESSAGE4 nvarchar(30), @PRINTMESSAGE3 nvarchar(30),@PRINTMESSAGE5 nvarchar(30),@PRINTMESSAGE6 nvarchar(30),
          @PRINTMESSAGE7 nvarchar(30),@PRINTMESSAGE8 nvarchar(30);
 IF 1=1
 BEGIN

 SET @PRINTMESSAGE2 = (SELECT name FROM sys.tables where object_id = 1495676376)
 SET @PRINTMESSAGE4 = (SELECT name  FROM sys.all_columns where object_id = 1495676376 AND column_id= 1)
 SET @PRINTMESSAGE3 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernID')
 SET @PRINTMESSAGE5 = (SELECT name  FROM sys.all_columns where object_id = 1495676376 AND column_id= 2)
 SET @PRINTMESSAGE6 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernName')
 SET @PRINTMESSAGE7 = (SELECT name  FROM sys.all_columns where object_id = 1495676376 AND column_id= 3)
 SET @PRINTMESSAGE8 = (Select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TavernInfo' AND COLUMN_NAME='TavernLocid')
 PRINT N'CREATE TABLE ' + @PRINTMESSAGE2 + '(' + CHAR(13) + @PRINTMESSAGE4 +' ' + @PRINTMESSAGE3 + ',' + CHAR(13) + @PRINTMESSAGE5 + ' ' 
       + @PRINTMESSAGE6 + ',' + CHAR(13) + @PRINTMESSAGE7 + ' ' +  @PRINTMESSAGE8 + CHAR(13) + ')' + ';';
 END

