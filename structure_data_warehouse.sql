CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Storage VARCHAR(30),
    Color VARCHAR(30)
);

CREATE TABLE Dim_Geography (
    GeoKey INT IDENTITY(1,1) PRIMARY KEY,
    Country VARCHAR(50),
    Region VARCHAR(50),
    City VARCHAR(100)
);

CREATE TABLE Dim_Channel (
    ChannelKey INT IDENTITY(1,1) PRIMARY KEY,
    SalesChannel VARCHAR(100),
    PaymentMethod VARCHAR(50)
);

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerSegment VARCHAR(50),
    CustomerAgeGroup VARCHAR(20),
    PreviousDeviceOS VARCHAR(50)
);

CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    SaleDate DATE,
    [Year] INT,
    [Quarter] VARCHAR(5),
    [Month] VARCHAR(20)
);

CREATE TABLE Fact_Sales (
    SaleKey INT IDENTITY(1,1) PRIMARY KEY,
    SaleID VARCHAR(20),
    DateKey INT,
    ProductKey INT,
    GeoKey INT,
    ChannelKey INT,
    CustomerKey INT,
    UnitPriceUSD DECIMAL(18,2),
    DiscountPct DECIMAL(10,2),
    UnitsSold INT,
    DiscountedPriceUSD DECIMAL(18,2),
    RevenueUSD DECIMAL(18,2),
    Currency VARCHAR(10),
    FXRateToUSD DECIMAL(18,6),
    RevenueLocalCurrency DECIMAL(18,2),
    CustomerRating DECIMAL(10,2),
    ReturnStatus VARCHAR(20)
);