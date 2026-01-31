SELECT
    p.name_pharmacy AS name,
    SUM(s.price * s.quantity) AS price_on_stock
FROM Stock as s JOIN Pharmacy as p
     ON s.pharmacy_id = p.pharmacy_id
GROUP BY p.name_pharmacy
ORDER BY SUM(s.price * s.quantity) DESC;
