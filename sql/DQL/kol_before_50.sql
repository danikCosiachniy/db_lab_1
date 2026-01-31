SELECT
    m.name_medicine,
    SUM(s.quantity)
FROM Stock as s JOIN Medicine as m ON s.medicine_id = m.medicine_id
GROUP BY m.name_medicine
HAVING SUM(s.quantity) < 50
ORDER BY SUM(s.quantity) ASC;
