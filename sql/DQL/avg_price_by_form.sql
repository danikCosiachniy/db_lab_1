SELECT
    m.form ,
    ROUND(AVG(s.price), 2) as mean_price,
    ROUND(AVG(s.quantity), 2) as mean_kol
FROM
    Stock as s JOIN Medicine as m ON s.medicine_id = m.medicine_id
GROUP BY
    m.form
HAVING
    AVG(s.price) > 3
ORDER BY
    AVG(s.price) DESC;
