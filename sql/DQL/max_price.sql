SELECT
    s.stock_id,
    s.medicine_id,
    m.name_medicine,
    s.pharmacy_id,
    s.price,
    s.quantity,
    s.exp_date
FROM dbo.Stock AS s
JOIN dbo.Medicine AS m ON m.medicine_id = s.medicine_id
WHERE s.price > (
    SELECT MAX(s2.price)
    FROM dbo.Stock AS s2
    WHERE s2.medicine_id = s.medicine_id
      AND s2.stock_id <> s.stock_id
);