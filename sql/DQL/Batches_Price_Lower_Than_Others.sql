SELECT s.stock_id, s.medicine_id, s.pharmacy_id, s.price
FROM Stock AS s
WHERE s.price < (
  SELECT MAX(s2.price)
  FROM Stock AS s2
  WHERE s2.medicine_id = s.medicine_id
    AND s2.pharmacy_id <> s.pharmacy_id
);
