# Data Understanding

## 1. Data Source

The project uses the AdventureWorks2022 sample relational database
implemented in Microsoft SQL Server.

The database contains multiple schemas covering sales, production,
purchasing, human resources, and person-related information.

---

## 2. Database Overview

| Metric | Value |
|---|---:|
| Database | AdventureWorks2022 |
| Database Size | ~272 MB |
| Sales Order Lines | 121,317 |
| Sales Orders | 31,465 |
| Customers | 19,119 |
| Products in Product Master | 2,016 |
| Distinct Products Sold | 266 |
| Sales Territories | 10 |

---

## 3. Core Analytical Tables

| Schema | Table | Analytical Role |
|---|---|---|
| Sales | SalesOrderHeader | Sales order information |
| Sales | SalesOrderDetail | Sales transaction lines |
| Sales | Customer | Customer information |
| Sales | SalesTerritory | Territory information |
| Production | Product | Product information |
| Production | ProductSubcategory | Product classification |
| Production | ProductCategory | Product classification |

---

## 4. Grain

### SalesOrderHeader

One row represents one sales order.

### SalesOrderDetail

One row represents one product line within a sales order.

### Customer

One row represents one customer.

### Product

One row represents one product.

### SalesTerritory

One row represents one sales territory.

---

## 5. Core Relationships

### SalesOrderHeader → SalesOrderDetail

One sales order can contain multiple order lines.

### Customer → SalesOrderHeader

One customer can have multiple sales orders.

### SalesTerritory → SalesOrderHeader

One territory can contain multiple sales orders.

### Product → SalesOrderDetail

One product can appear in multiple sales order lines.

---

## 6. Analytical Scope

The analysis focuses primarily on the Sales and Production schemas,
with the following tables forming the core analytical model:

- Sales.SalesOrderHeader
- Sales.SalesOrderDetail
- Sales.Customer
- Sales.SalesTerritory
- Production.Product

Additional product classification tables may be used where required
for product-level analysis.

---

## 7. Data Validation Summary

The core relationships were validated before beginning the business
analysis.

- No NULL values were found in SalesOrderDetail.SalesOrderID.
- No NULL values were found in SalesOrderDetail.ProductID.
- No NULL values were found in SalesOrderHeader.CustomerID.
- No NULL values were found in SalesOrderHeader.TerritoryID.
- No orphaned sales order details were identified against SalesOrderHeader.
- No orphaned product references were identified.

The validated analytical scope was considered suitable for the planned
sales analysis.