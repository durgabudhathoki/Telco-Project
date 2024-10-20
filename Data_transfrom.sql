
--Data Transformation
--Create table
--add new columns convert categorical into numeric

use project1

drop table if exists project1.dbo.churn_flag
Select
    *,
    case when Churn = 'Yes' then 1 else 0 end [Churn_flag]
    into project1.dbo.churn_flag
from 
    telco;

Select * from project1.dbo.churn_flag;




--Save data for analysis

drop table if exists project1.dbo.telco_base

SELECT
    customerID,
    gender,
    SeniorCitizen,
    case 
        when SeniorCitizen = 0 then 'Non-SeniorCitizen' 
        else 'SeniorCitizen' 
        end [SeniorCitizen_trans],
    Partner,
    Dependents,
    tenure,
    case 
        when tenure < 12 then '[a1] 0-11'
        when tenure < 24 then '[a2] 12-23'
        when tenure < 36 then '[a3] 24-35'
        when tenure < 48 then '[a4] 36-47'
        when tenure < 60 then '[a5] 48-59'
        when tenure < 72 then '[a6] 60-71'
        Else '[a7] 72+'
        End as 'tenure_bins',
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    case 
        when MonthlyCharges <=20 then '[b1] 0-20'
        when MonthlyCharges <= 40 then '[b2] 21-40'
        when MonthlyCharges <= 60 then '[b3] 41-60'
        when MonthlyCharges <= 80 then '[b4] 61-80'
        when MonthlyCharges <= 100 then '[b5] 81-100'
        else '[b6] 101+' end [monthlycharges_bin],
    TotalCharges,
    Churn, 
    case 
        when Churn = 'Yes' then 1 else 0 end [Churn_flag]
into project1.dbo.telco_base
FROM 
    telco;




select * from project1.dbo.telco_base;