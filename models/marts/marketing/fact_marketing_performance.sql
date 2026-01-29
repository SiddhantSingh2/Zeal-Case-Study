{{ config(
    unique_key='campaign_name'
) }}

select
    fs.channel,
    fs.campaign_name,
    sum(fs.spend_usd) as total_spend_usd,
    sum(f.total_deposit_amount) as first_deposit_revenue,
    sum(f.total_deposit_amount) / nullif(sum(fs.spend_usd), 0) as roas
from {{ ref('stg_funnel_spend') }} fs
left join {{ ref('int_user_financials') }} f
  on fs.campaign_name = f.user_id
group by fs.channel, fs.campaign_name

{% if is_incremental() %}
where fs.date > (select max(fs.date) from {{ this }})
{% endif %}
