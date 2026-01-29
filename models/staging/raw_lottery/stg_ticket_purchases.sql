select
    purchase_id,
    user_id,
    game_id,
    purchase_amount_usd,
    cast(purchase_timestamp as timestamp) as purchase_timestamp
from raw_lottery.ticket_purchases
