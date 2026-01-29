select
    p.user_id,
    min(p.purchase_timestamp) as first_ticket_purchase_timestamp,
    max(case when g.jackpot_estimate_usd >= 100000 then 1 else 0 end) as played_high_jackpot
from {{ ref('stg_ticket_purchases') }} p
join {{ ref('stg_games') }} g
  on p.game_id = g.game_id
group by p.user_id
