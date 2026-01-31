CREATE VIEW medicine_price_summary
AS
SELECT
    medicine_id,
    name_medicine,
    COUNT(*) AS batches_count,
    CAST(AVG(CAST(price AS decimal(18,4))) AS decimal(18,2)) AS avg_price,
    CAST(
        SUM(price * quantity) / NULLIF(SUM(quantity), 0)
        AS decimal(18,2)
    ) AS avg_price_weighted,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM stock_full
GROUP BY medicine_id, name_medicine;
GO