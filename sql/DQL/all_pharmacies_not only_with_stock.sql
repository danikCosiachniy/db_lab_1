SELECT
    p.name_pharmacy AS name_pharmacy,
    s.medicine_id,
    s.quantity
FROM Pharmacy as p LEFT JOIN Stock as s ON p.pharmacy_id = s.pharmacy_id
ORDER BY name_pharmacy;
