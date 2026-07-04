

-- TOTAL TRAFFIC

SELECT COUNT(user_id)
FROM `graphite-shell-464603-c6.funnel_analysis_projects.user`;

-- SEARCH CONVERSATION (%)


-- Payment Initiation (%)
-- Purchase Conversion Rate (%)
-- Overall Baseline Conversion Rate (%)
-- Total Drop-off Rate (%)

-- What is the absolute number and percentage of users remaining at each stage of the conversion funnel?

WITH funnel_stages AS(
  SELECT
    COUNT(DISTINCT home.user_id) as users_in_home_page,
    COUNT(DISTINCT search_page.user_id) as users_in_search_page,
    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_payment_confirm_page

    FROM `graphite-shell-464603-c6.funnel_analysis_projects.home`  as home

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.search_page` as search_page
    ON home.user_id = search_page.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment
    ON search_page.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id

)

SELECT 
  users_in_home_page,
  (users_in_home_page/users_in_home_page) * 100 as home_page_rate,
  users_in_search_page,
  ROUND((users_in_search_page/users_in_home_page) * 100, 2) as home_to_search_rate,
  users_in_payment_page,
  ROUND((users_in_payment_page/users_in_search_page) * 100, 2) as search_to_payment_rate,
  users_in_payment_confirm_page,
  ROUND((users_in_payment_confirm_page/users_in_payment_page) * 100,2) as payment_to_confirm_rate,
  

  -- overall conversation rate
  ROUND((users_in_payment_confirm_page * 100.0) / users_in_home_page) as over_all_conversation_rate
FROM funnel_stages;

-- At which specific stage of the funnel does the highest percentage of user drop-off occur?

WITH funnel_stages AS(
  SELECT
    COUNT(DISTINCT home.user_id) as users_in_home_page,
    COUNT(DISTINCT search_page.user_id) as users_in_search_page,
    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_payment_confirm_page

    FROM `graphite-shell-464603-c6.funnel_analysis_projects.home`  as home

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.search_page` as search_page
    ON home.user_id = search_page.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment
    ON search_page.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id

)

SELECT 
  ((users_in_home_page - users_in_search_page) / users_in_home_page) * 100 AS Home_to_Search_DropOff,
  ROUND(((users_in_search_page - users_in_payment_page) / users_in_search_page) * 100, 2) AS Search_to_Payment_DropOff,
  ROUND(((users_in_payment_page - users_in_payment_confirm_page) / users_in_payment_page) * 100, 2) AS Payment_to_confirm_DropOff




FROM funnel_stages;

-- How does the funnel conversion rate differ between Male and Female users? Is there a specific stage where one gender drops off significantly more than the other?

WITH funnel_stages AS(
  SELECT
    user.sex as gender,
    COUNT(DISTINCT home.user_id) as users_in_home_page,
    COUNT(DISTINCT search_page.user_id) as users_in_search_page,
    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_payment_confirm_page

    FROM  `graphite-shell-464603-c6.funnel_analysis_projects.home`  as home

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.user` as user
    ON user.user_id = home.user_id

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.search_page` as search_page
    ON home.user_id = search_page.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment
    ON search_page.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id
    GROUP BY user.sex
)


SELECT 
  gender,
  users_in_home_page,
  ROUND((users_in_search_page/users_in_home_page) * 100, 2) as home_to_search_rate,
  ROUND((users_in_payment_page/users_in_search_page) * 100, 2) as search_to_payment_rate,
  ROUND((users_in_payment_confirm_page/users_in_payment_page) * 100,2) as payment_to_confirm_rate
  
FROM funnel_stages;





-- Which device type (Desktop, Mobile, etc.) yields the highest overall conversion rate from home page to payment confirmation?
WITH funnel_stages AS(
  SELECT
    user.device as device,
    COUNT(DISTINCT home.user_id) as users_in_home_page,
    COUNT(DISTINCT search_page.user_id) as users_in_search_page,
    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_payment_confirm_page

    FROM  `graphite-shell-464603-c6.funnel_analysis_projects.home`  as home

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.user` as user
    ON user.user_id = home.user_id

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.search_page` as search_page
    ON home.user_id = search_page.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment
    ON search_page.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id
    
    

    GROUP BY user.device
)


SELECT 
  device,
  users_in_home_page,
 
  ROUND((users_in_search_page/users_in_home_page) * 100, 2) as home_to_search_rate,
 
  ROUND((users_in_payment_page/users_in_search_page) * 100, 2) as search_to_payment_rate,
 
  ROUND((users_in_payment_confirm_page/users_in_payment_page) * 100,2) as payment_to_confirm_rate
  
FROM funnel_stages;




-- Is there a specific device that experiences an unusually high drop-off on the payment page?

WITH funnel_stages AS(
  SELECT
    user.device as device,

    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_confirm_payment_page 

    FROM `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.user` as user
    ON user.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id
    GROUP BY user.device
)


SELECT 
  device,
  
 
  ROUND((users_in_payment_page - users_in_confirm_payment_page)/users_in_payment_page  * 100 ,2) as payment_dropOff
  
FROM funnel_stages;



-- How does the overall conversion rate trend over time (Weekly or Monthly)?
WITH funnel_stages AS(
  SELECT
    DATE_TRUNC(user.date, Month) as Month,
    COUNT(DISTINCT home.user_id) as users_in_home_page,
    COUNT(DISTINCT search_page.user_id) as users_in_search_page,
    COUNT(DISTINCT payment.user_id) as users_in_payment_page,
    COUNT(DISTINCT payment_confirm.user_id) as users_in_payment_confirm_page

    FROM  `graphite-shell-464603-c6.funnel_analysis_projects.home`  as home

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.user` as user
    ON user.user_id = home.user_id

    LEFT JOIN  `graphite-shell-464603-c6.funnel_analysis_projects.search_page` as search_page
    ON home.user_id = search_page.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment` as payment
    ON search_page.user_id = payment.user_id

    LEFT JOIN `graphite-shell-464603-c6.funnel_analysis_projects.payment_confirm` as payment_confirm
    ON payment.user_id = payment_confirm.user_id
    GROUP BY Month
)


SELECT 
  Month,
  ROUND((users_in_payment_confirm_page * 100.0) / users_in_home_page) as over_all_conversation_rate
FROM funnel_stages
ORDER BY Month;






-- Are there specific dates or days of the week where user traffic spikes but conversion rates drop?



-- Did a change in device performance or user cohort over time impact the payment confirmation rate?
