{{ config(
    unique_key='purchase_id'
) }}

select
    p.purchase_id,
    p.user_id,
    p.game_id,
    g.game_name,
    g.jackpot_estimate_usd,
    p.purchase_amount_usd,
    p.purchase_timestamp
from {{ ref('stg_ticket_purchases') }} p
left join {{ ref('stg_games') }} g
    on p.game_id = g.game_id

{% if is_incremental() %}
where p.purchase_timestamp > (select max(purchase_timestamp) from {{ this }})
{% endif %}
