create view medicine_variants as
select
    m.medicine_id,
    m.name_medicine,
    mv.variant_id,
    mv.dosage
from Medicine as m join MedicineVariant as mv on m.medicine_id = mv.medicine_id;