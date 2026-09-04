USE AdventureWorks2022;
GO

/*
=========================================================
03 - Sales Analysis
=========================================================

Business Questions:

1. How have sales performance and order volume changed over time?

2. Which products generate the highest sales revenue and sales volume?

3. Which product categories and subcategories contribute most to sales revenue?

4. Which customers contribute the most revenue, and how concentrated is revenue among customers?

=========================================================
*/


-- =====================================================
-- Question 1: Sales Performance Over Time
-- =====================================================

WITH YearlySales AS
(
    SELECT
        YEAR(h.OrderDate) AS OrderYear,
        COUNT(DISTINCT h.SalesOrderID) AS OrderCount,
        COUNT(DISTINCT h.CustomerID) AS CustomerCount,
        SUM(d.LineTotal) AS TotalSales,

        SUM(d.LineTotal)
            / NULLIF(COUNT(DISTINCT h.SalesOrderID), 0)
            AS AverageOrderValue

    FROM Sales.SalesOrderHeader AS h

    INNER JOIN Sales.SalesOrderDetail AS d
        ON h.SalesOrderID = d.SalesOrderID

    GROUP BY
        YEAR(h.OrderDate)
)

SELECT
    OrderYear,
    OrderCount,
    CustomerCount,
    ROUND(TotalSales, 2) AS TotalSales,
    ROUND(AverageOrderValue, 2) AS AverageOrderValue,

    ROUND(
        (
            TotalSales
            - LAG(TotalSales) OVER (ORDER BY OrderYear)
        )
        / NULLIF(
            LAG(TotalSales) OVER (ORDER BY OrderYear),
            0
        ) * 100,
        2
    ) AS SalesGrowthPct

FROM YearlySales

ORDER BY
    OrderYear;


-- =====================================================
-- Question 2: Top Products by Sales Revenue and Volume
-- =====================================================

SELECT
    p.ProductID,
    p.Name AS ProductName,
    SUM(d.OrderQty) AS UnitsSold,
    SUM(d.LineTotal) AS TotalSales,
    COUNT(DISTINCT d.SalesOrderID) AS OrderCount

FROM Sales.SalesOrderDetail AS d

INNER JOIN Production.Product AS p
    ON d.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.Name

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 3: Sales by Product Category & Subcategory
-- =====================================================

SELECT
    pc.ProductCategoryID,
    pc.Name AS CategoryName,
    psc.ProductSubcategoryID,
    psc.Name AS SubcategoryName,
    SUM(sod.OrderQty) AS UnitsSold,
    SUM(sod.LineTotal) AS TotalSales,
    COUNT(DISTINCT sod.SalesOrderID) AS OrderCount

FROM Sales.SalesOrderDetail AS sod

INNER JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID

INNER JOIN Production.ProductSubcategory AS psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID

INNER JOIN Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID

GROUP BY
    pc.ProductCategoryID,
    pc.Name,
    psc.ProductSubcategoryID,
    psc.Name

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 3B: Sales Share by Product Category
-- =====================================================

WITH CategorySales AS
(
    SELECT
        pc.ProductCategoryID,
        pc.Name AS CategoryName,
        SUM(sod.LineTotal) AS TotalSales

    FROM Sales.SalesOrderDetail AS sod

    INNER JOIN Production.Product AS p
        ON sod.ProductID = p.ProductID

    INNER JOIN Production.ProductSubcategory AS psc
        ON p.ProductSubcategoryID = psc.ProductSubcategoryID

    INNER JOIN Production.ProductCategory AS pc
        ON psc.ProductCategoryID = pc.ProductCategoryID

    GROUP BY
        pc.ProductCategoryID,
        pc.Name
)

SELECT
    CategoryName,
    ROUND(TotalSales, 2) AS TotalSales,

    ROUND(
        TotalSales
        / SUM(TotalSales) OVER () * 100,
        2
    ) AS RevenueSharePct

FROM CategorySales

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 4: Top Customers by Sales Revenue
-- =====================================================

SELECT TOP 20
    c.CustomerID,
    c.AccountNumber,
    COUNT(DISTINCT h.SalesOrderID) AS OrderCount,
    SUM(d.OrderQty) AS UnitsPurchased,
    ROUND(SUM(d.LineTotal), 2) AS TotalSales

FROM Sales.Customer AS c

INNER JOIN Sales.SalesOrderHeader AS h
    ON c.CustomerID = h.CustomerID

INNER JOIN Sales.SalesOrderDetail AS d
    ON h.SalesOrderID = d.SalesOrderID

GROUP BY
    c.CustomerID,
    c.AccountNumber

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 4B: Customer Sales Concentration
-- =====================================================

WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.AccountNumber,
        SUM(d.LineTotal) AS TotalSales

    FROM Sales.Customer AS c

    INNER JOIN Sales.SalesOrderHeader AS h
        ON c.CustomerID = h.CustomerID

    INNER JOIN Sales.SalesOrderDetail AS d
        ON h.SalesOrderID = d.SalesOrderID

    GROUP BY
        c.CustomerID,
        c.AccountNumber
),

RankedCustomers AS
(
    SELECT
        CustomerID,
        AccountNumber,
        TotalSales,

        -- Total sales generated by all customers
        SUM(TotalSales) OVER () AS OverallSales,

        -- Cumulative sales from highest-sales customers
        SUM(TotalSales) OVER (
            ORDER BY TotalSales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS CumulativeSales,

        -- Rank customers by sales
        ROW_NUMBER() OVER (
            ORDER BY TotalSales DESC
        ) AS CustomerRank

    FROM CustomerSales
),

CustomerPareto AS
(
    SELECT
        CustomerRank,
        TotalSales,

        CumulativeSales
            / NULLIF(OverallSales, 0) * 100
            AS CumulativeRevenueSharePct

    FROM RankedCustomers
)

SELECT
    MIN(
        CASE
            WHEN CumulativeRevenueSharePct >= 50
            THEN CustomerRank
        END
    ) AS CustomersToReach50Pct,

    MIN(
        CASE
            WHEN CumulativeRevenueSharePct >= 80
            THEN CustomerRank
        END
    ) AS CustomersToReach80Pct,

    MIN(
        CASE
            WHEN CumulativeRevenueSharePct >= 90
            THEN CustomerRank
        END
    ) AS CustomersToReach90Pct

FROM CustomerPareto;