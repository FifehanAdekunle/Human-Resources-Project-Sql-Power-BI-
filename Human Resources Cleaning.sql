-- Create the database project
CREATE DATABASE projects;
 USE projects;

-- import the table to the database and select all data from the table
 SELECT *
 FROM humanresources;
 
 -- Change the colomun name to employee id
 ALTER TABLE humanresources
CHANGE COLUMN emp_id employee_id VARCHAR(20) NULL;

-- Check the data type of the humanresources table
DESCRIBE humanresources;

SELECT birthdate FROM humanresources;

-- is used to disable the "safe updates"
SET sql_safe_updates = 0;

-- update data format
UPDATE humanresources
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- change data type for birthdate column
ALTER TABLE humanresources
MODIFY COLUMN birthdate DATE;

Select hire_date 
from humanresources;

-- update data format for hiredate column/field
UPDATE humanresources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE humanresources
MODIFY COLUMN hire_date DATE;

Select termdate
from humanresources;

-- update data format for termdate  column/field
UPDATE humanresources
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL
  AND termdate != ''
  AND termdate != ' '
  AND termdate != '0000-00-00 00:00:00 UTC';
  
-- Update invalid date values to NULL
UPDATE humanresources
SET termdate = NULL
WHERE termdate = '';

-- Alter the column to DATE data type
ALTER TABLE humanresources
MODIFY COLUMN termdate DATE;

-- Create a new colomun age
ALTER TABLE humanresources
ADD COLUMN age INT;

-- calc age with timestampdiff
UPDATE humanresources
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- view changes
 SELECT age, birthdate
 FROM humanresources;
 
 SELECT
    min(age) AS youngest,
    max(age) AS oldest
FROM humanresources;

SELECT count(*) FROM humanresources WHERE age < 18;

