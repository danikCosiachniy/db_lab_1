create view pharmacy_directory as
select
    pharmacy_id,
    name_pharmacy,
    speciality,
    phone,
    address
from Pharmacy as p;