SELECT p.name_pharmacy AS [Объект], N'Аптека' AS [Тип]
FROM dbo.Pharmacy AS p
UNION
SELECT m.name_medicine AS [Объект], N'Лекарство' AS [Тип]
FROM dbo.Medicine AS m
ORDER BY [Тип], [Объект];