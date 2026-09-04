# Business Insights

## 1. Overview

The initial sales analysis was conducted using AdventureWorks2022 transactional data.

The analysis currently covers:

* Sales performance over time
* Product-level sales performance
* Product category and subcategory performance
* Customer revenue concentration

The insights below are based on the SQL analysis results and are descriptive in nature. They do not imply causation.

---

## 2. Sales Performance Over Time

Sales performance changed substantially across the analyzed period from 2011 to 2014.

| Year | Orders | Customers |   Total Sales | Average Order Value | Sales Growth |
| ---- | -----: | --------: | ------------: | ------------------: | -----------: |
| 2011 |  1,607 |     1,406 | 12,641,672.21 |            7,866.63 |            — |
| 2012 |  3,915 |     3,162 | 33,524,301.32 |            8,563.04 |      165.19% |
| 2013 | 14,182 |    11,095 | 43,622,479.05 |            3,075.90 |       30.12% |
| 2014 | 11,761 |    10,354 | 20,057,928.81 |            1,705.46 |      -54.02% |

### Key Observations

* Total sales increased sharply from 2011 to 2013, reaching the highest annual value of approximately **43.62M** in 2013.
* Sales growth was strongest in 2012, when total sales increased by approximately **165.19%** compared with 2011.
* Sales continued to grow in 2013, increasing by approximately **30.12%** compared with 2012.
* In 2014, total sales declined by approximately **54.02%** compared with 2013.
* Order volume increased substantially between 2011 and 2013, reaching **14,182 orders** in 2013.
* Average Order Value peaked in 2012 at approximately **8,563.04**, then declined considerably in 2013 and 2014.

### Business Interpretation

The results indicate a substantial change in sales activity across the analyzed period.

The increase in sales through 2013 was accompanied by a significant increase in order volume, while Average Order Value declined after 2012. This pattern suggests that higher transaction volume was an important component of sales growth through 2013.

The sharp decline in 2014 should be investigated further to determine whether it is associated with changes in sales activity, customer activity, product mix, or other business factors.

---

## 3. Product Performance

Product-level analysis shows that several individual products generated substantially higher sales revenue than others.

The highest-revenue products were:

| Rank | Product                 | Units Sold |  Total Sales |
| ---: | ----------------------- | ---------: | -----------: |
|    1 | Mountain-200 Black, 38  |      2,977 | 4,400,592.80 |
|    2 | Mountain-200 Black, 42  |      2,664 | 4,009,494.76 |
|    3 | Mountain-200 Silver, 38 |      2,394 | 3,693,678.03 |
|    4 | Mountain-200 Silver, 42 |      2,234 | 3,438,478.86 |
|    5 | Mountain-200 Silver, 46 |      2,216 | 3,434,256.94 |

### Key Observations

* The highest-revenue products include several variants from the **Mountain-200** product line.
* The top product generated approximately **4.40M** in sales.
* Several variants from the Mountain-200 and Road-250 product lines appear among the highest-revenue products.
* Sales revenue is not determined by unit volume alone. Products with high unit sales do not necessarily generate the highest total revenue.

### Business Interpretation

The results show that high-revenue bicycle products make a substantial contribution to sales performance.

Product-level analysis should therefore consider both **sales revenue and sales volume**, since these measures capture different aspects of product performance.

---

## 4. Product Category and Subcategory Performance

Product category analysis shows a substantial concentration of revenue in the Bikes category.

| Category    |   Total Sales | Revenue Share |
| ----------- | ------------: | ------------: |
| Bikes       | 94,651,172.70 |        86.17% |
| Components  | 11,802,593.29 |        10.74% |
| Clothing    |  2,120,542.52 |         1.93% |
| Accessories |  1,272,072.88 |         1.16% |

### Key Observations

* **Bikes** generated approximately **86.17%** of total sales revenue.
* Components contributed approximately **10.74%**.
* Clothing and Accessories together accounted for approximately **3.09%** of revenue.
* Within the Bikes category, the leading subcategories were:

  * Road Bikes: approximately **43.91M**
  * Mountain Bikes: approximately **36.45M**
  * Touring Bikes: approximately **14.30M**
* Road Bikes were the highest-revenue subcategory.

### Business Interpretation

The Bikes category represents the dominant source of sales revenue in the analyzed dataset.

Within Bikes, Road Bikes and Mountain Bikes are the strongest revenue-generating subcategories.

This revenue concentration means that changes in demand for core bicycle products could have a substantial effect on overall sales performance. Further analysis is required to understand the underlying drivers of this concentration.

---

## 5. Customer Revenue Concentration

Customer-level analysis indicates a high concentration of revenue among a relatively small portion of the customer base.

The cumulative revenue analysis shows:

| Revenue Threshold Reached | Customers Required | Share of 19,119 Customers |
| ------------------------: | -----------------: | ------------------------: |
|                       50% |                133 |                    ~0.70% |
|                       80% |              1,607 |                    ~8.41% |
|                       90% |              3,947 |                   ~20.65% |

### Key Observations

* **133 customers** are required to reach at least 50% of cumulative customer revenue.
* **1,607 customers** are required to reach at least 80% of cumulative customer revenue.
* **3,947 customers** are required to reach at least 90% of cumulative customer revenue.
* The top 20 customers individually generated between approximately **602.56K and 877.11K** in sales.

### Business Interpretation

Revenue is highly concentrated among a relatively small group of customers.

This concentration highlights the importance of understanding the purchasing behavior of high-revenue customers. At the same time, the degree of concentration may represent a potential business risk if overall sales are heavily dependent on a limited portion of the customer base.

Further customer segmentation would be useful before developing customer-specific commercial recommendations.

---

## 6. Initial Business Implications

Based on the current analysis, several areas should receive further investigation:

### 1. Sales Trend Investigation

* Investigate the substantial decline in sales during 2014.
* Examine whether the decline is associated with changes in order volume, customer activity, or product mix.

### 2. Product Portfolio Analysis

* Further examine the performance of high-revenue products.
* Compare revenue and unit volume to distinguish high-value products from high-volume products.

### 3. Revenue Concentration

* Further investigate the high concentration of revenue within the Bikes category.
* Examine the degree of revenue concentration among high-value customers.

### 4. Customer Analysis

* Segment customers based on revenue, order frequency, and purchasing behavior.
* Examine whether high-revenue customers also demonstrate high purchase frequency.

### 5. Further Analysis Required

* Territory performance
* Discount and sales-volume relationships
* Additional customer behavior analysis

These areas should be investigated before developing final business recommendations.

---

## 7. Analysis Limitations

The current insights are based on descriptive analysis of the AdventureWorks2022 transactional dataset.

The analysis does not establish causal relationships.

In particular:

* Revenue is analyzed using sales transaction values and does not represent profitability.
* Discount-related sales patterns have not yet been analyzed.
* Territory performance has not yet been analyzed.
* External market conditions and business context are not included.
* The observed 2014 decline should not be attributed to a specific cause without further analysis.
* Product-level revenue concentration has not been formally quantified using a cumulative revenue or revenue-share analysis.
* Customer revenue concentration is based on cumulative sales revenue and should not be interpreted as profit concentration.
