-- Перевірка і видалення існуючої бази даних
IF DB_ID('WorkDW') IS NOT NULL
    DROP DATABASE WorkDW;
GO

-- Створення бази даних WorkDW
CREATE DATABASE WorkDW;
GO

USE WorkDW;
GO

-- Таблиця вимірів для відділів
CREATE TABLE Dim_Department (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_key INT NOT NULL,
    name VARCHAR(100),
    code VARCHAR(20),
    manager VARCHAR(100)
);

-- Таблиця вимірів для посад
CREATE TABLE Dim_Position (
    position_id INT IDENTITY(1,1) PRIMARY KEY,
    position_key INT NOT NULL,
    name VARCHAR(100),
    hourly_rate DECIMAL(10,2)
);

-- Таблиця вимірів для працівників
CREATE TABLE Dim_Employee (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_key INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
	--passport_data VARCHAR(20),
    date_of_birth DATE,
    place_of_birth VARCHAR(100),
    home_address VARCHAR(150),
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Dim_Department(department_id),
    FOREIGN KEY (position_id) REFERENCES Dim_Position(position_id)
);

-- Таблиця вимірів для дат
CREATE TABLE Dim_Date (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- Таблиця фактів для обліку робочого часу, відпусток і зарплати
CREATE TABLE Fact_WorkPerformance (
    fact_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    work_date_id INT NOT NULL,
    vacation_start_date_id INT NULL,
    vacation_end_date_id INT NULL,
    payment_date_id INT NULL,
    hours_worked INT NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Dim_Employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES Dim_Department(department_id),
    FOREIGN KEY (position_id) REFERENCES Dim_Position(position_id),
    FOREIGN KEY (work_date_id) REFERENCES Dim_Date(date_id),
    FOREIGN KEY (vacation_start_date_id) REFERENCES Dim_Date(date_id),
    FOREIGN KEY (vacation_end_date_id) REFERENCES Dim_Date(date_id),
    FOREIGN KEY (payment_date_id) REFERENCES Dim_Date(date_id)
);
GO
