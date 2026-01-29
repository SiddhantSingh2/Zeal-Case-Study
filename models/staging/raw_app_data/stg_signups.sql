select
    user_id,
    signup_id,
    cast(signup_timestamp as timestamp) as signup_timestamp,
    country
from raw_app_data.signups
