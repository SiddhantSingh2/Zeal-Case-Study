select
    deposit_id,
    user_id,
    deposit_amount_inminor / 100.0 as deposit_amount_usd,
    cast(deposit_timestamp as timestamp) as deposit_timestamp
from raw_app_data.deposits