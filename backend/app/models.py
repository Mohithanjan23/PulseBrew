from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr, Field

# ==================================================
# USER MODEL
# ==================================================

class User(BaseModel):
    id: str = Field(..., description="Unique user ID (UUID)")
    email: EmailStr
    name: Optional[str] = None
    created_at: Optional[datetime] = None


# ==================================================
# COFFEE LOG MODEL
# ==================================================

class CoffeeLog(BaseModel):
    id: str = Field(..., description="Coffee log ID")
    user_id: str
    caffeine_mg: int = Field(..., ge=0, le=1000)
    logged_at: datetime


# ==================================================
# ENERGY / FATIGUE MODEL (FOR AI ENGINE)
# ==================================================

class EnergySnapshot(BaseModel):
    user_id: str
    heart_rate: Optional[int] = None
    hrv: Optional[float] = None
    stress_level: Optional[float] = None
    focus_score: Optional[float] = None
    sleep_hours: Optional[float] = None
    recorded_at: datetime


# ==================================================
# AI RECOMMENDATION MODEL
# ==================================================

class CoffeeRecommendation(BaseModel):
    user_id: str
    recommend: bool
    reason: str
    suggested_caffeine_mg: Optional[int] = None
    created_at: datetime
