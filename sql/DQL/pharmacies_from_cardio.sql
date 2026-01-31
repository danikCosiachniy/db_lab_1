SELECT DISTINCT m.name_medicine
FROM Medicine AS m
WHERE m.medicine_id IN (
    SELECT s.medicine_id
    FROM Stock AS s
    WHERE s.pharmacy_id IN (
        SELECT p.pharmacy_id
        FROM Pharmacy AS p
        WHERE p.speciality LIKE N'%кардио%'
    )
);