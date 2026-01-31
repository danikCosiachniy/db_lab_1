SELECT
    m.name_medicine as Medicine,
    AVG(s.price) as mean_price
FROM Stock as s JOIN Medicine as m ON s.medicine_id = m.medicine_id
where s.price > 3
GROUP BY m.name_medicine
ORDER BY AVG(s.price) DESC;
