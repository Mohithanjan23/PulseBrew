from fastapi import APIRouter
from app.schemas import CoffeeCreate, CoffeeResponse
from app.database import supabase
from datetime import datetime

router = APIRouter()

@router.post("/log", response_model=CoffeeResponse)
def log_coffee(coffee: CoffeeCreate):
    response = supabase.table("coffee_logs").insert({
        "user_id": coffee.user_id,
        "caffeine_mg": coffee.caffeine_mg,
        "logged_at": datetime.utcnow().isoformat()
    }).execute()

    return response.data[0]

@router.get("/history/{user_id}")
def coffee_history(user_id: str):
    response = supabase.table("coffee_logs").select("*").eq("user_id", user_id).execute()
    return response.data
