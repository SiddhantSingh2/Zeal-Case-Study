select *
from {{ ref('dim_customer') }}
where first_deposit_timestamp < first_marketing_interaction
