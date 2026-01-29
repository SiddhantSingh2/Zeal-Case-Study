select
    event_id,
    user_id,
    anonymous_user_id,
    utm_campaign,
    cast(event_timestamp as timestamp) as event_timestamp
from raw_tracking.web_events
