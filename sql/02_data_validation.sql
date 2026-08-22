USE AdventureWorks2022;
GO

/*
=========================================================
AdventureWorks Sales Analytics
02 - Data Validation
=========================================================

Purpose:
Validate the integrity and consistency of the core
analytical tables before business analysis.

Validation areas:
- Row counts
- NULL foreign keys
- Distinct entity counts
- Referential integrity
=========================================================
*/


-- =====================================================
-- 1. Sales Order Detail Validation
-- =====================================================

SELECT
    COUNT(*) AS TotalOrderDetails,
    COUNT(DISTINCT SalesOrderID) AS DistinctOrders,
    COUNT(DISTINCT ProductID) AS DistinctProducts,
    COUNT(DISTINCT SpecialOfferID) AS DistinctOffers,

    SUM(
        CASE
            WHEN ProductID IS NULL THEN 1
            ELSE 0
        END
    ) AS NullProductID,

    SUM(
        CASE
            WHEN SalesOrderID IS NULL THEN 1
            ELSE 0
        END
    ) AS NullSalesOrderID

FROM Sales.SalesOrderDetail;


-- =====================================================
-- 2. Sales Order Header Validation
-- =====================================================

SELECT
    COUNT(*) AS TotalOrders,
    COUNT(DISTINCT CustomerID) AS DistinctCustomers,
    COUNT(DISTINCT TerritoryID) AS DistinctTerritories,

    SUM(
        CASE
            WHEN CustomerID IS NULL THEN 1
            ELSE 0
        END
    ) AS NullCustomerID,

    SUM(
        CASE
            WHEN TerritoryID IS NULL THEN 1
            ELSE 0
        END
    ) AS NullTerritoryID

FROM Sales.SalesOrderHeader;


-- =====================================================
-- 3. Product Referential Integrity
-- =====================================================

SELECT
    COUNT(*) AS OrphanProducts

FROM Sales.SalesOrderDetail AS d

LEFT JOIN Production.Product AS p
    ON d.ProductID = p.ProductID

WHERE p.ProductID IS NULL;


-- =====================================================
-- 4. Sales Order Referential Integrity
-- =====================================================

SELECT
    COUNT(*) AS OrphanOrders

FROM Sales.SalesOrderDetail AS d

LEFT JOIN Sales.SalesOrderHeader AS h
    ON d.SalesOrderID = h.SalesOrderID

WHERE h.SalesOrderID IS NULL;