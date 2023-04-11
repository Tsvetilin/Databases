USE master
GO
if exists (select * from sysdatabases where name='pc')
	DROP DATABASE pc
GO

CREATE DATABASE pc
GO
USE pc
GO

CREATE TABLE laptop(
 code int NOT NULL, 
 model varchar(4) NOT NULL, 
 speed decimal(4, 0) NOT NULL,
 ram decimal(4, 0) NOT NULL, 
 hd decimal(3, 0) NOT NULL, 
 price float NOT NULL,
 screen int NOT NULL);
 
 CREATE TABLE pc(
  code int NOT NULL ,
  model varchar(4) NOT NULL ,
  speed decimal(4, 0) NOT NULL ,
  ram decimal(4, 0) NOT NULL ,
  hd decimal(3, 0) NOT NULL ,
  cd varchar(3) NOT NULL ,
  price float NOT NULL 
);

CREATE TABLE product(
  maker char(1) NOT NULL ,
  model varchar(4) NOT NULL ,
  type varchar(7) NOT NULL 
);

CREATE TABLE printer(
  code int NOT NULL ,
  model varchar(4) NOT NULL ,
  color char(1) NOT NULL ,
  type varchar(6) NOT NULL ,
  price float NOT NULL 
);

ALTER TABLE laptop ADD CONSTRAINT PK_laptop PRIMARY KEY(code); 

ALTER TABLE pc ADD CONSTRAINT PK_pc PRIMARY KEY(code);

ALTER TABLE product ADD	CONSTRAINT PK_product PRIMARY KEY (model);

ALTER TABLE printer ADD CONSTRAINT PK_printer PRIMARY KEY(code);

ALTER TABLE laptop ADD CONSTRAINT FK_laptop_product FOREIGN KEY(model) REFERENCES product(model);

ALTER TABLE pc ADD	CONSTRAINT FK_pc_product FOREIGN KEY(model) REFERENCES product(model);

ALTER TABLE printer ADD	CONSTRAINT FK_printer_product FOREIGN KEY(model) REFERENCES product(model);

----Product------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
insert into product values('B','1121','PC');
insert into product values('A','1232','PC');
insert into product values('A','1233','PC');
insert into product values('E','1260','PC');
insert into product values('A','1276','Printer');
insert into product values('D','1288','Printer');
insert into product values('A','1298','Laptop');
insert into product values('C','1321','Laptop');
insert into product values('A','1401','Printer');
insert into product values('A','1408','Printer');
insert into product values('D','1433','Printer');
insert into product values('E','1434','Printer');
insert into product values('B','1750','Laptop');
insert into product values('A','1752','Laptop');
insert into product values('E','2111','PC');
insert into product values('E','2112','PC');
----PC------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
insert into pc values(1,'1232',500,64,5,'12x',600);
insert into pc values(2,'1121',750,128,14,'40x',850);
insert into pc values(3,'1233',500,64,5,'12x',600);
insert into pc values(4,'1121',600,128,14,'40x',850);
insert into pc values(5,'1121',600,128,8,'40x',850);
insert into pc values(6,'1233',750,128,20,'50x',950);
insert into pc values(7,'1232',500,32,10,'12x',400);
insert into pc values(8,'1232',450,64,8,'24x',350);
insert into pc values(9,'1232',450,32,10,'24x',350);
insert into pc values(10,'1260',500,32,10,'12x',350);
insert into pc values(11,'1233',900,128,40,'40x',980);
----Laptop------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
insert into laptop values(1,'1298',350,32,4,700,11);
insert into laptop values(2,'1321',500,64,8,970,12);
insert into laptop values(3,'1750',750,128,12,1200,14);
insert into laptop values(4,'1298',600,64,10,1050,15);
insert into laptop values(5,'1752',750,128,10,1150,14);
insert into laptop values(6,'1298',450,64,10,950,12);
----Printer------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
insert into printer values(1,'1276','n','Laser',400);
insert into printer values(2,'1433','y','Jet',270);
insert into printer values(3,'1434','y','Jet',290);
insert into printer values(4,'1401','n','Matrix',150);
insert into printer values(5,'1408','n','Matrix',270);
insert into printer values(6,'1288','n','Laser',400);
