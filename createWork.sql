IF DB_ID('Work') IS NOT NULL
    DROP DATABASE Work;
GO

-- Створення бази даних Work
CREATE DATABASE Work;
GO

USE Work;
GO

-- Таблиця для відділів
CREATE TABLE Departments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL,
    manager VARCHAR(100) NOT NULL
);

-- Таблиця для посад
CREATE TABLE Positions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL
);

-- Таблиця для працівників
CREATE TABLE Employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    passport_data VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    place_of_birth VARCHAR(100) NOT NULL,
    home_address VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(id),
    FOREIGN KEY (position_id) REFERENCES Positions(id)
);

-- Таблиця для робочого часу
CREATE TABLE Work_Hours (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    work_date DATE NOT NULL,
    hours_worked INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);

-- Таблиця для відпусток
CREATE TABLE Vacations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);

-- Таблиця для виплат зарплати
CREATE TABLE Salary_Payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
GO
