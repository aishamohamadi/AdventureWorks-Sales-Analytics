# Data Understanding

## 1. Data Source

The project uses the AdventureWorks2022 sample relational database implemented in Microsoft SQL Server.

The database contains multiple schemas covering sales, production, purchasing, human resources, and person-related information.

The analysis focuses primarily on the Sales and Production schemas.

---

## 2. Database Overview

| Metric | Value |
|---|---:|
| Database | AdventureWorks2022 |
| Database Size | ~272 MB |
| Sales Order Lines | 121,317 |
| Sales Orders | 31,465 |
| Total Customer Records | 19,820 |
| Customers with Recorded Sales | 19,119 |
| Customers without Recorded Sales | 701 |
| Products in Product Master | 2,016 |
| Distinct Products Sold | 266 |
| Sales Territories | 10 |

### Sales Data Coverage

The observed sales period extends from **May 31, 2011, to June 30, 2014**.

The available data covers:

* **2011:** May–December (7 months)
* **2012:** January–December (12 months)
* **2013:** January–December (12 months)
* **2014:** January–June (6 months)

Therefore, 2011 and 2014 represent partial calendar years, while 2012 and 2013 represent complete calendar years. This distinction is important when interpreting annual sales results and growth percentages.

### Customer Count Clarification

The `Sales.Customer` table contains 19,820 customer records.

Of these, 19,119 distinct customers appear in the sales order data. The remaining 701 customer records do not have recorded sales in the analyzed transactional data.

These two figures represent different measures: total customer records and customers with recorded sales.

---

## 3. Core Analytical Tables

| Schema | Table | Analytical Role |
|---|---|---|
| Sales | SalesOrderHeader | Sales order information |
| Sales | SalesOrderDetail | Sales transaction lines |
| Sales | Customer | Customer information |
| Sales | SalesTerritory | Territory information |
| Production | Product | Product information |
| Production | ProductSubcategory | Product subcategory classification |
| Production | ProductCategory | Product category classification |

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

### ProductSubcategory

One row represents one product subcategory.

### ProductCategory

One row represents one product category.

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

### ProductCategory → ProductSubcategory

One product category can contain multiple product subcategories.

### ProductSubcategory → Product

One product subcategory can contain multiple products.

These relationships support the analysis of sales performance across customers, products, product classifications, and territories.

---

## 6. Analytical Scope

The analysis focuses primarily on the Sales and Production schemas, with the following tables forming the core analytical model:

- Sales.SalesOrderHeader
- Sales.SalesOrderDetail
- Sales.Customer
- Sales.SalesTerritory
- Production.Product
- Production.ProductSubcategory
- Production.ProductCategory

The product classification tables are used to analyze sales at product category and subcategory levels.

The analysis uses sales order details as the transaction-level source for product quantities, discounts, and sales values, while sales order headers provide order dates, customer references, and territory information.

---

## 7. Data Validation Summary

The core analytical relationships were validated before conducting the business analysis.

The validation results confirmed:

- No NULL values were found in SalesOrderDetail.SalesOrderID.
- No NULL values were found in SalesOrderDetail.ProductID.
- No NULL values were found in SalesOrderHeader.CustomerID.
- No NULL values were found in SalesOrderHeader.TerritoryID.
- No orphaned sales order details were identified against SalesOrderHeader.
- No orphaned product references were identified.

The customer count was also distinguished between the total customer records and customers appearing in sales orders.

The validated analytical scope was considered suitable for the descriptive sales analysis.