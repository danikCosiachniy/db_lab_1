SELECT
    m.name_medicine,
    mv.dosage,
    p.name_pharmacy,
    s.exp_date,
    s.quantity
FROM dbo.Stock AS s
JOIN dbo.Medicine        AS m  ON s.medicine_id = m.medicine_id
JOIN dbo.Pharmacy        AS p  ON s.pharmacy_id = p.pharmacy_id
JOIN dbo.MedicineVariant AS mv ON s.variant_id = mv.variant_id
WHERE s.exp_date >= CAST(GETDATE() AS date)
  AND s.exp_date <  DATEADD(MONTH, 3, CAST(GETDATE() AS date))
ORDER BY s.exp_date ASC;