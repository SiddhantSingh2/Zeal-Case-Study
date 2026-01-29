select distinct
    coalesce(user_id, anonymous_user_id) as unified_user_key,
    user_id,
    anonymous_user_id
from {{ ref('stg_web_events') }}
