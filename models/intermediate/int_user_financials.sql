select
    user_id,
    min(deposit_timestamp) as first_deposit_timestamp,
    sum(deposit_amount_usd) as total_deposit_amount
from {{ ref('stg_deposits') }}
group by user_id
