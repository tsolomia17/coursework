SELECT 
    DISTINCT 
    work_date AS date, 
    YEAR(work_date) AS year, 
    MONTH(work_date) AS month, 
    DAY(work_date) AS day
FROM Work_Hours

UNION

SELECT 
    DISTINCT 
    start_date AS date, 
    YEAR(start_date) AS year, 
    MONTH(start_date) AS month, 
    DAY(start_date) AS day
FROM Vacations

UNION

SELECT 
    DISTINCT 
    end_date AS date, 
    YEAR(end_date) AS year, 
    MONTH(end_date) AS month, 
    DAY(end_date) AS day
FROM Vacations

UNION

SELECT 
    DISTINCT 
    payment_date AS date, 
    YEAR(payment_date) AS year, 
    MONTH(payment_date) AS month, 
    DAY(payment_date) AS day
FROM Salary_Payments;
