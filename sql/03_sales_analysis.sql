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

5. How does sales performance vary across sales territories?

6. How are discounts associated with sales volume and revenue?
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
-- Question 2A: Top Products by Sales Revenue
-- =====================================================

SELECT TOP 10
    p.ProductID,
    p.Name AS ProductName,
    SUM(d.OrderQty) AS UnitsSold,
    ROUND(SUM(d.LineTotal), 2) AS TotalSales,
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
-- Question 2B: Top Products by Sales Volume
-- =====================================================

SELECT TOP 10
    p.ProductID,
    p.Name AS ProductName,
    SUM(d.OrderQty) AS UnitsSold,
    ROUND(SUM(d.LineTotal), 2) AS TotalSales,
    COUNT(DISTINCT d.SalesOrderID) AS OrderCount

FROM Sales.SalesOrderDetail AS d

INNER JOIN Production.Product AS p
    ON d.ProductID = p.ProductID

GROUP BY
    p.ProductID,
    p.Name

ORDER BY
    UnitsSold DESC;


-- =====================================================
-- Question 3A: Sales by Product Category & Subcategory
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
-- Question 4A: Top Customers by Sales Revenue
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


-- =====================================================
-- Question 5A: Territory Performance
-- =====================================================

SELECT
    st.TerritoryID,
    st.Name AS TerritoryName,
    COUNT(DISTINCT h.SalesOrderID) AS OrderCount,
    COUNT(DISTINCT h.CustomerID) AS CustomerCount,
    SUM(d.OrderQty) AS UnitsSold,
    ROUND(SUM(d.LineTotal), 2) AS TotalSales,

    ROUND(
        SUM(d.LineTotal)
        / NULLIF(COUNT(DISTINCT h.SalesOrderID), 0),
        2
    ) AS AverageOrderValue

FROM Sales.SalesOrderHeader AS h

INNER JOIN Sales.SalesOrderDetail AS d
    ON h.SalesOrderID = d.SalesOrderID

INNER JOIN Sales.SalesTerritory AS st
    ON h.TerritoryID = st.TerritoryID

GROUP BY
    st.TerritoryID,
    st.Name

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 5B: Sales Share by Territory
-- =====================================================

WITH TerritorySales AS
(
    SELECT
        st.TerritoryID,
        st.Name AS TerritoryName,
        SUM(d.LineTotal) AS TotalSales

    FROM Sales.SalesOrderHeader AS h

    INNER JOIN Sales.SalesOrderDetail AS d
        ON h.SalesOrderID = d.SalesOrderID

    INNER JOIN Sales.SalesTerritory AS st
        ON h.TerritoryID = st.TerritoryID

    GROUP BY
        st.TerritoryID,
        st.Name
)

SELECT
    TerritoryName,
    ROUND(TotalSales, 2) AS TotalSales,

    ROUND(
        TotalSales
        / SUM(TotalSales) OVER () * 100,
        2
    ) AS RevenueSharePct

FROM TerritorySales

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 5C: Territory Sales, Order Volume & AOV
-- =====================================================

SELECT
    st.TerritoryID,
    st.Name AS TerritoryName,
    COUNT(DISTINCT h.SalesOrderID) AS OrderCount,
    SUM(d.OrderQty) AS UnitsSold,
    ROUND(SUM(d.LineTotal), 2) AS TotalSales,

    ROUND(
        SUM(d.LineTotal)
        / NULLIF(COUNT(DISTINCT h.SalesOrderID), 0),
        2
    ) AS AverageOrderValue,

    ROUND(
        SUM(d.LineTotal)
        / NULLIF(SUM(d.OrderQty), 0),
        2
    ) AS AverageSalesPerUnit

FROM Sales.SalesOrderHeader AS h

INNER JOIN Sales.SalesOrderDetail AS d
    ON h.SalesOrderID = d.SalesOrderID

INNER JOIN Sales.SalesTerritory AS st
    ON h.TerritoryID = st.TerritoryID

GROUP BY
    st.TerritoryID,
    st.Name

ORDER BY
    TotalSales DESC;


-- =====================================================
-- Question 6A: Discount-Related Sales Patterns
-- =====================================================

SELECT
    d.UnitPriceDiscount,
    COUNT(*) AS SalesLineCount,
    SUM(d.OrderQty) AS UnitsSold,
    ROUND(SUM(d.LineTotal), 2) AS NetSales

FROM Sales.SalesOrderDetail AS d

GROUP BY
    d.UnitPriceDiscount

ORDER BY
    d.UnitPriceDiscount;


-- =====================================================
-- Question 6B Validation: Multiple Discount Levels per Order
-- =====================================================

-- Validation check:
-- Some orders contain multiple discount levels.
-- Therefore, an order should not be classified using
-- MAX(UnitPriceDiscount).

SELECT
    SalesOrderID,
    COUNT(DISTINCT UnitPriceDiscount) AS DiscountLevelCount

FROM Sales.SalesOrderDetail

GROUP BY
    SalesOrderID

HAVING
    COUNT(DISTINCT UnitPriceDiscount) > 1

ORDER BY
    DiscountLevelCount DESC;


-- =====================================================
-- Question 6C: Discount Amount and Net Sales by Discount Level
-- =====================================================

SELECT
    d.UnitPriceDiscount AS DiscountRate,
    COUNT(*) AS SalesLineCount,
    SUM(d.OrderQty) AS UnitsSold,

    ROUND(
        SUM(d.UnitPrice * d.OrderQty),
        2
    ) AS GrossSales,

    ROUND(
        SUM(
            d.UnitPrice
            * d.OrderQty
            * d.UnitPriceDiscount
        ),
        2
    ) AS DiscountAmount,

    ROUND(
        SUM(d.LineTotal),
        2
    ) AS NetSales

FROM Sales.SalesOrderDetail AS d

GROUP BY
    d.UnitPriceDiscount

ORDER BY
    d.UnitPriceDiscount;


-- =====================================================
-- Question 6D: Discounted vs Non-Discounted Sales
-- =====================================================

SELECT
    CASE
        WHEN d.UnitPriceDiscount = 0 THEN 'No Discount'
        ELSE 'Discounted'
    END AS DiscountStatus,

    COUNT(*) AS SalesLineCount,
    SUM(d.OrderQty) AS UnitsSold,

    ROUND(
        SUM(d.UnitPrice * d.OrderQty),
        2
    ) AS GrossSales,

    ROUND(
        SUM(
            d.UnitPrice
            * d.OrderQty
            * d.UnitPriceDiscount
        ),
        2
    ) AS DiscountAmount,

    ROUND(
        SUM(d.LineTotal),
        2
    ) AS NetSales

FROM Sales.SalesOrderDetail AS d

GROUP BY
    CASE
        WHEN d.UnitPriceDiscount = 0 THEN 'No Discount'
        ELSE 'Discounted'
    END

ORDER BY
    DiscountStatus;


-- =====================================================
-- Question 6E: Discount Patterns by Product Category
-- =====================================================

SELECT
    pc.Name AS ProductCategory,
    psc.Name AS ProductSubcategory,
    COUNT(*) AS SalesLines,
    SUM(sod.OrderQty) AS UnitsSold,

    SUM(sod.LineTotal / NULLIF(1 - sod.UnitPriceDiscount, 0))
        AS GrossSales,

    SUM(
        (sod.LineTotal / NULLIF(1 - sod.UnitPriceDiscount, 0))
        * sod.UnitPriceDiscount
    ) AS DiscountAmount,

    SUM(sod.LineTotal) AS NetSales,

    CAST(
        100.0 * COUNT(CASE
            WHEN sod.UnitPriceDiscount > 0 THEN 1
        END) / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS DiscountedLinePct

FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory AS psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID

GROUP BY
    pc.Name,
    psc.Name

ORDER BY
    DiscountedLinePct DESC,
    NetSales DESC;