
CREATE VIEW pharmacy_stock_summary
AS
SELECT
    pharmacy_id,
    name_pharmacy,
    COUNT(*) AS positions_count,
    SUM(quantity) AS total_units,
    CAST(SUM(quantity * price) AS decimal(18,2)) AS total_value
FROM stock_full
GROUP BY pharmacy_id, name_pharmacy;
GO