--CREATION DATA
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

-- INSERTION DATA
INSERT INTO Dim_Date (DateKey, SaleDate, [Year], [Quarter], [Month])
SELECT DISTINCT
    YEAR(sale_date) * 10000 + MONTH(sale_date) * 100 + DAY(sale_date) AS DateKey,
    sale_date,
    [year],
    quarter,
    [month]
FROM apple_global_sales_dataset
WHERE sale_date IS NOT NULL;

INSERT INTO Dim_Product (ProductName, Category, Storage, Color)
SELECT DISTINCT
    product_name,
    category,
    storage,
    color
FROM apple_global_sales_dataset;

INSERT INTO Dim_Geography (Country, Region, City)
SELECT DISTINCT
    country,
    region,
    city
FROM apple_global_sales_dataset;

INSERT INTO Dim_Channel (SalesChannel, PaymentMethod)
SELECT DISTINCT
    sales_channel,
    payment_method
FROM apple_global_sales_dataset;

INSERT INTO Dim_Customer (CustomerSegment, CustomerAgeGroup, PreviousDeviceOS)
SELECT DISTINCT
    customer_segment,
    customer_age_group,
    previous_device_os
FROM apple_global_sales_dataset;


INSERT INTO Fact_Sales (
    SaleID,
    DateKey,
    ProductKey,
    GeoKey,
    ChannelKey,
    CustomerKey,
    UnitPriceUSD,
    DiscountPct,
    UnitsSold,
    DiscountedPriceUSD,
    RevenueUSD,
    Currency,
    FXRateToUSD,
    RevenueLocalCurrency,
    CustomerRating,
    ReturnStatus
)
SELECT
    s.sale_id,
    d.DateKey,
    p.ProductKey,
    g.GeoKey,
    c.ChannelKey,
    cu.CustomerKey,
    s.unit_price_usd,
    s.discount_pct,
    s.units_sold,
    s.discounted_price_usd,
    s.revenue_usd,
    s.currency,
    s.fx_rate_to_usd,
    s.revenue_local_currency,
    s.customer_rating,
    s.return_status
FROM apple_global_sales_dataset s
JOIN Dim_Date d
    ON s.sale_date = d.SaleDate
JOIN Dim_Product p
    ON s.product_name = p.ProductName
   AND s.category = p.Category
   AND ISNULL(s.storage,'') = ISNULL(p.Storage,'')
   AND ISNULL(s.color,'') = ISNULL(p.Color,'')
JOIN Dim_Geography g
    ON s.country = g.Country
   AND s.region = g.Region
   AND s.city = g.City
JOIN Dim_Channel c
    ON s.sales_channel = c.SalesChannel
   AND s.payment_method = c.PaymentMethod
JOIN Dim_Customer cu
    ON s.customer_segment = cu.CustomerSegment
   AND ISNULL(s.customer_age_group,'') = ISNULL(cu.CustomerAgeGroup,'')
   AND ISNULL(s.previous_device_os,'') = ISNULL(cu.PreviousDeviceOS,'');
