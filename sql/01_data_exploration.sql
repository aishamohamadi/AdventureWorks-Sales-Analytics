USE AdventureWorks2022;
GO

/*
=========================================================
AdventureWorks Sales Analytics
01 - Data Exploration
=========================================================

Purpose:
Explore the database structure before starting business
analysis.

This script covers:
- Database schemas and tables
- Column metadata
- Primary keys
- Foreign key relationships
- Table row counts and storage size
- Core analytical tables
=========================================================
*/


-- =====================================================
-- 1. Database Tables and Schemas
-- =====================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
ORDER BY
    s.name,
    t.name;


-- =====================================================
-- 2. Column Metadata
-- =====================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.column_id AS ColumnOrder,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.is_nullable AS IsNullable
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
JOIN sys.columns AS c
    ON t.object_id = c.object_id
JOIN sys.types AS ty
    ON c.user_type_id = ty.user_type_id
ORDER BY
    s.name,
    t.name,
    c.column_id;


-- =====================================================
-- 3. Primary Keys
-- =====================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    kc.name AS PrimaryKeyName
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
JOIN sys.indexes AS i
    ON t.object_id = i.object_id
    AND i.is_primary_key = 1
JOIN sys.index_columns AS ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
JOIN sys.columns AS c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id
JOIN sys.key_constraints AS kc
    ON i.object_id = kc.parent_object_id
    AND i.index_id = kc.unique_index_id
ORDER BY
    s.name,
    t.name,
    ic.key_ordinal;


-- =====================================================
-- 4. Foreign Key Relationships
-- =====================================================

SELECT
    fk.name AS ForeignKeyName,

    sch1.name AS FromSchema,
    t1.name AS FromTable,
    c1.name AS FromColumn,

    sch2.name AS ToSchema,
    t2.name AS ToTable,
    c2.name AS ToColumn

FROM sys.foreign_key_columns AS fkc

JOIN sys.foreign_keys AS fk
    ON fkc.constraint_object_id = fk.object_id

JOIN sys.tables AS t1
    ON fkc.parent_object_id = t1.object_id

JOIN sys.schemas AS sch1
    ON t1.schema_id = sch1.schema_id

JOIN sys.columns AS c1
    ON fkc.parent_object_id = c1.object_id
    AND fkc.parent_column_id = c1.column_id

JOIN sys.tables AS t2
    ON fkc.referenced_object_id = t2.object_id

JOIN sys.schemas AS sch2
    ON t2.schema_id = sch2.schema_id

JOIN sys.columns AS c2
    ON fkc.referenced_object_id = c2.object_id
    AND fkc.referenced_column_id = c2.column_id

ORDER BY
    FromSchema,
    FromTable,
    ToTable;


-- =====================================================
-- 5. Table Row Counts and Storage Size
-- =====================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(p.rows) AS TotalRows,

    CAST(
        SUM(a.total_pages) * 8.0 / 1024
        AS DECIMAL(10,2)
    ) AS TotalSizeMB,

    CAST(
        SUM(a.used_pages) * 8.0 / 1024
        AS DECIMAL(10,2)
    ) AS UsedSizeMB,

    CAST(
        SUM(a.data_pages) * 8.0 / 1024
        AS DECIMAL(10,2)
    ) AS DataSizeMB

FROM sys.tables AS t

JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id

JOIN sys.indexes AS i
    ON t.object_id = i.object_id

JOIN sys.partitions AS p
    ON i.object_id = p.object_id
    AND i.index_id = p.index_id

JOIN sys.allocation_units AS a
    ON p.partition_id = a.container_id

GROUP BY
    s.name,
    t.name

ORDER BY
    TotalRows DESC;


-- =====================================================
-- 6. Core Analytical Tables
-- =====================================================

SELECT
    'Sales.SalesOrderDetail' AS TableName,
    COUNT(*) AS RowCount
FROM Sales.SalesOrderDetail

UNION ALL

SELECT
    'Sales.SalesOrderHeader',
    COUNT(*)
FROM Sales.SalesOrderHeader

UNION ALL

SELECT
    'Sales.Customer',
    COUNT(*)
FROM Sales.Customer

UNION ALL

SELECT
    'Production.Product',
    COUNT(*)
FROM Production.Product

UNION ALL

SELECT
    'Sales.SalesTerritory',
    COUNT(*)
FROM Sales.SalesTerritory;