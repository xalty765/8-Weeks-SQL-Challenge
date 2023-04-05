# 🥑 Case Study #3 - Foodie-Fi
<p align="center">
<img src="https://8weeksqlchallenge.com/images/case-study-designs/3.png" alt="Image" width="450" height="450">
  
## Introduction
Subscription based businesses are super popular and Danny realised that there was a large gap in the market - he wanted to create a new streaming service that only had food related content - something like Netflix but with only cooking shows!

Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!

Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

## Datasets

**plans table** : Customers can choose which plans to join Foodie-Fi when they first sign up.

There are 5 customer plans.
- Basic plan - customers have limited access and can only stream their videos and is only available monthly at $9.90
- Pro plan - customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.
- Trial plan - Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.
- Churn plan - When customers cancel their Foodie-Fi service - they will have a churn plan record with a null price but their plan will continue until the end of the billing period.

**subscriptions table** 
- Customer subscriptions show the *exact date where their specific plan_id starts*.
- If customers *downgrade* from a pro plan or *cancel their subscription* - the higher plan will remain in place until the period is over - the start_date in the subscriptions table will reflect the date that the actual plan changes.
- When customers *upgrade* their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.
- When customers *churn* - they will keep their access until the end of their current billing period but the start_date will be technically the day they decided to cancel their service.

## Entity Relationship Diagram
![alt text](https://github.com/manaswikamila05/8-Week-SQL-Challenge/blob/main/Case%20Study%20%23%203%20-%20Foodie-Fi/ERD.jpg)

  ---
##  Case Study Questions
### A. Customer Journey
* Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.
---
### B. Data Analysis Questions

1. How many customers has Foodie-Fi ever had?
2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6. What is the number and percentage of customer plans after their initial free trial?
7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

---
### C. Challenge Payment Question

The Foodie-Fi team wants to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:
  * monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
  * upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
  * upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
  * once a customer churns they will no longer make payments

---
### D. Outside The Box Questions 

1. How would you calculate the rate of growth for Foodie-Fi?
2. What key metrics would you recommend Foodie-Fi management to track over time to assess performance of their overall business?
3. What are some key customer journeys or experiences that you would analyse further to improve customer retention?
4. If the Foodie-Fi team were to create an exit survey shown to customers who wish to cancel their subscription, what questions would you include in the survey?
5. What business levers could the Foodie-Fi team use to reduce the customer churn rate? How would you validate the effectiveness of your ideas?
