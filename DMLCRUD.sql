INSERT INTO HumanResources.Employee (BusinessEntityID,NationalIDNumber,LoginID,JobTitle,BirthDate,MaritalStatus,Gender,HireDate)
VALUES (291,295847285,'adventure-works\itaamd0','Adminsistrator','1994-10-10','S','M','2020-05-10')

INSERT INTO HumanResources.EmployeeDepartmentHistory (BusinessEntityID,DepartmentID,ShiftID,StartDate)
VALUES (291,2,1,GETDATE())

SELECT * INTO RADNIK FROM HumanResources.Employee

SELECT * INTO RADNIK FROM HumanResources.Employee
WHERE HumanResources.Employee.OrganizationLevel IN (3,4) OR HumanResources.Employee.JobTitle LIKE 'Pacific Sales Manager'

SELECT * INTO PrvaSmena FROM HumanResources.EmployeeDepartmentHistory
WHERE HumanResources.EmployeeDepartmentHistory.ShiftID=1 AND YEAR(HumanResources.EmployeeDepartmentHistory.StartDate)>=2010

UPDATE RADNIK
SET VacationHours=VacationHours*1.1

UPDATE RADNIK
SET VacationHours=VacationHours*1.1
WHERE OrganizationLevel IN (1,2)

UPDATE RADNIK
SET VacationHours=VacationHours*1.05
WHERE OrganizationLevel IN (3)

UPDATE RADNIK
SET VacationHours=VacationHours*1.03
WHERE OrganizationLevel NOT IN (1,2,3)

UPDATE RADNIK
SET VacationHours=VacationHours*(
	CASE RADNIK.OrganizationLevel
		WHEN 1 THEN 1.1
		WHEN 2 THEN 1.1
		WHEN 3 THEN 1.05
		ELSE 1.03
	END
		
)

SELECT * FROM HumanResources.EmployeeDepartmentHistory
WHERE EndDate IS NULL AND DepartmentID=7 AND ShiftID=2

UPDATE HumanResources.EmployeeDepartmentHistory
SET EndDate=GETDATE()
WHERE EndDate IS NULL AND DepartmentID=7 AND ShiftID=2

SELECT HumanResources.EmployeeDepartmentHistory.BusinessEntityID FROM HumanResources.EmployeeDepartmentHistory,HumanResources.Employee
WHERE HumanResources.EmployeeDepartmentHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID
AND HumanResources.EmployeeDepartmentHistory.DepartmentID=3
AND HumanResources.Employee.JobTitle LIKE '%Manager%'

UPDATE HumanResources.EmployeeDepartmentHistory
SET HumanResources.EmployeeDepartmentHistory.DepartmentID=2
WHERE HumanResources.EmployeeDepartmentHistory.BusinessEntityID IN (
SELECT HumanResources.EmployeeDepartmentHistory.BusinessEntityID FROM HumanResources.EmployeeDepartmentHistory,HumanResources.Employee
WHERE HumanResources.EmployeeDepartmentHistory.BusinessEntityID=HumanResources.Employee.BusinessEntityID
AND HumanResources.EmployeeDepartmentHistory.DepartmentID=3
AND HumanResources.Employee.JobTitle LIKE '%Manager%'
)

UPDATE HumanResources.EmployeePayHistory
SET Rate=Rate*1.05

SELECT HumanResources.Employee.BusinessEntityID FROM HumanResources.Employee,HumanResources.EmployeeDepartmentHistory
WHERE HumanResources.Employee.SickLeaveHours>10 
AND HumanResources.EmployeeDepartmentHistory.DepartmentID=7 
AND HumanResources.Employee.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID

UPDATE HumanResources.EmployeePayHistory
SET HumanResources.EmployeePayHistory.Rate=10
WHERE HumanResources.EmployeePayHistory.BusinessEntityID IN (
SELECT HumanResources.Employee.BusinessEntityID FROM HumanResources.Employee,HumanResources.EmployeeDepartmentHistory
WHERE HumanResources.Employee.SickLeaveHours>10 
AND HumanResources.EmployeeDepartmentHistory.DepartmentID=7 
AND HumanResources.Employee.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
)

SELECT * FROM RADNIK
WHERE RADNIK.VacationHours>=(SickLeaveHours*0.5)

DELETE FROM RADNIK
WHERE RADNIK.VacationHours>=(SickLeaveHours*0.5)

DELETE FROM RADNIK

SELECT * FROM RADNIK
WHERE VacationHours>(SickLeaveHours*0.5)

DELETE RADNIK
WHERE VacationHours>(SickLeaveHours*0.5)

DELETE HumanResources.JobCandidate
WHERE BusinessEntityID IS NULL

SELECT RADNIK.BusinessEntityID FROM RADNIK,HumanResources.EmployeeDepartmentHistory
WHERE RADNIK.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
AND HumanResources.EmployeeDepartmentHistory.EndDate IS NULL

DELETE RADNIK
WHERE BusinessEntityID IN (
	SELECT RADNIK.BusinessEntityID FROM RADNIK,HumanResources.EmployeeDepartmentHistory
WHERE RADNIK.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
AND HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
)