SELECT
    s.price as unit_price,
    s.quantity as kol,
    s.price * s.quantity as price
FROM dbo.Stock as s
ORDER BY
    s.price DESC,
    s.quantity ASC,
    s.price * s.quantity DESC;
