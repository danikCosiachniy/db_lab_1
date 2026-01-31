create view stock_full as
select
     s.stock_id,
    p.pharmacy_id,
    p.name_pharmacy,
    p.speciality,
    p.address,
    m.medicine_id,
    m.name_medicine,
    m.manufactured,
    mv.variant_id,
    mv.dosage,
    s.quantity,
    s.price,
    s.lot_date,
    s.exp_date
from Medicine as m join MedicineVariant as mv on m.medicine_id = mv.medicine_id
    join Stock as s on mv.variant_id = s.variant_id
    join Pharmacy as p on s.pharmacy_id = p.pharmacy_id;