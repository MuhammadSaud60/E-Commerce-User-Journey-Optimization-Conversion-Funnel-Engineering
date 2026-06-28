#  E-Commerce User Journey Optimization & Conversion Funnel Engineering

##  Project Overview

Understanding where customers leave the buying journey is essential for improving revenue. In this project, I analyzed an e-commerce conversion funnel using Power BI to identify drop-off points, compare device performance, and uncover trends affecting conversions.

The dashboard tracks users from their first homepage visit through search, checkout, and final payment confirmation, helping stakeholders identify optimization opportunities across the customer journey.


#  Business Objectives

The project answers the following business questions:

- Where do users abandon the purchasing journey?
- What is the overall conversion rate?
- Which device performs better?
- How effective is the checkout process?
- Did conversion performance change over time?

---

#  Tools & Technologies

- Power BI
- Power Query
- DAX
- Data Modeling
- Star Schema
- Data Visualization

---

#  Dataset

The project uses five transactional tables and one dimension table.

| Table | Description |
|--------|-------------|
| user_table | User profile information |
| home_page_table | Homepage visitors |
| search_page_table | Search page visits |
| payment_page_table | Checkout page visitors |
| payment_confirmation_table | Successful purchases |
| Funnel_Dimensions | Funnel stage configuration |

---

#  Data Model

The dashboard follows a **Star Schema**.

- Central User Dimension
- One-to-Many Relationships
- Dynamic filtering
- Optimized DAX calculations

This structure enables slicers such as device, gender, and date to filter every visual consistently.

---

#  Dashboard Features

The dashboard includes:

- KPI Cards
- Conversion Funnel
- Device Analysis
- Monthly Conversion Trend
- Funnel Drop-off Analysis
- Dynamic Filters
- Interactive Slicers

---

#  DAX Measures

## Total Homepage Users

```DAX
Total_Home_Users =
DISTINCTCOUNT(home_page_table[user_id])
```

## Total Conversions

```DAX
Total_Conversions =
DISTINCTCOUNT(payment_confirmation_table[user_id])
```

## Overall Conversion Rate

```DAX
Overall_Conversion_Rate =
DIVIDE(
    [Total_Conversions],
    [Total_Home_Users],
    0
)
```

## Purchase Conversion Rate

```DAX
Purchase_Conversion_Rate =
DIVIDE(
    [Total_Conversions],
    DISTINCTCOUNT(payment_page_table[user_id]),
    0
)
```

## Device Payment Drop-off Rate

```DAX
Device_Payment_Drop_Off =
VAR TotalPaymentUsers =
DISTINCTCOUNT(payment_page_table[user_id])

VAR TotalConfirmUsers =
DISTINCTCOUNT(payment_confirmation_table[user_id])

RETURN
DIVIDE(
TotalPaymentUsers - TotalConfirmUsers,
TotalPaymentUsers,
0
)
```

---

#  Key Findings

## 1. Significant Early Funnel Drop-off

| Stage | Users |
|--------|-------:|
| Homepage | 90.40K |
| Search | 45K |
| Payment | 6K |

- Nearly 50% of visitors leave before performing a search.
- Only a small fraction reach checkout.
- Overall conversion rate is only **0.50%**.

---

## 2. Desktop Checkout Underperforms

| Device | Drop-off Rate |
|---------|--------------:|
| Desktop | 95.02% |
| Mobile | 90.00% |

Possible causes include:

- Checkout bugs
- Slow page loading
- Desktop UI issues
- Poor user experience

---

## 3. Conversion Declined After March 2015

Analysis shows:

- Strong performance during January–February 2015.
- Sharp decline beginning in March.
- Low conversions continued through April.

This suggests a deployment or platform update negatively affected performance.

---

#  Recommendations

### Improve Desktop Checkout

- Optimize page speed
- Fix responsive issues
- Test payment flow
- Remove JavaScript errors

### Investigate March 2015 Deployment

- Review release history
- Analyze server logs
- Compare versions
- Roll back problematic updates

### Improve Early Funnel Engagement

- Enhance homepage navigation
- Improve search visibility
- Personalize recommendations
- Simplify the user journey

### Recover Lost Customers

- Cart abandonment emails
- Push notifications
- Checkout reminders
- Promotional offers

---

#  Business Impact

Implementing these improvements can:

- Increase conversion rates
- Reduce checkout abandonment
- Improve desktop experience
- Recover lost revenue
- Improve customer retention
- Optimize the entire sales funnel

---

#  Skills Demonstrated

- Data Cleaning
- Data Modeling
- Star Schema Design
- DAX
- Power BI Dashboard Development
- Funnel Analysis
- KPI Design
- Customer Journey Analysis
- Business Intelligence
- Data Storytelling
