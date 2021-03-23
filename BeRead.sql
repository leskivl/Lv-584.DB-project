--DROP DATABASE [BeRead];
--GO
--CREATE DATABASE [BeRead];
--GO

USE [BeRead];
GO
DROP TABLE IF EXISTS [dbo].[CurrencyRates];
GO
CREATE TABLE [CurrencyRates] (
  [CurrencyID] INT PRIMARY KEY IDENTITY(1, 1),
  [Code] NVARCHAR(5) UNIQUE NOT NULL,
  [Rate] DECIMAL(10, 2) NOT NULL,
  [ModifiedDate] DATETIME NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[PaymentTypes];
GO
CREATE TABLE [PaymentTypes] (
  [PaymentTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(20) NOT NULL --cash or card
)
GO
DROP TABLE IF EXISTS [dbo].[Orders];
GO
CREATE TABLE [Orders] (
  [OrderID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [CustomerID] INT,
  [OrderDate] DATETIME NOT NULL,
  [PaymentTypeID] TINYINT NOT NULL,
  [RRN] INT, --bank transaction
  [Amount] DECIMAL NOT NULL,--without discount
  [DiscountID] TINYINT,
  [DiscountAmount] DECIMAL,--with discount
  [DeliveryDepartmentID] INT, -- post
  [BusinessUnitID] INT,		-- self-pickup
  [Comment] NVARCHAR(100)
  -- add column IsReturn BIT ?
);
GO
DROP TABLE IF EXISTS [dbo].[DeliveryTypes];
GO
CREATE TABLE [DeliveryTypes](
  [DeliveryTypeID] TINYINT,
  [DeliveryName] NVARCHAR(50) -- self-pickup or post
)
DROP TABLE IF EXISTS [dbo].[DeliveryDepartments];
GO
CREATE TABLE [DeliveryDepartments] (
  [DeliveryDepartmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [DeliveryTypeID] INT NOT NULL,
  [DeliveryCompanyID] TINYINT,
  [CountryID] INT,
  [Province] TINYINT,
  [CityID] SMALLINT,
  [DepartmentNumber] INT,
  [DepartmentAddress] NVARCHAR(500)
)
DROP TABLE IF EXISTS [dbo].[DeliveryDepartments];
GO
CREATE TABLE [DeliveryCompanies] (
  [DeliveryCompanyID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR (50) NOT NULL -- NovaPoshta, UkrPoshta, FedEx
  
)
--DROP TABLE IF EXISTS [dbo].[ProductReturns];
--GO
--CREATE TABLE ProductReturns(
--  [ProductReturnID] INT PRIMARY KEY IDENTITY(1, 1),
--  [BusinessUnitID] INT NOT NULL,
--  [OrderID] INT NOT NULL,
--  [ReturnStatusID] TINYINT NOT NULL,
--  [ReturnDescription] NVARCHAR(500) ,
--  [DeliveryTypeID] INT ,
--  [DeliveryContryID] INT,
--  [DeliveryCityID] INT,
--  [DeliveryDepartmentID] INT,
--  [DeliveryAddress] NVARCHAR(500),
--  [EmployeeIDOpenedBy] INT NOT NULL,
--  [EmployeeIDModifiedBy] INT ,
--  [CreatedDate] DATETIME NOT NULL,
--  [ModifiedDate] DATETIME
--)
--DROP TABLE IF EXISTS [dbo].[ReturnDetails];
--GO
--CREATE TABLE ReturnDetails (
--  ReturnDetailID INT PRIMARY KEY IDENTITY(1, 1), 
--  ProductReturnID INT NOT NULL,
--  ProductID INT NOT NULL,
--  ReturnTypeID TINYINT NOT NULL,
--  ReturnStatusID TINYINT NOT NULL,
--  ReturnDescription NVARCHAR(500) NOT NULL, 
--  Quantity INT NOT NULL,
--  OrderDetailsID INT NOT NULL,
--  EmployeeIDModifiedBy INT, 
--  ModifiedDATE DATETIME
--)
--DROP TABLE IF EXISTS [dbo].[ReturnStatuses];
--GO
--CREATE TABLE [ReturnStatuses] (
--  [ReturnStatusID] TINYINT PRIMARY KEY IDENTITY(1, 1),
--  [Status] NVARCHAR(50) NOT NULL
--)
--GO
--DROP TABLE IF EXISTS [dbo].[ReturnTypes];
--GO
--CREATE TABLE [ReturnTypes] (
--  [ReturnTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
--  [TypeName] NVARCHAR(50) NOT NULL
--)
--GO

DROP TABLE IF EXISTS [dbo].[OrderDetails];
GO
CREATE TABLE [OrderDetails] (
  [OrderDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [OrderID] INT NOT NULL,
  [ItemID] INT NOT NULL,
  [ItemPrice] DECIMAL (10,2) NOT NULL, -- Items.ItemPrice snapshot
  [Quantity] SMALLINT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[BusinessUnits];
GO
CREATE TABLE [BusinessUnits] ( --only in Ukraine
  [BusinessUnitID] INT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(100),
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [ZipCode] INT NOT NULL,
  [CountryID] TINYINT,
  [ProvinceID] TINYINT,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [Phone] NVARCHAR NOT NULL,
  [IsActive] BIT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Countries];
GO
CREATE TABLE [Countries] (
  [CountryID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Cities];
GO
CREATE TABLE [Cities] (
  [CityID] SMALLINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Provinces];
GO
CREATE TABLE [Provinces] (
  [ProvinceID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) UNIQUE NOT NULL,
  [AdminCenter] SMALLINT
)
GO
DROP TABLE IF EXISTS [dbo].[BusinessUnitTypes];
GO
CREATE TABLE [BusinessUnitTypes] (
  [BusinessUnitTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR NOT NULL -- shop or warehouse
)
GO
DROP TABLE IF EXISTS [dbo].[Stocks];
GO
CREATE TABLE [Stocks] (
  [StockID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [Quantity] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Departments];
GO
CREATE TABLE [Departments] (
  [DepartmentID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] INT UNIQUE NOT NULL --security, HR, etc
)
GO
DROP TABLE IF EXISTS [dbo].[Employees];
GO
CREATE TABLE [Employees] (
  [EmployeeID] INT PRIMARY KEY IDENTITY(1, 1),
  [FirstName] NVARCHAR (50) NOT NULL,
  [LastName] NVARCHAR (50) NOT NULL,
  [HireDate] DATE NOT NULL,
  [TerminationDate] DATE,
  [BusinessUnitID] INT NOT NULL,
  [DepartmentID] TINYINT NOT NULL,
  [ManagerID] INT, -- link to [EmployeeID] INT PRIMARY KEY IDENTITY(1, 1),
  [RoleID] TINYINT NOT NULL,
  [DateOfBirth] DATE NOT NULL,
  [Gender] NVARCHAR(3),
  [IsActive] BIT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[EmployeesDetails];
GO
CREATE TABLE [EmployeeDetails] (
  [EmployeeDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [PassportInfo] NVARCHAR (9) UNIQUE NOT NULL,
  [ZipCode] INT NOT NULL,
  [Province] TINYINT,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [PrimaryPhone] NVARCHAR (12) NOT NULL,
  [SecondaryPhone] NVARCHAR(12),
  [WorkPhone] NVARCHAR(12),
  [Email] NVARCHAR(50)
)
GO
DROP TABLE IF EXISTS [dbo].[Roles];
GO
CREATE TABLE [Roles] (
  [RoleID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL,
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [Description] NVARCHAR(255) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[EmployeeRoleHistories];
GO
CREATE TABLE [EmployeeRoleHistories] (
  [EmployeeRoleHistoryID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [RoleID] TINYINT NOT NULL,
  [StartDate] DATE NOT NULL,
  [EndDate] DATE,
  [Salary] DECIMAL(8,2) NOT NULL,
  [IsActive] BIT NOT NULL,
  [ModifiedDate] DATE
)
GO
DROP TABLE IF EXISTS [dbo].[Vendors];
GO
CREATE TABLE [Vendors] (
  [VendorID] INT PRIMARY KEY IDENTITY (1, 1),
  [VendorCode] bigINT NOT NULL,
  [Iban] NVARCHAR(29) NOT NULL,
  [CountryID] TINYINT NOT NULL,
  [ZipCode] INT NOT NULL,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [PrimaryPhone] NVARCHAR (12) NOT NULL,
  [WorkPhone] NVARCHAR (12),
  [IsActive] BIT
)
GO
DROP TABLE IF EXISTS [dbo].[Customers];
GO
CREATE TABLE [Customers] (
  [CustomerID] INT PRIMARY KEY IDENTITY (1, 1),
  [FirstName] NVARCHAR(50) NOT NULL,
  [MiddleName] NVARCHAR(50),
  [LastName] NVARCHAR(50) NOT NULL,
  [ZipCode] INT NOT NULL,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [PrimaryPhone] NVARCHAR(12) NOT NULL,
  [WorkPhone] NVARCHAR(12),
  [DiscountID] TINYINT NOT NULL,
  [AmountSpend] DECIMAL (10, 2)
)
GO
DROP TABLE IF EXISTS [dbo].[Discounts];
GO
CREATE TABLE [Discounts] (
  [DiscountID] TINYINT PRIMARY KEY IDENTITY (1,1),
  [Percent] DECIMAL(4,2) NOT NULL, --discount in percents
  [AmountSpend] DECIMAL (10, 2) NOT NULL --from what sum discount is active
)
GO
DROP TABLE IF EXISTS [dbo].[Consignments];
GO
CREATE TABLE [Consignments] (
  [ConsignmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [ConsignmentNumber] INT NOT NULL,
  [ConsignmentDate] DATE NOT NULL,
  [PurchaseOrderID] INT NOT NULL,
  [VendorID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [EmployeeID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[ConsignmentDetails];
GO
CREATE TABLE [ConsignmentDetails] (
  [ConsignmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ConsignmentID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [ProductPrice] DECIMAL NOT NULL,
  [CurrencyID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[ShipmentDetails];
GO
CREATE TABLE [ShipmentDetails] (
  [ShipmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ShipmentID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [ProductPrice] DECIMAL NOT NULL,
  [CurrencyID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Shipments];
GO
CREATE TABLE [Shipments] (
  [ShipmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [ShipmentDocumentNumber] INT NOT NULL,
  [ShipmentDocumentDate] DATE NOT NULL,
  [BusinessUnitIDFrom] INT NOT NULL,
  [BusinessUnitIDTo] INT NOT NULL,
  [EmployeeID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[PurchaseOrders];
GO
CREATE TABLE [PurchaseOrders] (
  [PurchaseOrderID] INT PRIMARY KEY,
  [VendorID] INT NOT NULL,
  [DateOfPlacement] DATE NOT NULL,
  [EmployeeID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[PurchaseOrderDetails];
GO
CREATE TABLE [PurchaseOrderDetails] (
  [PurchaseOrderDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [PurchaseOrderID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [ProductPrice] DECIMAL NOT NULL,
  [CurrencyID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Categories];
GO
CREATE TABLE [Categories] (
  [CategoryID] INT PRIMARY KEY,
  [Name] varchar(50) UNIQUE NOT NULL,
  [Description] varchar(1000)
)
GO
DROP TABLE IF EXISTS [dbo].[Subcategories];
GO
CREATE TABLE [Subcategories] (
  [SubcategoryID] INT PRIMARY KEY,
  [CategoryID] INT NOT NULL,
  [Name] varchar(50) NOT NULL,
  [Description] varchar(1000)
)
GO
DROP TABLE IF EXISTS [dbo].[Items];
GO
CREATE TABLE [Items] (
  [ItemID] INT NOT NULL,
  [SubcategoryID] INT NOT NULL,
  [Title] varchar(500) UNIQUE NOT NULL,
  [Description] NVARCHAR(max),
  [PublisherID] INT,
  [ConsignmentID] INT NOT NULL,
  [AuthorID] INT,
  [LanguageID] INT NOT NULL,
  [CoverTypeID] INT,
  [Year] DATE NOT NULL,
  [AgeRestrictionID] varchar(10) UNIQUE,
  [ISBN] bigINT UNIQUE NOT NULL,
  [Pages] INT,
  [Issue] varchar(10),
  [CreateData] DATE NOT NULL,
  [ModifiedData] DATE NOT NULL,
  [GanreID] NVARCHAR(255)
)
GO
DROP TABLE IF EXISTS [dbo].[Authors];
GO
CREATE TABLE [Authors] (
  [AuthorID] INT PRIMARY KEY,
  [FirstName] NVARCHAR(255) NOT NULL,
  [MiddleName] NVARCHAR(255),
  [LastName] NVARCHAR(255) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Publishers];
GO
CREATE TABLE [Publishers] (
  [PublisherID] INT PRIMARY KEY,
  [PublisherName] varchar(500) NOT NULL,
  [PublisherCity] varchar(255) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Languages];
GO
CREATE TABLE [Languages] (
  [LanguageID] INT PRIMARY KEY,
  [Name] NVARCHAR(100) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[ItemPublishers];
GO
CREATE TABLE [ItemPublishers] (
  [ItemID] INT PRIMARY KEY,
  [PublisherID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[AuthorItems];
GO
CREATE TABLE [AuthorItems] (
  [AuthorID] INT PRIMARY KEY,
  [ItemID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[ItemLanguages];
GO
CREATE TABLE [ItemLanguages] (
  [ItemID] INT,
  [LanguageID] INT,
  PRIMARY KEY ([ItemID], [LanguageID])
)
GO
DROP TABLE IF EXISTS [dbo].[CoverTypes];
GO
CREATE TABLE [CoverTypes] (
  [CoverTypeID] INT NOT NULL,
  [Name] varchar(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [dbo].[Genres];
GO
CREATE TABLE [Genres] (
  [GenreID] INT,
  [Name] varchar (50)
)
GO
DROP TABLE IF EXISTS [dbo].[ItemGenres];
GO
CREATE TABLE [ItemGenres] (
  [GenreID] INT NOT NULL,
  [ItemID] INT
)
GO
----------------------------------------------
--
--ALTER TABLE [dbo].[Provinces]  WITH CHECK ADD  CONSTRAINT [FK_Provinces_Cities] FOREIGN KEY([AdminCenter])
--REFERENCES [dbo].[Cities] ([CityID])
--GO
--ALTER TABLE [dbo].[BusinessUnits]  WITH CHECK ADD  CONSTRAINT [FK_BusinessUnits_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
--REFERENCES [dbo].[BusinessUnitTypes] ([BusinessUnitTypeID])
--GO
--ALTER TABLE [dbo].[BusinessUnits]  WITH CHECK ADD  CONSTRAINT [FK_BusinessUnits_Cities] FOREIGN KEY([CityID])
--REFERENCES [dbo].[Cities] ([CityID])
--GO
--ALTER TABLE [dbo].[BusinessUnits]  WITH CHECK ADD  CONSTRAINT [FK_BusinessUnits_Provinces] FOREIGN KEY([ProvinceID])
--REFERENCES [dbo].[Provinces] ([ProvinceID])
--GO
--ALTER TABLE [dbo].[EmpRolesHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmpRolesHistory_Employees] FOREIGN KEY([EmployeeID])
--REFERENCES [dbo].[Employees] ([EmployeeID])
--GO
--ALTER TABLE [dbo].[EmpRolesHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmpRolesHistory_Roles] FOREIGN KEY([RoleID])
--REFERENCES [dbo].[Roles] ([RoleID])
--GO
--ALTER TABLE [dbo].[EmployeesDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmployeesDetails_Employees] FOREIGN KEY([EmployeeID])
--REFERENCES [dbo].[Employees] ([EmployeeID])
--GO
--ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees1] FOREIGN KEY([ManagerID])
--REFERENCES [dbo].[Employees] ([EmployeeID])
--GO
--ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Roles] FOREIGN KEY([RoleID])
--REFERENCES [dbo].[Roles] ([RoleID])
--GO
--ALTER TABLE [dbo].[EmployeesDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmployeesDetails_Cities] FOREIGN KEY([CityID])
--REFERENCES [dbo].[Cities] ([CityID])
--GO
--ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
--REFERENCES [dbo].[BusinessUnitTypes] ([BusinessUnitTypeID])
--GO
--ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
--REFERENCES [dbo].[BusinessUnitTypes] ([BusinessUnitTypeID])
--GO
--ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD  CONSTRAINT [FK_Stocks_BusinessUnits] FOREIGN KEY([BusinessUnitID])
--REFERENCES [dbo].[BusinessUnits] ([BusinessUnitID])
--GO
--ALTER TABLE [dbo].[Vendors]  WITH CHECK ADD  CONSTRAINT [FK_Vendors_Cities] FOREIGN KEY([CityID])
--REFERENCES [dbo].[Cities] ([CityID])
--GO
--ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Cities] FOREIGN KEY([CityID])
--REFERENCES [dbo].[Cities] ([CityID])
--GO
--ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Discounts] FOREIGN KEY([DiscountID])
--REFERENCES [dbo].[Discounts] ([DiscountID])
--GO