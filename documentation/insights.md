# Business Insights

## 1. Overview

The sales analysis was conducted using AdventureWorks2022 transactional data.

The analysis covers:

* Sales performance over time
* Product-level sales performance
* Product category and subcategory performance
* Customer revenue concentration
* Sales territory performance
* Discount-related sales patterns

The insights below are based on the SQL analysis results and are descriptive in nature. They do not imply causation.

The observed sales period extends from May 31, 2011, to June 30, 2014. The first and last years are partial calendar years, which should be considered when interpreting annual comparisons.

---

## 2. Sales Performance Over Time

Sales performance varied across the observed period from 2011 to 2014.

| Year | Orders | Customers | Total Sales | Average Order Value | Sales Growth |
| ---- | -----: | --------: | ----------: | ------------------: | -----------: |
| 2011 | 1,607 | 1,406 | 12,641,672.21 | 7,866.63 | — |
| 2012 | 3,915 | 3,162 | 33,524,301.32 | 8,563.04 | 165.19% |
| 2013 | 14,182 | 11,095 | 43,622,479.05 | 3,075.90 | 30.12% |
| 2014 | 11,761 | 10,354 | 20,057,928.81 | 1,705.46 | -54.02% |

### Data Coverage Note

The annual results have different coverage periods:

- 2011 includes May–December (7 months).
- 2012 includes January–December (12 months).
- 2013 includes January–December (12 months).
- 2014 includes January–June (6 months).

Therefore, 2011 and 2014 are partial years, while 2012 and 2013 are complete calendar years.

### Key Observations

* Total sales increased across the observed period from 2011 to 2013, reaching the highest complete-year value of approximately **43.62M** in 2013.
* The reported sales growth in 2012 was approximately **165.19%** compared with 2011. However, this comparison is affected by the partial coverage of 2011.
* Sales increased by approximately **30.12%** in 2013 compared with 2012. Both years represent complete calendar years, making this the most directly comparable annual growth figure in the observed period.
* 2014 recorded approximately **20.06M** in sales, covering January through June only. The reported **-54.02%** comparison with 2013 should not be interpreted as a full-year decline.
* Order volume increased substantially between 2011 and 2013, reaching **14,182 orders** in 2013.
* Average Order Value peaked in 2012 at approximately **8,563.04**, then declined in 2013 and the first half of 2014.

### Business Interpretation

The increase in sales through 2013 was accompanied by a significant increase in order volume, while Average Order Value declined after 2012.

This pattern indicates that higher transaction volume was an important component of sales growth through 2013.

The available 2014 data represents only the first six months of the year. Therefore, a full-year comparison with 2013 cannot be made from the available data.

---

## 3. Product Performance

Product-level analysis was evaluated using two complementary measures: **sales revenue** and **sales volume**.

### Top Products by Sales Revenue

| Rank | Product | Units Sold | Total Sales |
| ---: | ----------------------- | ---------: | -----------: |
| 1 | Mountain-200 Black, 38 | 2,977 | 4,400,592.80 |
| 2 | Mountain-200 Black, 42 | 2,664 | 4,009,494.76 |
| 3 | Mountain-200 Silver, 38 | 2,394 | 3,693,678.03 |
| 4 | Mountain-200 Silver, 42 | 2,234 | 3,438,478.86 |
| 5 | Mountain-200 Silver, 46 | 2,216 | 3,434,256.94 |

### Top Products by Sales Volume

| Rank | Product | Units Sold | Total Sales |
| ---: | ------------------------------- | ---------: | ----------: |
| 1 | AWC Logo Cap | 8,311 | 51,229.45 |
| 2 | Water Bottle - 30 oz. | 6,815 | 28,654.16 |
| 3 | Sport-100 Helmet, Blue | 6,743 | 165,406.62 |
| 4 | Long-Sleeve Logo Jersey, L | 6,592 | 198,754.98 |
| 5 | Sport-100 Helmet, Black | 6,532 | 160,869.52 |
| 6 | Sport-100 Helmet, Red | 6,266 | 157,772.39 |
| 7 | Classic Vest, S | 4,247 | 156,398.07 |
| 8 | Patch Kit/8 Patches | 3,865 | 8,232.60 |
| 9 | Short-Sleeve Classic Jersey, XL | 3,864 | 129,145.57 |
| 10 | Long-Sleeve Logo Jersey, M | 3,636 | 115,249.21 |

### Key Observations

* **Mountain-200 Black, 38** generated the highest sales revenue among individual products, at approximately **4.40M**.
* The top six products by sales revenue were all variants of the **Mountain-200** product line.
* **AWC Logo Cap** recorded the highest sales volume, with **8,311 units sold**, despite generating approximately **51.23K** in sales revenue.
* The products with the highest sales volume were substantially different from those generating the highest sales revenue.
* For example, Mountain-200 Black, 38 generated approximately **4.40M** from 2,977 units, while AWC Logo Cap generated approximately **51.23K** from 8,311 units.

### Business Interpretation

The results demonstrate that **sales revenue and sales volume capture different dimensions of product performance**.

High-volume products do not necessarily generate the highest revenue, while products with lower unit volumes can generate substantially higher sales revenue.

Product performance should therefore be evaluated using both measures rather than relying on unit volume alone.

---

## 4. Product Category and Subcategory Performance

Product category analysis shows a substantial concentration of revenue in the Bikes category.

| Category | Total Sales | Revenue Share |
| ----------- | ------------: | ------------: |
| Bikes | 94,651,172.70 | 86.17% |
| Components | 11,802,593.29 | 10.74% |
| Clothing | 2,120,542.52 | 1.93% |
| Accessories | 1,272,072.88 | 1.16% |

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

This revenue concentration indicates that changes in the performance of core bicycle products could have a substantial effect on overall sales performance. Further analysis would be required to understand the underlying drivers of this concentration.

---

## 5. Customer Revenue Concentration

Customer-level analysis indicates a high concentration of revenue among a relatively small portion of customers with recorded sales.

| Revenue Threshold Reached | Customers Required | Share of 19,119 Customers with Sales |
| ------------------------: | -----------------: | -----------------------------------: |
| 50% | 133 | ~0.70% |
| 80% | 1,607 | ~8.41% |
| 90% | 3,947 | ~20.65% |

There are **19,119 customers with recorded sales**, compared with **19,820 total customers** in the `Sales.Customer` table. Therefore, **701 registered customers** had no recorded sales in the analyzed transactional data.

### Key Observations

* **133 customers** are required to reach at least 50% of cumulative customer revenue.
* **1,607 customers** are required to reach at least 80% of cumulative customer revenue.
* **3,947 customers** are required to reach at least 90% of cumulative customer revenue.
* The top 20 customers individually generated between approximately **602.56K and 877.11K** in sales.

### Business Interpretation

Revenue is highly concentrated among a relatively small group of customers with recorded sales.

This concentration highlights the importance of understanding the purchasing behavior of high-revenue customers. At the same time, the degree of concentration may represent a potential business risk if overall sales are heavily dependent on a limited portion of the customer base.

Further customer segmentation would be useful before developing customer-specific commercial recommendations.

---

## 6. Territory Performance

Sales performance varies substantially across sales territories.

| Territory | Orders | Units Sold | Total Sales | Revenue Share | AOV |
| -------------- | -----: | ---------: | ------------: | ------------: | --------: |
| Southwest | 6,224 | 59,105 | 24,184,609.60 | 22.02% | 3,885.70 |
| Canada | 4,067 | 49,381 | 16,355,770.45 | 14.89% | 4,021.58 |
| Northwest | 4,594 | 36,776 | 16,084,942.55 | 14.64% | 3,501.29 |
| Australia | 6,843 | 18,293 | 10,655,335.96 | 9.70% | 1,557.11 |
| Central | 385 | 19,493 | 7,909,009.01 | 7.20% | 20,542.88 |
| Southeast | 486 | 18,875 | 7,879,655.07 | 7.17% | 16,213.28 |
| United Kingdom | 3,219 | 20,099 | 7,670,721.04 | 6.98% | 2,382.95 |
| France | 2,672 | 19,906 | 7,251,555.65 | 6.60% | 2,713.91 |
| Northeast | 352 | 19,843 | 6,939,374.48 | 6.32% | 19,714.13 |
| Germany | 2,623 | 13,143 | 4,915,407.60 | 4.47% | 1,873.96 |

### Key Observations

* **Southwest** generated the highest sales revenue, accounting for **22.02%** of total sales.
* Southwest, Canada, and Northwest collectively contributed **51.55%** of total sales revenue.
* **Australia** recorded the highest number of orders at **6,843**, but ranked fourth in total sales revenue.
* Several territories recorded substantially higher Average Order Values despite having relatively fewer orders.
* Sales revenue, order volume, and Average Order Value do not always move together.

### Business Interpretation

Territory performance differs depending on the metric being considered.

Southwest is the largest territory by sales revenue, while Australia has the highest order volume. Central, Southeast, and Northeast show relatively high Average Order Values despite having substantially fewer orders.

These differences identify territories that may warrant further investigation, but the current analysis does not establish the reasons behind the observed differences.

---

## 7. Discount-Related Sales Patterns

Discount analysis was performed at the sales-line level because individual sales orders can contain multiple discount levels.

### Discount Level Distribution

| Discount Rate | Sales Lines | Units Sold | Net Sales |
| ------------: | ----------: | ---------: | -------------: |
| 0% | 118,035 | 241,095 | 104,423,692.40 |
| 2% | 1,310 | 16,063 | 2,891,221.68 |
| 5% | 606 | 10,713 | 1,037,643.33 |
| 10% | 178 | 2,813 | 131,597.36 |
| 15% | 590 | 2,326 | 454,082.08 |
| 20% | 231 | 762 | 581,331.63 |
| 30% | 61 | 304 | 49,986.08 |
| 35% | 137 | 456 | 250,927.70 |
| 40% | 169 | 382 | 25,899.14 |

### Discounted vs Non-Discounted Sales

| Discount Status | Sales Lines | Units Sold | Gross Sales | Discount Amount | Net Sales |
| --------------- | ----------: | ---------: | -------------: | --------------: | -------------: |
| No Discount | 118,035 | 241,095 | 104,423,692.40 | 0.00 | 104,423,692.40 |
| Discounted | 3,282 | 33,819 | 5,950,196.91 | 527,507.93 | 5,422,689.00 |

### Key Observations

* Approximately **97.3%** of sales lines were recorded without a discount.
* Discounted sales lines represented approximately **2.7%** of all sales lines.
* Discounted sales lines generated approximately **5.42M** in net sales.
* The total calculated discount amount across discounted sales lines was approximately **527.5K**.
* Net sales varied across discount levels without showing a consistent monotonic pattern.
* Some sales orders contain multiple discount levels, so classifying an entire order by its maximum discount would not provide a reliable representation of order-level discount behavior.

### Business Interpretation

Discounts represent a relatively small portion of sales-line activity in the analyzed dataset.

The analysis identifies differences in sales volume and revenue across discount levels, but these patterns should be interpreted descriptively. The available data does not establish that applying a particular discount level caused sales to increase or decrease.

Further analysis would be required to evaluate discount effectiveness, including product mix, timing, customer characteristics, and other contextual factors.

### Discount Patterns by Product Subcategory

The subcategory analysis examines the percentage of sales lines with a discount within each product subcategory.

Selected results show substantial variation in discount incidence:

| Product Subcategory | Discounted Sales Lines (%) |
| ------------------- | -------------------------: |
| Vests | 12.52% |
| Touring Bikes | 11.93% |
| Bike Racks | 7.79% |
| Shorts | 7.51% |
| Tights | 6.76% |
| Helmets | 3.77% |
| Mountain Bikes | 2.98% |
| Road Bikes | 1.18% |
| Bottles and Cages | 0.65% |
| Tires and Tubes | 0.01% |

### Key Observations

* **Vests** recorded the highest discounted sales-line percentage among the analyzed subcategories, at **12.52%**.
* **Touring Bikes** followed at **11.93%**.
* Road Bikes and Mountain Bikes recorded lower discounted sales-line percentages of **1.18%** and **2.98%**, respectively.
* Some subcategories, such as Tires and Tubes, had very low discount incidence.

### Business Interpretation

Discount usage varies considerably across product subcategories and is not distributed uniformly across the product range.

For example, Vests and Touring Bikes have a higher proportion of discounted sales lines than Road Bikes and Mountain Bikes.

These percentages represent the share of sales lines with a discount within each subcategory. They do not represent the percentage of revenue discounted and do not establish that discounts caused higher or lower sales.

This analysis adds product-level context to the overall discount findings and identifies differences in discount usage that may warrant further investigation.

---

## 8. Initial Business Implications

Based on the completed descriptive analysis, several areas may receive further investigation:

### 1. Sales Trend Analysis

* Consider comparing January–June 2014 with the same period in 2013 to obtain a more comparable partial-year view.
* Examine changes in order volume and Average Order Value when evaluating sales trends over time.

### 2. Product Portfolio Analysis

* Further examine the performance of high-revenue products.
* Compare revenue and unit volume to distinguish high-value products from high-volume products.

### 3. Revenue Concentration

* Further investigate the high concentration of revenue within the Bikes category.
* Examine the degree of revenue concentration among high-value customers.

### 4. Customer Analysis

* Segment customers based on revenue, order frequency, and purchasing behavior.
* Examine whether high-revenue customers also demonstrate high purchase frequency.

### 5. Territory Analysis

* Investigate the differences between high-revenue and high-order-volume territories.
* Examine the characteristics of territories with unusually high Average Order Values.

### 6. Discount Analysis

* Investigate the product and customer mix associated with discounted sales.
* Examine the differences in discount incidence across product subcategories.
* Consider additional context before evaluating discount effectiveness.

These areas represent potential directions for further analysis rather than conclusions established by the current descriptive results.

---

## 9. Analysis Limitations

The current insights are based on descriptive analysis of the AdventureWorks2022 transactional dataset.

The analysis does not establish causal relationships.

In particular:

* Revenue is analyzed using sales transaction values and does not represent profitability.
* Discount analysis describes sales patterns across discount levels but does not measure causal discount effectiveness.
* Discounted sales-line percentages by subcategory describe discount incidence within each subcategory; they do not measure the effect of discounts on sales.
* Territory analysis describes differences in sales performance but does not explain their underlying causes.
* External market conditions and business context are not included.
* The available 2014 data covers January through June only. It does not support conclusions about a full-year decline compared with 2013.
* The 2011 data also covers only part of the calendar year, so the reported 2012 growth compared with 2011 should be interpreted with caution.
* Product-level revenue concentration has not been formally quantified using a cumulative revenue or revenue-share analysis.
* Customer revenue concentration is based on cumulative sales revenue and should not be interpreted as profit concentration.
* Discount analysis is performed at the sales-line level because some orders contain multiple discount levels.
* Differences in discount usage across product subcategories do not explain the reasons behind discount allocation or establish an impact on sales performance.