--DROP DATABASE BeRead;
--GO
--CREATE DATABASE BeRead;
--GO

USE BeRead;
GO

CREATE SCHEMA Address;
GO

CREATE SCHEMA Item;
GO

CREATE SCHEMA Purchase;
GO

CREATE SCHEMA Sales;
GO

CREATE SCHEMA Employee;
GO

CREATE SCHEMA Unit;
GO

DROP TABLE IF EXISTS [Purchase].[CurrencyRates];
GO
CREATE TABLE [Purchase].[CurrencyRates] (
  [CurrencyID] INT PRIMARY KEY IDENTITY(1, 1),
  [Code] NVARCHAR(5) UNIQUE NOT NULL,
  [Rate] DECIMAL(10, 2) NOT NULL,
  [ModifiedDate] DATETIME NOT NULL
)
GO
DROP TABLE IF EXISTS [Sales].[PaymentTypes];
GO
CREATE TABLE [Sales].[PaymentTypes] (
  [PaymentTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(20) NOT NULL --cash or card
)
GO

DROP TABLE IF EXISTS [Sales].[Orders];
GO
CREATE TABLE [Sales].[Orders] (
  [OrderID] BIGINT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [CustomerID] INT,
  [Date] DATETIME NOT NULL,
  [PaymentTypeID] TINYINT NOT NULL,
  [RRN] BIGINT, --bank transaction
  [DeliveryDepartmentID] INT, -- post
  [BusinessUnitID] INT	-- self-pickup
);
GO

DROP TABLE IF EXISTS [Sales].[OrderDetails];
GO
CREATE TABLE [Sales].[OrderDetails] (
  [OrderDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [OrderID] INT NOT NULL,
  [ItemID] INT NOT NULL,
  [ItemPrice] DECIMAL (10,2) NOT NULL, -- Items.ItemPrice snapshot
  [Quantity] SMALLINT NOT NULL,
  [IsReturn] BIT NOT NULL
)
GO

DROP TABLE IF EXISTS [Address].[DeliveryTypes];
GO
CREATE TABLE [Address].[DeliveryTypes](
  [DeliveryTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) -- self-pickup or post
)
DROP TABLE IF EXISTS [Address].[DeliveryDepartments];
GO
CREATE TABLE [Address].[DeliveryDepartments] (
  [DeliveryDepartmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [DeliveryTypeID] TINYINT NOT NULL,
  [DeliveryCompanyID] TINYINT,
  [CityID] SMALLINT,
  [DepartmentNumber] INT,
  [DepartmentAddress] NVARCHAR(500)
)
DROP TABLE IF EXISTS [Address].[DeliveryCompanies];
GO
CREATE TABLE [Address].[DeliveryCompanies] (
  [DeliveryCompanyID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR (50) NOT NULL -- NovaPoshta, UkrPoshta, FedEx
  
)

DROP TABLE IF EXISTS [Unit].[BusinessUnits];
GO
CREATE TABLE [Unit].[BusinessUnits] ( --only in Ukraine
  [BusinessUnitID] INT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(100),
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [ZipCode] INT NOT NULL,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [Phone] NVARCHAR NOT NULL)
GO
DROP TABLE IF EXISTS [Address].[Countries];
GO
CREATE TABLE [Address].[Countries] (
  [CountryID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [Address].[Cities];
GO
CREATE TABLE [Address].[Cities] (
  [CityID] SMALLINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [Unit].[BusinessUnitTypes];
GO
CREATE TABLE [Unit].[BusinessUnitTypes] (
  [BusinessUnitTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(10) NOT NULL -- shop or warehouse
)
GO
DROP TABLE IF EXISTS [Purchase].[Stocks];
GO
CREATE TABLE [Purchase].[Stocks] (
  [StockID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [Quantity] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [Employee].[Departments];
GO
CREATE TABLE [Employee].[Departments] (
  [DepartmentID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(MAX) NOT NULL --security, HR, etc
)
GO
DROP TABLE IF EXISTS [Employee].[Employees];
GO
CREATE TABLE [Employee].[Employees] (
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
DROP TABLE IF EXISTS [Employee].[EmployeeDetails];
GO
CREATE TABLE [Employee].[EmployeeDetails] (
  [EmployeeDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [PassportInfo] NVARCHAR (9) UNIQUE NOT NULL,
  [ZipCode] INT NOT NULL,
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
DROP TABLE IF EXISTS [Employee].[Roles];
GO
CREATE TABLE [Employee].[Roles] (
  [RoleID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL,
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [Description] NVARCHAR(255) NOT NULL
)
GO
DROP TABLE IF EXISTS [Employee].[EmployeeRoleHistories];
GO
CREATE TABLE [Employee].[EmployeeRoleHistories] (
  [EmployeeRoleHistoryID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [RoleID] TINYINT NOT NULL,
  [StartDate] DATE NOT NULL,
  [EndDate] DATE,
  [IsActive] BIT NOT NULL,
)
GO
DROP TABLE IF EXISTS [Employee].[EmployeeSalaryHistories];
GO
CREATE TABLE [Employee].[EmployeeSalaryHistories] (
  [EmployeeRoleHistoryID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [Salary] DECIMAL(8,2) NOT NULL,
  [StartDate] DATE NOT NULL,
  [EndDate] DATE,
  [IsActive] BIT NOT NULL,
)
GO
DROP TABLE IF EXISTS [Purchase].[Vendors];
GO
CREATE TABLE [Purchase].[Vendors] (
  [VendorID] INT PRIMARY KEY IDENTITY (1, 1),
  [VendorCode] BIGINT NOT NULL,
  [Name] NVARCHAR(50) NOT NULL,
  [Iban] NVARCHAR(29) NOT NULL,
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
DROP TABLE IF EXISTS [Sales].[Accounts];
GO
CREATE TABLE [Sales].[Accounts] (
  AccountID INT PRIMARY KEY IDENTITY(1,1),
  UserLogin  NVARCHAR(20) UNIQUE NOT NULL,
  UserPassword NVARCHAR(10) NOT NULL,
  ModifiedDate DATETIME NOT NULL
)
DROP TABLE IF EXISTS [Sales].[Customers];
GO

CREATE TABLE [Sales].[Customers] (
  [CustomerID] INT PRIMARY KEY IDENTITY (1, 1),
  [FirstName] NVARCHAR(50) NOT NULL,
  [MiddleName] NVARCHAR(50),
  [LastName] NVARCHAR(50) NOT NULL,
  [AccountID] INT,
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
DROP TABLE IF EXISTS [Sales].[Discounts];
GO
CREATE TABLE [Sales].[Discounts] (
  [DiscountID] TINYINT PRIMARY KEY IDENTITY (1,1),
  [Percentage] DECIMAL(4,2) NOT NULL, --discount in percents
  [AmountSpend] DECIMAL (10, 2) NOT NULL --from what sum discount is active
)
GO
DROP TABLE IF EXISTS [Purchase].[Consignments];
GO
CREATE TABLE [Purchase].[Consignments] (
  [ConsignmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [Number] INT NOT NULL,
  [Date] DATE NOT NULL,
  [VendorID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [EmployeeID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [Purchase].[ConsignmentDetails];
GO
CREATE TABLE [Purchase].[ConsignmentDetails] (
  [ConsignmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ConsignmentID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [PurchasePrice] DECIMAL (10,2) NOT NULL,
  [CurrencyID] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [Purchase].[ShipmentDetails];
GO
CREATE TABLE [Purchase].[ShipmentDetails] (
  [ShipmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ShipmentID] INT NOT NULL,
  [Quantity] INT NOT NULL
)
GO
DROP TABLE IF EXISTS [Purchase].[Shipments];
GO
CREATE TABLE [Purchase].[Shipments] (
  [ShipmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [Number] INT NOT NULL,
  [Date] DATE NOT NULL,
  [BusinessUnitIDFrom] INT NOT NULL,
  [BusinessUnitIDTo] INT NOT NULL,
  [EmployeeIDFrom] INT NOT NULL,
  [EmployeeIDTo] INT NOT NULL
)
GO

DROP TABLE IF EXISTS [Item].[Items];
GO
CREATE TABLE [Item].[Items](
	[ItemID] INT PRIMARY KEY IDENTITY(1,1),
	[SubcategoryID] TINYINT NOT NULL,
	[Title] NVARCHAR (500) NOT NULL,
	[Description] NVARCHAR(MAX),
	[CoverTypeID] TINYINT,
	[GenreID] TINYINT,
	[Year] NVARCHAR(7) NOT NULL,
	[AgeRestriction] NVARCHAR(10) ,
	[ISBN] NVARCHAR (50) NOT NULL,
	[Pages] SMALLINT,
	[Issue] NVARCHAR(10),
	[CreateDate] DATE NOT NULL
)
GO
DROP TABLE IF EXISTS [Item].[PriceHistories];
GO
CREATE TABLE [Item].[PriceHistories](
	[PriceHistoryID] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ConsignmentID] INT NOT NULL,
	[ItemID] INT NOT NULL,
	[Price] DECIMAL(10, 2) NOT NULL,
	[SetDate] DATE NOT NULL,
	[ModifiedDate] DATE,
	[IsActive] BIT NOT NULL -- MAX price from different [Consignments]
)
GO
DROP TABLE IF EXISTS [Item].[Categories];
GO
CREATE TABLE [Item].[Categories](
	[CategoryID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(500)
);
GO
DROP TABLE IF EXISTS [Item].[Subcategories];
GO
CREATE TABLE [Item].[Subcategories](
	[SubcategoryID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[CategoryID] TINYINT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(500)
);
GO
DROP TABLE IF EXISTS [Item].[Publishers];
GO
CREATE TABLE [Item].[Publishers](
	[PublisherID] SMALLINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(500) NOT NULL,
	[CityID] SMALLINT
)
GO
DROP TABLE IF EXISTS [Item].[Authors];
GO
CREATE TABLE [Item].[Authors](
	[AuthorID] INT PRIMARY KEY IDENTITY(1,1),
	[LastName] NVARCHAR(50) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [Item].[Genres];
GO
CREATE TABLE [Item].[Genres](
	[GenreID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50)
)
GO
DROP TABLE IF EXISTS [Item].[CoverTypes];
GO
CREATE TABLE [Item].[CoverTypes](
	[CoverTypeID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [Item].[Languages];
GO
CREATE TABLE [Item].[Languages](
	[LanguageID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)
GO
DROP TABLE IF EXISTS [Item].[PublishingHouses];
GO
CREATE TABLE [Item].[PublishingHouses](
	[ItemID] INT NOT NULL,
	[PublisherID] SMALLINT NOT NULL,
	CONSTRAINT PK_PublishingHouses PRIMARY KEY ([ItemID],[PublisherID])
)
GO
DROP TABLE IF EXISTS [Item].[Authorships];
GO
CREATE TABLE [Item].[Authorships](
	[ItemID] INT NOT NULL,
	[AuthorID] INT NOT NULL,
	CONSTRAINT PK_Authorships PRIMARY KEY ([ItemID],[AuthorID])
)
GO

DROP TABLE IF EXISTS [Item].[LingusticDescriptions];
GO
CREATE TABLE [Item].[LingusticDescriptions](
	[LingusticDescriptionID] INT PRIMARY KEY IDENTITY(1,1),
	[ItemID] INT NOT NULL,
	[LanguageID] TINYINT NOT NULL
)
GO
----------------------------------------------

ALTER TABLE [Unit].[BusinessUnits]  WITH CHECK ADD  CONSTRAINT [FK_BusinessUnits_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
REFERENCES [Unit].[BusinessUnitTypes] ([BusinessUnitTypeID])
GO
ALTER TABLE [Unit].[BusinessUnits]  WITH CHECK ADD  CONSTRAINT [FK_BusinessUnits_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
GO
ALTER TABLE [Employee].[EmployeeRoleHistories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeRoleHistories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Employee].[EmployeeRoleHistories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeRoleHistories_Roles] FOREIGN KEY([RoleID])
REFERENCES [Employee].[Roles] ([RoleID])
GO
ALTER TABLE [Employee].[EmployeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetails_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Employee].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees1] FOREIGN KEY([ManagerID])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Employee].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Roles] FOREIGN KEY([RoleID])
REFERENCES [Employee].[Roles] ([RoleID])
GO
ALTER TABLE [Employee].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Employee].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Departments] FOREIGN KEY([DepartmentID])
REFERENCES [Employee].[Departments] ([DepartmentID])
GO
ALTER TABLE [Employee].[EmployeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetails_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
ALTER TABLE [Employee].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
REFERENCES [Unit].[BusinessUnitTypes] ([BusinessUnitTypeID])
GO
ALTER TABLE [Purchase].[Stocks]  WITH CHECK ADD  CONSTRAINT [FK_Stocks_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Purchase].[Vendors]  WITH CHECK ADD  CONSTRAINT [FK_Vendors_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
ALTER TABLE [Sales].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
ALTER TABLE [Sales].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [Sales].[Discounts] ([DiscountID])
GO
--ALTER TABLE [Sales].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Countries] FOREIGN KEY([CountryID])
--REFERENCES [Address].[Countries] ([CountryID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [Sales].[Customers] ([CustomerID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_DeliveryDepartments] FOREIGN KEY([DeliveryDepartmentID])
REFERENCES [Address].[DeliveryDepartments] ([DeliveryDepartmentID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [Sales].[Discounts] ([DiscountID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PaymentTypes] FOREIGN KEY([PaymentTypeID])
REFERENCES [Sales].[PaymentTypes] ([PaymentTypeID])
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [Sales].[Orders] ([OrderID])
GO
ALTER TABLE [Sales].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Accounts] FOREIGN KEY([AccountID])
REFERENCES [Sales].[Accounts] ([AccountID])
GO
ALTER TABLE [Purchase].[ConsignmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_ConsignmentDetails_Consignments] FOREIGN KEY([ConsignmentID])
REFERENCES [Purchase].[Consignments] ([ConsignmentID])
GO
ALTER TABLE [Purchase].[ConsignmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_ConsignmentDetails_CurrencyRates] FOREIGN KEY([CurrencyID])
REFERENCES [Purchase].[CurrencyRates] ([CurrencyID])
GO
ALTER TABLE [Purchase].[Consignments]  WITH CHECK ADD  CONSTRAINT [FK_Consignments_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Purchase].[Consignments]  WITH CHECK ADD  CONSTRAINT [FK_Consignments_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Purchase].[Consignments]  WITH CHECK ADD  CONSTRAINT [FK_Consignments_Vendors] FOREIGN KEY([VendorID])
REFERENCES [Purchase].[Vendors] ([VendorID])
GO
ALTER TABLE [Item].[PriceHistories]  WITH CHECK ADD  CONSTRAINT [FK_PriceHistories_Consignments] FOREIGN KEY([ConsignmentID])
REFERENCES [Purchase].[Consignments] ([ConsignmentID])
GO
ALTER TABLE [Purchase].[ConsignmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_ConsignmentDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
ALTER TABLE [Item].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_CoverTypes] FOREIGN KEY([CoverTypeID])
REFERENCES [Item].[CoverTypes] ([CoverTypeID])
GO
ALTER TABLE [Item].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_PriceHistories] FOREIGN KEY([PriceHistoryID])
REFERENCES [Item].[PriceHistories] ([PriceHistoryID])
GO
ALTER TABLE [Item].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Subcategories] FOREIGN KEY([SubcategoryID])
REFERENCES [Item].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [Item].[Subcategories]  WITH CHECK ADD  CONSTRAINT [FK_Subcategories_Categories] FOREIGN KEY([CategoryID])
REFERENCES [Item].[Categories] ([CategoryID])
GO
ALTER TABLE [Item].[LingusticDescriptions]  WITH CHECK ADD  CONSTRAINT [FK_LingusticDescriptions_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
ALTER TABLE [Item].[LingusticDescriptions]  WITH CHECK ADD  CONSTRAINT [FK_LingusticDescriptions_Languages] FOREIGN KEY([LanguageID])
REFERENCES [Item].[Languages] ([LanguageID])
GO
ALTER TABLE [Item].[Authorships]  WITH CHECK ADD  CONSTRAINT [FK_Authorships_Authors] FOREIGN KEY([AuthorID])
REFERENCES [Item].[Authors] ([AuthorID])
GO
ALTER TABLE [Item].[Authorships]  WITH CHECK ADD  CONSTRAINT [FK_Authorships_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
ALTER TABLE [Item].[PublishingHouses]  WITH CHECK ADD  CONSTRAINT [FK_PublishingHouses_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
ALTER TABLE [Item].[PublishingHouses]  WITH CHECK ADD  CONSTRAINT [FK_PublishingHouses_Publishers] FOREIGN KEY([PublisherID])
REFERENCES [Item].[Publishers] ([PublisherID])
GO
ALTER TABLE [Item].[Publishers]  WITH CHECK ADD  CONSTRAINT [FK_Publishers_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
--ALTER TABLE [Item].[Publishers]  WITH CHECK ADD  CONSTRAINT [FK_Publishers_Countries] FOREIGN KEY([CountryID])
--REFERENCES [Address].[Countries] ([CountryID])
GO
ALTER TABLE [Purchase].[ShipmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
ALTER TABLE [Purchase].[ShipmentDetails]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentDetails_Shipments] FOREIGN KEY([ShipmentID])
REFERENCES [Purchase].[Shipments] ([ShipmentID])
GO
--ALTER TABLE [Address].[DeliveryDepartments]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryDepartments_Countries] FOREIGN KEY([CountryID])
--REFERENCES [Address].[Countries] ([CountryID])
GO
ALTER TABLE [Address].[DeliveryDepartments]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryDepartments_DeliveryCompanies] FOREIGN KEY([DeliveryCompanyID])
REFERENCES [Address].[DeliveryCompanies] ([DeliveryCompanyID])
GO
ALTER TABLE [Address].[DeliveryDepartments]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryDepartments_DeliveryTypes] FOREIGN KEY([DeliveryTypeID])
REFERENCES [Address].[DeliveryTypes] ([DeliveryTypeID])
GO
ALTER TABLE [Address].[DeliveryDepartments]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryDepartments_Cities] FOREIGN KEY([CityID])
REFERENCES [Address].[Cities] ([CityID])
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO
--ALTER TABLE [Purchase].[Vendors]  WITH CHECK ADD  CONSTRAINT [FK_Vendors_Countries] FOREIGN KEY([CountryID])
--REFERENCES [Address].[Countries] ([CountryID])
GO
ALTER TABLE [Purchase].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_BusinessUnits] FOREIGN KEY([BusinessUnitIDFrom])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Purchase].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_BusinessUnits1] FOREIGN KEY([BusinessUnitIDTo])
REFERENCES [Unit].[BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Purchase].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Employees] FOREIGN KEY([EmployeeIDFrom])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Purchase].[Shipments]  WITH CHECK ADD  CONSTRAINT [FK_Shipments_Employees1] FOREIGN KEY([EmployeeIDTo])
REFERENCES [Employee].[Employees] ([EmployeeID])
GO
ALTER TABLE [Purchase].[Stocks]  WITH CHECK ADD  CONSTRAINT [FK_Stocks_Items] FOREIGN KEY([ItemID])
REFERENCES [Item].[Items] ([ItemID])
GO

--ALTER TABLE Purchase.Vendors
--ALTER COLUMN IBAN nvarchar(34)
