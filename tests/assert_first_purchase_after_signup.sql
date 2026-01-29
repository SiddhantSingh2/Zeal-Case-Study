select *
from {{ ref('dim_customer') }}
where first_ticket_purchase_timestamp < signup_timestamp
