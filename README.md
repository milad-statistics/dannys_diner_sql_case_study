# Danny's Diner — SQL Case Study

## Project Overview

This project is a practical SQL case study based on **Danny's Diner**, part of the [8 Week SQL Challenge](https://8weeksqlchallenge.com/).

The goal of the analysis is to explore customer spending, visit frequency, menu preferences, membership behavior, and loyalty points using PostgreSQL.

The project focuses on answering business questions with SQL rather than simply querying data. It demonstrates how transactional data can be transformed into useful customer and business insights.

## Dataset

Danny's Diner contains three main tables:

- **sales** — customer purchases and order dates
- **menu** — menu items and prices
- **members** — customer membership and join dates

## Business Questions

The case study answers 10 main business questions and 2 bonus questions covering:

- Customer spending
- Visit frequency
- First purchases
- Menu popularity
- Customer preferences
- Pre- and post-membership purchases
- Loyalty points
- Membership-based ranking

---

# Analysis & Results

## 1. Total Amount Spent by Each Customer

**Question:** What is the total amount each customer spent at the restaurant?

| Customer | Total Spent |
|---|---:|
| A | $76 |
| B | $74 |
| C | $36 |

**Insight:** Customer A spent the most overall, followed closely by customer B.

---

## 2. Number of Days Each Customer Visited

**Question:** How many days has each customer visited the restaurant?

| Customer | Visit Days |
|---|---:|
| A | 4 |
| B | 6 |
| C | 2 |

**Insight:** Customer B visited the restaurant on the greatest number of distinct days.

---

## 3. First Item Purchased by Each Customer

**Question:** What was the first item from the menu purchased by each customer?

| Customer | First Purchase(s) |
|---|---|
| A | Curry, Sushi |
| B | Curry |
| C | Ramen |

Multiple items are shown where the customer purchased multiple items on their first purchase date.

---

## 4. Most Purchased Menu Item

**Question:** What is the most purchased item on the menu and how many times was it purchased by all customers?

| Item | Purchases |
|---|---:|
| Ramen | 8 |

**Insight:** Ramen was the most purchased menu item overall, with 8 purchases.

---

## 5. Most Popular Item for Each Customer

**Question:** Which item was the most popular for each customer?

| Customer | Most Popular Item(s) |
|---|---|
| A | Ramen |
| B | Sushi, Curry, Ramen |
| C | Ramen |

**Insight:** Ramen was the most popular item for customers A and C. Customer B had a three-way tie between Sushi, Curry, and Ramen.

---

## 6. First Purchase After Becoming a Member

**Question:** Which item was purchased first by the customer after they became a member?

| Customer | First Purchase After Joining |
|---|---|
| A | Curry |
| B | Sushi |

Customer C did not become a member, so this analysis does not apply to C.

---

## 7. Purchase Just Before Becoming a Member

**Question:** Which item was purchased just before the customer became a member?

| Customer | Last Purchase Before Joining |
|---|---|
| A | Sushi, Curry |
| B | Sushi |

Customer C did not become a member, so this analysis does not apply to C.

---

## 8. Total Items and Amount Spent Before Membership

**Question:** What is the total items and amount spent for each member before they became a member?

| Customer | Items | Amount Spent |
|---|---:|---:|
| A | 2 | $25 |
| B | 3 | $40 |

Customer C did not become a member, so there is no pre-membership period for C to analyze.

---

## 9. Loyalty Points

**Question:** If each $1 spent earns 10 points and sushi has a 2x points multiplier, how many points would each customer have?

| Customer | Points |
|---|---:|
| A | 860 |
| B | 940 |
| C | 360 |

**Insight:** Customer B earned the highest number of loyalty points under the specified scoring rules.

---

## 10. Points at the End of January

**Question:** In the first week after a customer joins the program, including their join date, they earn 2x points on all items. How many points do customers have at the end of January?

| Customer | Points |
|---|---:|
| A | 1,370 |
| B | 820 |

Customer C did not become a member, so the membership-based bonus does not apply to C.

---

# Bonus Questions

## Bonus 1 — Join All The Things

The `sales`, `menu`, and `members` tables were combined to create a purchase-level view containing the customer, order date, product, price, and membership status.

Membership status was determined for each individual purchase:

- `Y` — the purchase was made on or after the customer's join date
- `N` — the purchase was made before the join date, or the customer never became a member

This required combining multiple tables and applying conditional business logic with `CASE`.

## Bonus 2 — Rank All The Things

The combined purchase-level dataset was extended with a ranking column.

Only purchases made after the customer became a member receive a visible ranking. Non-member purchases receive `NULL`.

The ranking analysis demonstrates the use of:

- `CASE`
- `RANK()`
- `PARTITION BY`
- `ORDER BY`
- Common Table Expressions (CTEs)

---

# SQL Skills Demonstrated

This case study demonstrates practical PostgreSQL skills including:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `DISTINCT`
- `ORDER BY`
- `LIMIT`
- `SUM()` and `COUNT()`
- `CASE`
- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- `PARTITION BY`
- Date filtering and date arithmetic
- Conditional business logic

---

# Key Business Insights

- **Customer A** generated the highest total spending at **$76**.
- **Customer B** visited on the most distinct days, with **6 visit days**.
- **Ramen** was the most purchased menu item overall, with **8 purchases**.
- Ramen was also the most popular item for customers A and C.
- Customer B had an equal preference for Sushi, Curry, and Ramen.
- Customer B earned the highest loyalty points under the standard points rules, with **940 points**.
- Membership timing can be analyzed at the individual purchase level to distinguish pre-membership and post-membership behavior.

---

# Project Structure

```text
dannys-diner/
│
├── README.md
└── dannys_diner.sql
```

The `dannys_diner.sql` file contains the SQL queries used to answer all 10 main questions and both bonus questions.

---

# Conclusion

Danny's Diner is a compact but practical SQL case study covering customer behavior, purchasing patterns, membership analysis, and loyalty programs.

The project demonstrates how SQL can be used to answer structured business questions and turn transactional data into clear business insights.

This case study is part of a broader data analytics portfolio focused on practical SQL and data analysis skills.
