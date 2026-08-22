# Data Validation

## 1. Row Count Validation

The database contains 760,837 rows across its tables.

The core sales tables contain:

- 121,317 sales order lines
- 31,465 sales orders
- 19,119 customers
- 266 products appearing in sales
- 10 sales territories


## 2. NULL Validation

The following key columns were checked:

| Table | Column | NULL Records |
|---|---|---:|
| SalesOrderDetail | SalesOrderID | 0 |
| SalesOrderDetail | ProductID | 0 |
| SalesOrderHeader | CustomerID | 0 |
| SalesOrderHeader | TerritoryID | 0 |


## 3. Referential Integrity

SalesOrderDetail → SalesOrderHeader

Orphan records: 0

SalesOrderDetail → Product

Orphan records: 0


## 4. Validation Conclusion

The primary analytical relationships required for the sales analysis
were validated successfully before proceeding to business analysis.