{{ config( 
    unique_key='user_id'             -- Ensures uniqueness per user in the mart
) }}

select
    s.user_id,                        -- Unique user identifier
    s.signup_timestamp,               -- Timestamp when the user signed up
    m.first_marketing_interaction,    -- User's first marketing touch timestamp (first-touch attribution)
    f.first_deposit_timestamp,        -- User's first deposit timestamp (for ROAS calculation)
    p.first_ticket_purchase_timestamp,-- User's first ticket purchase timestamp 
    datediff(
        'day',
        m.first_marketing_interaction,
        p.first_ticket_purchase_timestamp
    ) as days_to_first_purchase,  -- Time in days from first marketing touch to first ticket purchase
    f.total_deposit_amount,  -- Total deposit amount per user (USD)
    p.played_high_jackpot  -- Flag if the user purchased tickets for high-jackpot games (jackpot >= $100,000)
from {{ ref('stg_signups') }} s
left join {{ ref('int_user_marketing_touchpoints') }} m
  on s.user_id = m.user_id  -- Left join to include users with no marketing touch
left join {{ ref('int_user_financials') }} f
  on s.user_id = f.user_id  -- Left join to include users who have not yet deposited
left join {{ ref('int_user_purchases') }} p
  on s.user_id = p.user_id  -- Left join to include users with no ticket purchases yet

{% if is_incremental() %}
-- For incremental runs, only process new signups after the last processed signup
where s.signup_timestamp > (select max(signup_timestamp) from {{ this }})
{% endif %}
