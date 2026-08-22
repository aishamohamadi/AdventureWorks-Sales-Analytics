# Data Validation

## 1. Validation Scope

Validation was performed on the core analytical tables used for the
sales analysis:

- Sales.SalesOrderHeader
- Sales.SalesOrderDetail
- Sales.Customer
- Sales.SalesTerritory
- Production.Product

The validation focused on key relationships, NULL values, and
referential integrity.

---

## 2. Row Count Validation

The following row counts were confirmed for the core analytical tables:

| Table | Row Count |
|---|---:|
| SalesOrderDetail | 121,317 |
| SalesOrderHeader | 31,465 |
| Customer | 19,119 |
| Product | 2,016 |
| SalesTerritory | 10 |

---

## 3. NULL Validation

The following key foreign key columns were checked:

| Table | Column | NULL Records |
|---|---|---:|
| SalesOrderDetail | SalesOrderID | 0 |
| SalesOrderDetail | ProductID | 0 |
| SalesOrderHeader | CustomerID | 0 |
| SalesOrderHeader | TerritoryID | 0 |

No NULL values were identified in these key analytical relationship
columns.

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

Primary and foreign key metadata was inspected to confirm the database
relationships used in the analytical model.

Key relationships include:

- SalesOrderHeader.SalesOrderID → SalesOrderDetail.SalesOrderID
- Customer.CustomerID → SalesOrderHeader.CustomerID
- SalesTerritory.TerritoryID → SalesOrderHeader.TerritoryID
- Product.ProductID → SalesOrderDetail.ProductID

---

## 6. Validation Conclusion

The core analytical relationships and key fields were validated
successfully.

No NULL values were identified in the tested foreign key columns, and
no orphan records were identified in the tested relationships.

The validated dataset was considered suitable for proceeding to
business analysis.