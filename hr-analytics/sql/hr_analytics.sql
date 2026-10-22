-- HR Analytics | Microsoft SQL Server (T-SQL)
SELECT COUNT(*) AS Headcount, AVG(MonthlyIncome) AS AverageMonthlyIncome,
       AVG(CAST(YearsAtCompany AS DECIMAL(10,2))) AS AverageTenureYears
FROM dbo.HREmployeeAnalysis;

SELECT Department, COUNT(*) AS Headcount
FROM dbo.HREmployeeAnalysis
GROUP BY Department ORDER BY Headcount DESC;

SELECT Department, COUNT(*) AS Headcount,
       AVG(MonthlyIncome) AS AverageMonthlyIncome,
       AVG(CAST(YearsAtCompany AS DECIMAL(10,2))) AS AverageTenureYears
FROM dbo.HREmployeeAnalysis
GROUP BY Department ORDER BY AverageMonthlyIncome DESC;

SELECT Attrition, COUNT(*) AS EmployeeCount,
       CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS PercentageOfEmployees
FROM dbo.HREmployeeAnalysis
GROUP BY Attrition ORDER BY EmployeeCount DESC;

SELECT Department, COUNT(*) AS Headcount,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       CAST(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS AttritionPercentage
FROM dbo.HREmployeeAnalysis
GROUP BY Department ORDER BY AttritionPercentage DESC;

WITH TenureRanks AS (
    SELECT EmployeeID, Department, JobRole, YearsAtCompany,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY YearsAtCompany DESC) AS TenureRank
    FROM dbo.HREmployeeAnalysis
)
SELECT EmployeeID, Department, JobRole, YearsAtCompany, TenureRank
FROM TenureRanks ORDER BY Department, TenureRank;
