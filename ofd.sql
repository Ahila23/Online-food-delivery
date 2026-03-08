CREATE DATABASE Online_food_delivery;
use Online_food_delivery;

#---Customer & Order Analysis
#1.Identify top-spending customers
SELECT 
    Customer_ID,
    SUM(Final_Amount) AS Total_Spent,
    COUNT(Order_ID) AS Total_Orders
FROM online_food_delivery
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;

# 2. Analyze age group vs order value
SELECT 
    CASE 
        WHEN Customer_Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Customer_Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Customer_Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Customer_Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS Age_Group,
    
    COUNT(Order_ID) AS Total_Orders,
    AVG(Final_Amount) AS Avg_Order_Value,
    SUM(Final_Amount) AS Total_Revenue

FROM online_food_delivery
GROUP BY Age_Group
ORDER BY Avg_Order_Value DESC;

#3.Weekend vs weekday order patterns

SELECT 
    Day_Type,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Final_Amount) AS Avg_Order_Value,
    SUM(Final_Amount) AS Total_Revenue
FROM online_food_delivery
GROUP BY Day_Type;

#-----Revenue & Profit Analysis-------
# 4.Monthly revenue trends
SELECT 
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Final_Amount) AS Total_Revenue,
    COUNT(Order_ID) AS Total_Orders
FROM online_food_delivery
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Month_Number;

# 5.Impact of discounts on profit
SELECT 
    Discount_Applied,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Profit_Margin) AS Avg_Profit,
    SUM(Profit_Margin) AS Total_Profit
FROM online_food_delivery
GROUP BY Discount_Applied
ORDER BY Discount_Applied;

#6.High-revenue cities and cuisines

SELECT 
    City,
    Cuisine_Type,
    SUM(Final_Amount) AS Total_Revenue,
    COUNT(Order_ID) AS Total_Orders
FROM online_food_delivery
GROUP BY City, Cuisine_Type
ORDER BY Total_Revenue DESC
LIMIT 10;

#----Delivery Performance
#7.Average delivery time by citySELECT 
    SELECT
    City,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Delivery_Time_Min) AS Avg_Delivery_Time
FROM online_food_delivery
GROUP BY City
ORDER BY Avg_Delivery_Time;

# 8.Distance vs delivery delay analysis
SELECT 
    CASE 
        WHEN Distance_km <= 2 THEN '0-2 km'
        WHEN Distance_km <= 5 THEN '2-5 km'
        WHEN Distance_km <= 8 THEN '5-8 km'
        ELSE '8+ km'
    END AS Distance_Category,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Delivery_Time_Min) AS Avg_Delivery_Time
FROM online_food_delivery
GROUP BY Distance_Category
ORDER BY Avg_Delivery_Time;

#9.Delivery rating vs delivery time
SELECT 
    ROUND(Delivery_Time_Min,0) AS Delivery_Time,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Delivery_Rating) AS Avg_Delivery_Rating
FROM online_food_delivery
GROUP BY ROUND(Delivery_Time_Min,0)
ORDER BY Delivery_Time;

#----Restaurant Performance
#Top-rated restaurants
SELECT 
    Restaurant_Name,
    COUNT(Order_ID) AS Total_Orders,
    AVG(Restaurant_Rating) AS Avg_Rating
FROM online_food_delivery
GROUP BY Restaurant_Name
HAVING COUNT(Order_ID) >= 10
ORDER BY Avg_Rating DESC
LIMIT 10;

#11.Cancellation rate by restaurant
SELECT 
    Restaurant_Name,
    COUNT(Order_ID) AS Total_Orders,
    SUM(CASE 
        WHEN Order_Status = 'Cancelled' THEN 1 
        ELSE 0 
    END) AS Cancelled_Orders,
    ROUND(
        SUM(CASE 
            WHEN Order_Status = 'Cancelled' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(Order_ID), 
    2) AS Cancellation_Rate_Percentage
FROM online_food_delivery
GROUP BY Restaurant_Name
ORDER BY Cancellation_Rate_Percentage DESC
LIMIT 10;

#12.Cuisine-wise performance
SELECT 
    Cuisine_Type,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Final_Amount) AS Total_Revenue,
    AVG(Restaurant_Rating) AS Avg_Restaurant_Rating
FROM online_food_delivery
GROUP BY Cuisine_Type
ORDER BY Total_Revenue DESC;

#13.Peak hour demand analysis
SELECT 
    Order_Hour,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Final_Amount) AS Total_Revenue
FROM online_food_delivery
GROUP BY Order_Hour
ORDER BY Total_Orders DESC
LIMIT 1;

#14.Payment mode preferences
SELECT 
    Payment_Mode,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Final_Amount) AS Total_Revenue,
    AVG(Final_Amount) AS Avg_Order_Value
FROM online_food_delivery
GROUP BY Payment_Mode
ORDER BY Total_Orders DESC;

#15.Cancellation reason analysis
SELECT 
    Cancellation_Reason,
    COUNT(Order_ID) AS Cancelled_Orders
FROM online_food_delivery
WHERE Order_Status = 'Cancelled'
GROUP BY Cancellation_Reason
ORDER BY Cancelled_Orders DESC;