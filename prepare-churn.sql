/* 
SECTION 1
    Data Cleaning  
    1. Missing Data
    2. Outlier
    3. Duplicates
*/

USE project1

SELECT * FROM telco;

-- 1.1 Missing Data
-- number of impressions have missing data, be careful when analysing it
Select 
    count(1) [Churn],
    count(customerID)*1.0/count(1) [customerID],
    count(gender)*1.0/count(1) [gender],
    count(SeniorCitizen)*1.0/count(1) [SeniorCitizen],
    count(Partner)*1.0/count(1) [Partner],
    count(Dependents)*1.0/count(1) [Dependents],
    count(tenure)*1.0/count(1) [tenure],
    count(PhoneService)*1.0/count(1) [PhoneService],
    count(MultipleLines)*1.0/count(1) [MultipleLines],
    count(InternetService)*1.0/count(1) [InternetService],
    count(OnlineSecurity)*1.0/count(1) [OnlineSecurity],
    count(OnlineBackup)*1.0/count(1) [OnlineBackup],
    count(DeviceProtection)*1.0/count(1) [DeviceProtection],
    count(TechSupport)*1.0/count(1) [TechSupport],
    count(StreamingTV)*1.0/count(1) [StreamingTV],
    count(StreamingMovies)*1.0/count(1) [StreamingMovies],
    count(Contract)*1.0/count(1) [Contract],
    count(PaperlessBilling)*1.0/count(1) [PaperlessBilling],
    count(PaymentMethod)*1.0/count(1) [PaymentMethod],
    count(MonthlyCharges)*1.0/count(1) [MonthlyCharges],
    count(TotalCharges)*1.0/count(1) [TotalCharges]
from 
    telco;

--TotalCharges have some null values (11 NULL)
Select
   TotalCharges
from 
    telco
where TotalCharges is NULL;


-- 1.2 Outliers ( for numeric columns )
-- number of impressions has negative values 
Select 
    min(SeniorCitizen) [min_SeniorCitizen],
    avg(SeniorCitizen) [avg_SeniorCitizen],
    max(SeniorCitizen) [max_SeniorCitizen],
    min(tenure) [min_tenure],
    avg(tenure) [avg_tenure],
    max(tenure) [max_tenure],
    min(MonthlyCharges) [min_MonthlyCharges],
    avg(MonthlyCharges) [avg_MonthlyCharges],
    max(MonthlyCharges) [max_MonthlyCharges],
    min(TotalCharges) [min_TotalCharges],
    avg(TotalCharges) [avg_TotalCharges],
    max(TotalCharges) [max_TotalCharges]
from 
    telco;

-- 1.3 Duplicates 

Select 
    customerID, gender, SeniorCitizen, Partner, Dependents, tenure, PhoneService,
    MultipleLines, InternetService, OnlineSecurity, OnlineBackup,DeviceProtection,TechSupport,
    StreamingTV, StreamingMovies, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalCharges, Churn,
    count(*)
from 
    telco
Group by customerID, gender, SeniorCitizen, Partner, Dependents, tenure, PhoneService,
    MultipleLines, InternetService, OnlineSecurity, OnlineBackup,DeviceProtection,TechSupport,
    StreamingTV, StreamingMovies, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalCharges, Churn
Having count(*) >1;


--Distribution Analysis--
-- Univariate Analysis: Categorical Features Distribution


--Distribution of Gender
--Count male =3555 and Count Female = 3488

SELECT
     gender,
    Count(CustomerID) as CustomerCount
FROM 
    telco
GROUP BY gender;


--Distribution of Partner (YES = 3402, NO = 3641)

SELECT
    Partner,
    Count(customerID) as CustomerCount
FROM 
    telco
GROUP BY Partner;


--Distribution of Dependents (YES = 2110, NO = 4933)

SELECT
    Dependents,
    Count(customerID) as CustomerCount
FROM 
    telco
GROUP BY Dependents;


--Distribution of PhoneServices (YES = 6361, NO = 682)

SELECT
    PhoneService,
    Count(customerID) as CustomerCount
FROM 
    telco
GROUP BY PhoneService;


-- Distribution of InternetService
-- (Fiber_Optic = 3096, DSL = 2421, NO = 1526)

SELECT
    InternetService,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY InternetService;


-- Distribution of TechSupport
--(NO_tech = 3473, YES = 2044, NO_internet_services = 1526)

SELECT
    TechSupport,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY TechSupport;


--Distribution of Contract (month to month high)
--(month-to-month = 3875, Two_year = 1695, One_year = 1473)

SELECT
    Contract,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY Contract;

--Distribution of paymentmethod (electronic Check high)
--Electronic_check = 2365, Mailed_check = 1612, Bank_transfer = 1544, CreditCard = 1522)

SELECT
    PaymentMethod,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY PaymentMethod;

--Distribution of CHURN (non-churned is high)
--CHURNED customers VS NON-CHURNED customers
--(YES = 1869, NO = 5174)

SELECT
    Churn,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY Churn;




-- Numerical Features Distribution

--Distribution of SeniorCitizen (Non- SeniorCitizen is high to left the company)
-- (Non-SeniorCitizen(0) = 5901, SeniorCitizen(1) = 1142)

SELECT
    SeniorCitizen,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY SeniorCitizen;

--Distribution of Tenure(Number of months the customer has stayed with the company)
SELECT
    tenure,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY tenure
ORDER BY CustomerCount DESC;

-- Distribution of MonthlyCharges( $ 20.05 most paid by customers by monthly)
SELECT
    MonthlyCharges,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY MonthlyCharges
ORDER BY  CustomerCount DESC;

-- Distribution of TotalCharges (NULL is 11, $20.2 total amount paid by customers)
SELECT 
    TotalCharges,
    COUNT(customerID) as CustomerCount
FROM 
    telco
GROUP BY TotalCharges
ORDER BY  CustomerCount DESC;


--Bivariate Analysis Churn(Target column) VS categorical variables
-- GENDER VS CHURN

SELECT 
    Gender,
   sum(case when Churn = 'Yes' then 1 Else 0 End) [Churned],
   sum(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM
    telco
Group by Gender;

--  PARTNERS VS CHURN

SELECT
    Partner,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY Partner;

--Senior Citizen VS churn
SELECT
    SeniorCitizen,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY SeniorCitizen;

-- DEPENDENTS VS CHURN (Users which has no dependents is more likely to CHURN)
SELECT
    Dependents,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY Dependents;

-- PHONESERVICE VS CHURN (Users with Phone Service is more likely to CHURN)
SELECT
    PhoneService,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY PhoneService;


-- MULTIPLELINES VS CHURN
SELECT
    MultipleLines,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY MultipleLines;

--INTERNETSERVICE  VS CHURN (Users with Fiber optic Internet Service is more likely to CHURN)
SELECT
    InternetService,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY InternetService;

-- ONLINESECURITY VS CHURN (Users without Online Security is more likely to CHURN)
SELECT
    OnlineSecurity,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY OnlineSecurity;

--ONLINEBACKUP VS CHURN
SELECT
    OnlineBackup,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY OnlineBackup;

-- DEVICEPROTECTION  VS CHURN (Users without device protection is more likely to CHURN)
SELECT
    DeviceProtection,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY DeviceProtection;

-- TECHSUPPORT VS CHURN
SELECT
    TechSupport,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY TechSupport;

--STREAMINGTV VS CHURN
SELECT
   StreamingTV,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY StreamingTV;

-- STREAMINGMOVIES VS CHURN
SELECT
    StreamingMovies,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY StreamingMovies;

-- CONTRACT VS CHURN (month to month have high churn value)
SELECT
    Contract,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY Contract;

-- PAPERLESSBILLING VS CHURN (users with paperlessbilling is more likely to CHURN)
SELECT
    PaperlessBilling,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY PaperlessBilling;

--PAYMENTMETHOD  VS CHURN (Users with Electronic Check paymentMethod is more likely to CHURN)
SELECT
    PaymentMethod,
    SUM(case when Churn = 'Yes' then 1 Else 0 END) [Churned],
    SUM(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM 
    telco
GROUP BY PaymentMethod;



--Which gender churned using internet Service?
SELECT
    Gender,
    InternetService,
    sum(case when Churn = 'Yes' then 1 Else 0 End) [Churned],
   sum(case when churn = 'No' then 1 else 0 end) [Non_Churn]
FROM
    telco
GROUP BY Gender,InternetService
order by Gender, InternetService;

