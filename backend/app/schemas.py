from pydantic import BaseModel, EmailStr
from datetime import datetime

# -------- USER --------
class UserCreate(BaseModel):
    email: EmailStr
    name: str

class UserResponse(UserCreate):
    id: str

# -------- COFFEE --------
class CoffeeCreate(BaseModel):
    user_id: str
    caffeine_mg: int

class CoffeeResponse(CoffeeCreate):
    id: str
    logged_at: datetime
