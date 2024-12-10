SELECT 
    e.id AS employee_id,
    e.department_id,
    e.position_id,
    wh.work_date,
    v.start_date AS vacation_start_date,
    v.end_date AS vacation_end_date,
    sp.payment_date,
    wh.hours_worked,
    p.hourly_rate * wh.hours_worked * 
    (1 + 0.001 * DATEDIFF(DAY, DATEADD(DAY, 10, EOMONTH(wh.work_date)), GETDATE())) AS payment_amount
FROM Work_Hours wh
JOIN Employees e ON wh.employee_id = e.id
JOIN Positions p ON e.position_id = p.id
LEFT JOIN Vacations v ON wh.employee_id = v.employee_id 
    AND wh.work_date BETWEEN v.start_date AND v.end_date
JOIN Salary_Payments sp ON sp.employee_id = wh.employee_id 
    AND sp.payment_date >= wh.work_date
WHERE 
    p.hourly_rate * wh.hours_worked >= (SELECT MIN(hourly_rate) FROM Positions)
    AND wh.work_date <= DATEADD(DAY, 10, EOMONTH(wh.work_date))
    AND DATEDIFF(DAY, wh.work_date, GETDATE()) > 10;