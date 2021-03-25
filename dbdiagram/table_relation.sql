CREATE TABLE [CurrencyRates] (
  [CurrencyID] INT PRIMARY KEY IDENTITY(1, 1),
  [Code] NVARCHAR(5) UNIQUE NOT NULL,
  [Rate] DECIMAL(10, 2) NOT NULL,
  [ModifiedDate] DATETIME NOT NULL
)
GO

CREATE TABLE [PaymentTypes] (
  [PaymentTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(20) NOT NULL --cash or card
)
GO

CREATE TABLE [Orders] (
  [OrderID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [CustomerID] INT,
  [Date] DATETIME NOT NULL,
  [PaymentTypeID] TINYINT NOT NULL,
  [RRN] INT, --bank transaction
  [Amount] DECIMAL NOT NULL,--without discount
  [DiscountID] TINYINT,
  [DiscountAmount] DECIMAL,--with discount
  [DeliveryDepartmentID] INT, -- post
  [BusinessUnitID] INT,		-- self-pickup
  [Comment] NVARCHAR(100)
);
GO

CREATE TABLE [OrderDetails] (
  [OrderDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [OrderID] INT NOT NULL,
  [ItemID] INT NOT NULL,
  [ItemPrice] DECIMAL (10,2) NOT NULL, -- Items.ItemPrice snapshot
  [Quantity] SMALLINT NOT NULL,
  [IsReturn] BIT NOT NULL
)
GO


CREATE TABLE [DeliveryTypes](
  [DeliveryTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) -- self-pickup or post
)

CREATE TABLE [DeliveryDepartments] (
  [DeliveryDepartmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [DeliveryTypeID] TINYINT NOT NULL,
  [DeliveryCompanyID] TINYINT,
  [CountryID] TINYINT,
  [CityID] SMALLINT,
  [DepartmentNumber] INT,
  [DepartmentAddress] NVARCHAR(500)
)

CREATE TABLE [DeliveryCompanies] (
  [DeliveryCompanyID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR (50) NOT NULL -- NovaPoshta, UkrPoshta, FedEx
  
)

CREATE TABLE [BusinessUnits] ( --only in Ukraine
  [BusinessUnitID] INT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(100),
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [ZipCode] INT NOT NULL,
  [CityID] SMALLINT NOT NULL,
  [Street] NVARCHAR(255) NOT NULL,
  [BuildingNumber] NVARCHAR(5) NOT NULL,
  [AppartmentNumber] NVARCHAR(7),
  [Phone] NVARCHAR NOT NULL,
  [IsActive] BIT NOT NULL
)
GO

CREATE TABLE [Countries] (
  [CountryID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Cities] (
  [CityID] SMALLINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [BusinessUnitTypes] (
  [BusinessUnitTypeID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR NOT NULL -- shop or warehouse
)
GO

CREATE TABLE [Stocks] (
  [StockID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [Quantity] INT NOT NULL
)
GO

CREATE TABLE [Departments] (
  [DepartmentID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] INT UNIQUE NOT NULL --security, HR, etc
)
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

CREATE TABLE [EmployeeDetails] (
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

CREATE TABLE [Roles] (
  [RoleID] TINYINT PRIMARY KEY IDENTITY(1, 1),
  [Name] NVARCHAR(50) NOT NULL,
  [BusinessUnitTypeID] TINYINT NOT NULL,
  [Description] NVARCHAR(255) NOT NULL
)
GO

CREATE TABLE [EmployeeRoleHistories] (
  [EmployeeRoleHistoryID] INT PRIMARY KEY IDENTITY(1, 1),
  [EmployeeID] INT NOT NULL,
  [RoleID] TINYINT NOT NULL,
  [StartDate] DATE NOT NULL,
  [EndDate] DATE,
  [Salary] DECIMAL(8,2) NOT NULL,
  [IsActive] BIT NOT NULL,
  [SalaryModifiedDate] DATE
)
GO

CREATE TABLE [Vendors] (
  [VendorID] INT PRIMARY KEY IDENTITY (1, 1),
  [VendorCode] BIGINT NOT NULL,
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

CREATE TABLE Accounts (
  AccountID INT PRIMARY KEY IDENTITY(1,1),
  CustomerID INT UNIQUE NOT NULL,
  UserLogin  NVARCHAR(20) UNIQUE NOT NULL,
  UserPassword NVARCHAR(10) NOT NULL,
  ModifiedDate DATETIME NOT NULL
)


CREATE TABLE [Customers] (
  [CustomerID] INT PRIMARY KEY IDENTITY (1, 1),
  [FirstName] NVARCHAR(50) NOT NULL,
  [MiddleName] NVARCHAR(50),
  [LastName] NVARCHAR(50) NOT NULL,
  [AccountID] INT,
  [ZipCode] INT NOT NULL,
  [CountryID] TINYINT,
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

CREATE TABLE [Discounts] (
  [DiscountID] TINYINT PRIMARY KEY IDENTITY (1,1),
  [Percentage] DECIMAL(4,2) NOT NULL, --discount in percents
  [AmountSpend] DECIMAL (10, 2) NOT NULL --from what sum discount is active
)
GO

CREATE TABLE [Consignments] (
  [ConsignmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [Number] INT NOT NULL,
  [Date] DATE NOT NULL,
  [VendorID] INT NOT NULL,
  [BusinessUnitID] INT NOT NULL,
  [EmployeeID] INT NOT NULL
)
GO

CREATE TABLE [ConsignmentDetails] (
  [ConsignmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ConsignmentID] INT NOT NULL,
  [Quantity] INT NOT NULL,
  [PurchasePrice] DECIMAL (10,2) NOT NULL,
  [CurrencyID] INT NOT NULL
)
GO

CREATE TABLE [ShipmentDetails] (
  [ShipmentDetailID] INT PRIMARY KEY IDENTITY(1, 1),
  [ItemID] INT NOT NULL,
  [ShipmentID] INT NOT NULL,
  [Quantity] INT NOT NULL
)
GO

CREATE TABLE [Shipments] (
  [ShipmentID] INT PRIMARY KEY IDENTITY(1, 1),
  [Number] INT NOT NULL,
  [Date] DATE NOT NULL,
  [BusinessUnitIDFrom] INT NOT NULL,
  [BusinessUnitIDTo] INT NOT NULL,
  [EmployeeIDFrom] INT NOT NULL,
  [EmployeeIDTo] INT NOT NULL
)
GO


CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY IDENTITY(1,1),
	[SubcategoryID] TINYINT NOT NULL,
	[PriceHistoryID] INT NOT NULL,
	[Title] NVARCHAR (500) NOT NULL,
	[Description] NVARCHAR(MAX),
	[PulisherID] SMALLINT,
	[AuthorID] INT,
	[LanguageID] TINYINT NOT NULL,
	[CoverTypeID] TINYINT,
	[GenreID] TINYINT,
	[Year] DATE NOT NULL,
	[AgeRestrictionID] NVARCHAR(10) ,
	[ISBN] BIGINT NOT NULL,
	[Pages] INT,
	[Issue] NVARCHAR(10),
	[CreateDate] DATE NOT NULL,
	[ModifiedDate] DATE NOT NULL
)
GO

CREATE TABLE [PriceHistories](
	[PriceHistoryID] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ConsignmentID] INT NOT NULL,
	[ItemID] INT NOT NULL,
	[Price] DECIMAL(10, 2) NOT NULL,
	[SetDate] DATE NOT NULL,
	[ModifiedDate] DATE,
	[IsActive] BIT NOT NULL -- MAX price from different [Consignments]
)
GO

CREATE TABLE [Categories](
	[CategoryID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(500)
);
GO

CREATE TABLE [Subcategories](
	[SubcategoryID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[CategoryID] TINYINT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(500)
);
GO

CREATE TABLE [Publishers](
	[PublisherID] SMALLINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(500) NOT NULL,
	[CountryID] TINYINT,
	[CityID] SMALLINT
)
GO

CREATE TABLE [Authors](
	[AuthorID] INT PRIMARY KEY IDENTITY(1,1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[MiddleName] NVARCHAR(50),
	[LastName] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Genres](
	[GenreID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50)
)
GO

CREATE TABLE [CoverTypes](
	[CoverTypeID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [Languages](
	[LanguageID] TINYINT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [PublishingHouses](
	[PublishingHouseID] INT PRIMARY KEY IDENTITY(1,1),
	[ItemID] INT NOT NULL,
	[PublisherID] SMALLINT NOT NULL
)
GO

CREATE TABLE [Authorships](
	[AuthorshipID] INT PRIMARY KEY IDENTITY(1,1),
	[AuthorID] INT NOT NULL,
	[ItemID] INT NOT NULL
)
GO

CREATE TABLE [ScenicalDescriptions](
	[ScenicalDescriptionID] INT PRIMARY KEY IDENTITY(1,1),
	[GenreID] TINYINT NOT NULL,
	[ItemID] INT NOT NULL
)
GO

CREATE TABLE [LingusticDescriptions](
	[LingusticDescriptionID] INT PRIMARY KEY IDENTITY(1,1),
	[ItemID] INT NOT NULL,
	[LanguageID] TINYINT NOT NULL
)
GO

ALTER TABLE [BusinessUnits] ADD CONSTRAINT [FK_BusinessUnits_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
REFERENCES [BusinessUnitTypes] ([BusinessUnitTypeID])
GO
ALTER TABLE [BusinessUnits]  ADD  CONSTRAINT [FK_BusinessUnits_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
GO
ALTER TABLE [EmployeeRoleHistories]  ADD  CONSTRAINT [FK_EmployeeRoleHistories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [EmployeeRoleHistories]  ADD  CONSTRAINT [FK_EmployeeRoleHistories_Roles] FOREIGN KEY([RoleID])
REFERENCES [Roles] ([RoleID])
GO
ALTER TABLE [EmployeeDetails]  ADD  CONSTRAINT [FK_EmployeeDetails_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [Employees]  ADD  CONSTRAINT [FK_Employees_Employees1] FOREIGN KEY([ManagerID])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [Employees]  ADD  CONSTRAINT [FK_Employees_Roles] FOREIGN KEY([RoleID])
REFERENCES [Roles] ([RoleID])
GO
ALTER TABLE [Employees]  ADD  CONSTRAINT [FK_Employees_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Employees]  ADD  CONSTRAINT [FK_Employees_Departments] FOREIGN KEY([DepartmentID])
REFERENCES [Departments] ([DepartmentID])
GO
ALTER TABLE [EmployeeDetails]  ADD  CONSTRAINT [FK_EmployeeDetails_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
ALTER TABLE [Roles]  ADD  CONSTRAINT [FK_Roles_BusinessUnitTypes] FOREIGN KEY([BusinessUnitTypeID])
REFERENCES [BusinessUnitTypes] ([BusinessUnitTypeID])
GO
ALTER TABLE [Stocks]  ADD  CONSTRAINT [FK_Stocks_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Vendors]  ADD  CONSTRAINT [FK_Vendors_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
ALTER TABLE [Customers]  ADD  CONSTRAINT [FK_Customers_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
ALTER TABLE [Customers]  ADD  CONSTRAINT [FK_Customers_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [Discounts] ([DiscountID])
GO
ALTER TABLE [Customers]  ADD  CONSTRAINT [FK_Customers_Countries] FOREIGN KEY([CountryID])
REFERENCES [Countries] ([CountryID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [Customers] ([CustomerID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_DeliveryDepartments] FOREIGN KEY([DeliveryDepartmentID])
REFERENCES [DeliveryDepartments] ([DeliveryDepartmentID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [Discounts] ([DiscountID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [Orders]  ADD  CONSTRAINT [FK_Orders_PaymentTypes] FOREIGN KEY([PaymentTypeID])
REFERENCES [PaymentTypes] ([PaymentTypeID])
GO
ALTER TABLE [OrderDetails]  ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [Orders] ([OrderID])
GO
ALTER TABLE [Customers]  ADD  CONSTRAINT [FK_Customers_Accounts] FOREIGN KEY([AccountID])
REFERENCES [Accounts] ([AccountID])
GO
ALTER TABLE [ConsignmentDetails]  ADD  CONSTRAINT [FK_ConsignmentDetails_Consignments] FOREIGN KEY([ConsignmentID])
REFERENCES [Consignments] ([ConsignmentID])
GO
ALTER TABLE [ConsignmentDetails]  ADD  CONSTRAINT [FK_ConsignmentDetails_CurrencyRates] FOREIGN KEY([CurrencyID])
REFERENCES [CurrencyRates] ([CurrencyID])
GO
ALTER TABLE [Consignments]  ADD  CONSTRAINT [FK_Consignments_BusinessUnits] FOREIGN KEY([BusinessUnitID])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Consignments]  ADD  CONSTRAINT [FK_Consignments_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [Consignments]  ADD  CONSTRAINT [FK_Consignments_Vendors] FOREIGN KEY([VendorID])
REFERENCES [Vendors] ([VendorID])
GO
ALTER TABLE [PriceHistories]  ADD  CONSTRAINT [FK_PriceHistories_Consignments] FOREIGN KEY([ConsignmentID])
REFERENCES [Consignments] ([ConsignmentID])
GO
ALTER TABLE [ConsignmentDetails]  ADD  CONSTRAINT [FK_ConsignmentDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [Items]  ADD  CONSTRAINT [FK_Items_CoverTypes] FOREIGN KEY([CoverTypeID])
REFERENCES [CoverTypes] ([CoverTypeID])
GO
ALTER TABLE [Items]  ADD  CONSTRAINT [FK_Items_PriceHistories] FOREIGN KEY([PriceHistoryID])
REFERENCES [PriceHistories] ([PriceHistoryID])
GO
ALTER TABLE [Items]  ADD  CONSTRAINT [FK_Items_Subcategories] FOREIGN KEY([SubcategoryID])
REFERENCES [Subcategories] ([SubcategoryID])
GO
ALTER TABLE [Subcategories]  ADD  CONSTRAINT [FK_Subcategories_Categories] FOREIGN KEY([CategoryID])
REFERENCES [Categories] ([CategoryID])
GO
ALTER TABLE [LingusticDescriptions]  ADD  CONSTRAINT [FK_LingusticDescriptions_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [LingusticDescriptions]  ADD  CONSTRAINT [FK_LingusticDescriptions_Languages] FOREIGN KEY([LanguageID])
REFERENCES [Languages] ([LanguageID])
GO
ALTER TABLE [ScenicalDescriptions]  ADD  CONSTRAINT [FK_ScenicalDescriptions_Genres] FOREIGN KEY([GenreID])
REFERENCES [Genres] ([GenreID])
GO
ALTER TABLE [ScenicalDescriptions]  ADD  CONSTRAINT [FK_ScenicalDescriptions_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [Authorships]  ADD  CONSTRAINT [FK_Authorships_Authors] FOREIGN KEY([AuthorID])
REFERENCES [Authors] ([AuthorID])
GO
ALTER TABLE [Authorships]  ADD  CONSTRAINT [FK_Authorships_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [PublishingHouses]  ADD  CONSTRAINT [FK_PublishingHouses_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [PublishingHouses]  ADD  CONSTRAINT [FK_PublishingHouses_Publishers] FOREIGN KEY([PublisherID])
REFERENCES [Publishers] ([PublisherID])
GO
ALTER TABLE [Publishers]  ADD  CONSTRAINT [FK_Publishers_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
ALTER TABLE [Publishers]  ADD  CONSTRAINT [FK_Publishers_Countries] FOREIGN KEY([CountryID])
REFERENCES [Countries] ([CountryID])
GO
ALTER TABLE [ShipmentDetails]  ADD  CONSTRAINT [FK_ShipmentDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [ShipmentDetails]  ADD  CONSTRAINT [FK_ShipmentDetails_Shipments] FOREIGN KEY([ShipmentID])
REFERENCES [Shipments] ([ShipmentID])
GO
ALTER TABLE [DeliveryDepartments]  ADD  CONSTRAINT [FK_DeliveryDepartments_Countries] FOREIGN KEY([CountryID])
REFERENCES [Countries] ([CountryID])
GO
ALTER TABLE [DeliveryDepartments]  ADD  CONSTRAINT [FK_DeliveryDepartments_DeliveryCompanies] FOREIGN KEY([DeliveryCompanyID])
REFERENCES [DeliveryCompanies] ([DeliveryCompanyID])
GO
ALTER TABLE [DeliveryDepartments]  ADD  CONSTRAINT [FK_DeliveryDepartments_DeliveryTypes] FOREIGN KEY([DeliveryTypeID])
REFERENCES [DeliveryTypes] ([DeliveryTypeID])
GO
ALTER TABLE [DeliveryDepartments]  ADD  CONSTRAINT [FK_DeliveryDepartments_Cities] FOREIGN KEY([CityID])
REFERENCES [Cities] ([CityID])
GO
ALTER TABLE [OrderDetails]  ADD  CONSTRAINT [FK_OrderDetails_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
ALTER TABLE [Vendors]  ADD  CONSTRAINT [FK_Vendors_Countries] FOREIGN KEY([CountryID])
REFERENCES [Countries] ([CountryID])
GO
ALTER TABLE [Shipments]  ADD  CONSTRAINT [FK_Shipments_BusinessUnits] FOREIGN KEY([BusinessUnitIDFrom])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Shipments]  ADD  CONSTRAINT [FK_Shipments_BusinessUnits1] FOREIGN KEY([BusinessUnitIDTo])
REFERENCES [BusinessUnits] ([BusinessUnitID])
GO
ALTER TABLE [Shipments]  ADD  CONSTRAINT [FK_Shipments_Employees] FOREIGN KEY([EmployeeIDFrom])
REFERENCES [Employees] ([EmployeeID])
GO
ALTER TABLE [Shipments]  ADD  CONSTRAINT [FK_Shipments_Employees1] FOREIGN KEY([EmployeeIDTo])
REFERENCES  [Employees] ([EmployeeID])
GO
ALTER TABLE [Stocks]  ADD  CONSTRAINT [FK_Stocks_Items] FOREIGN KEY([ItemID])
REFERENCES [Items] ([ItemID])
GO
