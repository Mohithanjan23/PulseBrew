from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
import uuid

class UserBase(BaseModel):
    username: str
    email: Optional[str] = None

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: uuid.UUID
    created_at: datetime
    
    class Config:
        from_attributes = True

class IntakeLogBase(BaseModel):
    caffeine_amount_mg: float
    beverage_name: str
    timestamp: datetime

class IntakeLog(IntakeLogBase):
    id: uuid.UUID
    user_id: uuid.UUID
    synced: bool = False # For client-side tracking, maybe not needed here but good for consistency

    class Config:
        from_attributes = True

class BiometricSnapshotBase(BaseModel):
    heart_rate_bpm: int
    activity_level: str # "resting", "walking", "running", "unknown"
    timestamp: datetime

class BiometricSnapshot(BiometricSnapshotBase):
    id: uuid.UUID
    user_id: uuid.UUID

    class Config:
        from_attributes = True

# --- API Models ---

class RecommendationRequest(BaseModel):
    user_id: str
    current_time: datetime
    last_intake: Optional[IntakeLogBase] = None
    recent_biometrics: Optional[str] = None # Placeholder for now

class RecommendationResponse(BaseModel):
    should_consume: bool
    reason: str
    current_plasma_level: float
    recommended_amount_mg: float
    next_allowable_intake: Optional[datetime]
