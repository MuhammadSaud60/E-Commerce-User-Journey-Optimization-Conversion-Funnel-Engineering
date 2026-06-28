# E-Commerce User Journey Optimization and Conversion Funnel Engineering

## Project Overview
Digital platforms track millions of web interactions daily, but converting raw traffic into successful transactions remains a major challenge. In this project, I analyzed a multi-stage user journey from homepage entry to final payment confirmation. The main goal was to find out where users drop off, evaluate performance differences between mobile and desktop devices, and deliver clear insights to help improve the platform's overall conversion rate.

---

## Data Architecture and Relationship Modeling
The data model for this project is built using a clean Star Schema design in Power BI to ensure calculations remain dynamic and accurate. 

I used a central user dimension table connected to individual activity log tables through One-to-Many relationships. This setup allows filters like gender, device, and dates to automatically update the entire dashboard when selected.

The data pipeline utilizes the following tables:
* **user_table**: Contains user profile attributes including user id, date, device type, and gender.
* **home_page_table**: Logs unique user sessions landing on the main homepage.
* **search_page_table**: Records user interactions where browse or search actions were triggered.
* **payment_page_table**: Tracks users who initiated the checkout process and reached the billing screen.
* **payment_confirmation_table**: Logs successful transactions, generating the final purchase data.
* **Funnel_Dimensions**: A custom configuration table containing the funnel stages and a sort order column to ensure correct visual arrangement.

---

## Key Metrics and DAX Logic
To track user progression and calculate abandonment rates across the platform, I created custom DAX measures. 

### Total Traffic
Calculated by counting unique user IDs on the homepage:
```dax
Total_Home_Users = DISTINCTCOUNT(home_page_table[user_id])
