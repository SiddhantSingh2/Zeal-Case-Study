select
    game_id,
    game_name,
    jackpot_estimate_inminor / 100.0 as jackpot_estimate_usd
from raw_lottery.games
