select c.*
from {{ ref('dim_customer') }} c
left join {{ ref('fact_ticket_purchases') }} f
  on c.user_id = f.user_id
where c.played_high_jackpot = 1
  and f.jackpot_estimate_usd < 100000
