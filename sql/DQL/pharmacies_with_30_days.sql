SELECT p.name_pharmacy, p.address
FROM dbo.Pharmacy AS p
WHERE EXISTS (
    SELECT 1
    FROM dbo.Stock AS s
    WHERE s.pharmacy_id = p.pharmacy_id
      AND s.exp_date >= CAST(GETDATE() AS date)
      AND s.exp_date <  DATEADD(DAY, 30, CAST(GETDATE() AS date))
);