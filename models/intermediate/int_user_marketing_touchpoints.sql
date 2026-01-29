select
    i.user_id,
    min(w.event_timestamp) as first_marketing_interaction
from {{ ref('stg_web_events') }} w
join {{ ref('int_user_identity') }} i
  on w.anonymous_user_id = i.anonymous_user_id
where i.user_id is not null
group by i.user_id
