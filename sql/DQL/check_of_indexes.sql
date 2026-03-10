SELECT
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc,
    i.is_unique
FROM sys.indexes i
JOIN sys.tables t ON t.object_id = i.object_id
WHERE t.name IN ('Pharmacy','Medicine','MedicineVariant','Stock')
  AND i.name IS NOT NULL
ORDER BY t.name, i.name;