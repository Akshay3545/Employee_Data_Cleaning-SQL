
USE EmployeeDB;

-- First Name and Last Name Combine with each other
SELECT Employee_ID,
CONCAT(First_Name, ' ', Last_Name) AS Emp_Name,Age,Department_Region,Status,Join_Date,Salary,Email,Phone,Performance_Score,Remote_Work
From dbo.Messy_Employee_dataset;

-- Fixing Age NULL Values
SELECT *
FROM dbo.Messy_Employee_dataset
WHERE Age IS NULL;

SELECT AVG(Age) AS Average_Age
FROM Messy_Employee_dataset
WHERE Age IS NOT NULL;

UPDATE Messy_Employee_dataset
SET Age = 32
WHERE Age IS NULL;

SELECT * FROM dbo.Messy_Employee_dataset;

-- Fixing Salary NULL Values
SELECT *
FROM dbo.Messy_Employee_dataset
WHERE Salary IS NULL;

SELECT AVG(Salary) AS Average_Salary
FROM Messy_Employee_dataset
WHERE Salary IS NOT NULL;

UPDATE Messy_Employee_dataset
SET Salary = 85155.56
WHERE Salary IS NULL;

-- Assigned NULL to phone numbers whose length is not equal to 10 digits.
ALTER TABLE Messy_Employee_dataset
ALTER COLUMN Phone BIGINT NULL;

UPDATE Messy_Employee_dataset
SET Phone = NULL
WHERE LEN(CAST(Phone AS VARCHAR(20))) <> 10;

SELECT * FROM dbo.Messy_Employee_dataset;

-- Splite the DEPARTMENT_REGION AS Different Cloumn Department, Region
ALTER TABLE Messy_Employee_dataset
ADD Department VARCHAR(50),
    Region VARCHAR(50);

UPDATE Messy_Employee_dataset
SET 
    Department = LEFT(
        Department_Region,
        CHARINDEX('-', Department_Region) - 1
    ),
    Region = SUBSTRING(
        Department_Region,
        CHARINDEX('-', Department_Region) + 1,
        LEN(Department_Region)
    );

    SELECT * FROM dbo.Messy_Employee_dataset;

-- First Name and Last Name Combine with each other
    SELECT Employee_ID,
CONCAT(First_Name, ' ', Last_Name) AS Emp_Name,Age,Department_Region,Status,Join_Date,Salary,Email,Phone,Performance_Score,Remote_Work
From dbo.Messy_Employee_dataset

UPDATE dbo.Messy_Employee_dataset
SET Emp_Name = CONCAT(First_Name, ' ', Last_Name);

SELECT First_Name, Last_Name, Emp_Name
FROM dbo.Messy_Employee_dataset;

SELECT * FROM dbo.Messy_Employee_dataset;

ALTER TABLE dbo.Messy_Employee_dataset
DROP COLUMN First_Name, Last_Name, Department_Region;


-- create a cleaned_Employee_dataset
GO
CREATE VIEW dbo.Cleaned_Employee_dataset AS
SELECT
    Employee_ID, Emp_Name,Age,Department,Region,Status,Join_Date,Salary,Email,Phone,Performance_Score,Remote_Work
FROM dbo.Messy_Employee_dataset;

SELECT *
FROM dbo.Cleaned_Employee_dataset;


-- Convert join_date Datatype Text to DATE
ALTER TABLE dbo.Messy_Employee_dataset
ALTER COLUMN Join_Date DATE;

SELECT TOP 10 Join_Date
FROM dbo.Messy_Employee_dataset;

SELECT Email, COUNT(*) AS Duplicate_Count
FROM dbo.Messy_Employee_dataset
GROUP BY Email
HAVING COUNT(*) > 1;

-- Remove Duplicate Emails & Made Unique Email by adding Emp_Name.

UPDATE dbo.Messy_Employee_dataset
SET Email = CONCAT(
    LEFT(Email, CHARINDEX('@', Email) - 1),
    '.',
    LOWER(Employee_ID),
    SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email))
);

SELECT Email, COUNT(*) AS Duplicate_Count
FROM dbo.Messy_Employee_dataset
GROUP BY Email
HAVING COUNT(*) > 1;

SELECT * FROM dbo.Cleaned_Employee_dataset;
