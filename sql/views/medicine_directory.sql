create view medicine_directory as
select
    medicine_id,
    name_medicine,
    manufactured,
    form,
    indications,
    contraindications
from Medicine;