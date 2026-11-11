# Data Validation

## 1. Validation Scope

Validation was performed on the core analytical tables used for the sales analysis:

- Sales.SalesOrderHeader
- Sales.SalesOrderDetail
- Sales.Customer
- Sales.SalesTerritory
- Production.Product

Product classification tables were also inspected as part of the analytical model.

The validation focused on:

- Row counts
- NULL values in key relationship columns
- Distinct entity counts
- Referential integrity
- Primary and foreign key structure

---

## 2. Row Count Validation

The following row counts were confirmed for the core analytical tables:

| Table / Entity | Row Count |
|---|---:|
| SalesOrderDetail | 121,317 |
| SalesOrderHeader | 31,465 |
| Customer | 19,820 |
| Product | 2,016 |
| SalesTerritory | 10 |

### Customer Count Clarification

The total number of records in `Sales.Customer` is **19,820**.

A separate distinct count of `CustomerID` in `Sales.SalesOrderHeader` identified **19,119 customers with recorded sales**.

Therefore, **701 customer records** do not appear in the analyzed sales orders.

These figures represent different measures and should not be interpreted as conflicting row counts.

---

## 3. NULL Validation

The following key foreign key columns were checked:

| Table | Column | NULL Records |
|---|---|---:|
| SalesOrderDetail | SalesOrderID | 0 |
| SalesOrderDetail | ProductID | 0 |
| SalesOrderHeader | CustomerID | 0 |
| SalesOrderHeader | TerritoryID | 0 |

No NULL values were identified in these key analytical relationship columns.

---

## 4. Referential Integrity

The following relationships were explicitly checked:

| Relationship | Orphan Records |
|---|---:|
| SalesOrderDetail → SalesOrderHeader | 0 |
| SalesOrderDetail → Product | 0 |

No orphan records were identified in the tested relationships.

---

## 5. Primary and Foreign Key Structure

Primary and foreign key metadata was inspected to confirm the database relationships used in the analytical model.

Key relationships include:

- SalesOrderHeader.SalesOrderID → SalesOrderDetail.SalesOrderID
- Customer.CustomerID → SalesOrderHeader.CustomerID
- SalesTerritory.TerritoryID → SalesOrderHeader.TerritoryID
- Product.ProductID → SalesOrderDetail.ProductID

Product classification relationships used in the analysis include:

- Product.ProductSubcategoryID → ProductSubcategory.ProductSubcategoryID
- ProductSubcategory.ProductCategoryID → ProductCategory.ProductCategoryID

These relationships support the analytical joins used for sales, customer, territory, and product classification analysis.

---

## 6. Validation Conclusion

The core analytical relationships and key fields were validated successfully.

The validation checks confirmed:

- No NULL values in the tested key relationship columns.
- No orphaned sales order details referencing missing sales orders.
- No orphaned sales order details referencing missing products.
- A clear distinction between total customer records and customers with recorded sales.

The validated dataset was considered suitable for proceeding with the descriptive business analysis.