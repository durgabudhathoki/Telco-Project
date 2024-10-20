Create database project1

use project1

drop table if exists telco

Create table telco(
    customerID varchar(100),
    gender varchar(100),
    SeniorCitizen int,
    Partner varchar(100),
    Dependents varchar(100),
    tenure int,
    PhoneService varchar(100),
    MultipleLines varchar(50),
    InternetService varchar(50),
    OnlineSecurity varchar(50),
    OnlineBackup varchar(50),
    DeviceProtection varchar(50),
    TechSupport varchar(50),
    StreamingTV varchar(50),
    StreamingMovies varchar(50),
    Contract varchar(50),
    PaperlessBilling varchar(50),
    PaymentMethod varchar(50),
    MonthlyCharges float,
    TotalCharges float,
    Churn VARCHAR(20)
)

Bulk insert telco
from '/mydata/dataset/WA_Fn-UseC_-Telco-Customer-Churn.csv'
with (
    FORMAT = 'CSV',
    firstrow = 2,
    fieldterminator = ',',
    rowterminator ='\r\n'
)

SELECT * FROM telco;

