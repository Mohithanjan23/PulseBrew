from dataclasses import dataclass
from datetime import datetime

@dataclass
class CoffeeLog:
    id: str
    user_id: str
    caffeine_mg: int
    logged_at: datetime
