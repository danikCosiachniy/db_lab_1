SELECT s.stock_id,
s.medicine_id,
s.variant_id,
s.price,
s.quantity
FROM Stock AS s
WHERE s.price > (SELECT AVG(price) FROM Stock);
