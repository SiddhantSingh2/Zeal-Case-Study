select
    cast(date as date) as spend_date,
    campaign_name,
    channel,
    spend_inminor / 100.0 as spend_usd
from raw_marketing.funnel_spend
