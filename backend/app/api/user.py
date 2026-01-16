from fastapi import APIRouter
from app.schemas import UserCreate, UserResponse
from app.database import supabase

router = APIRouter()

@router.post("/register", response_model=UserResponse)
def register_user(user: UserCreate):
    response = supabase.table("users").insert({
        "email": user.email,
        "name": user.name
    }).execute()

    return response.data[0]

@router.get("/{user_id}", response_model=UserResponse)
def get_user(user_id: str):
    response = supabase.table("users").select("*").eq("id", user_id).single().execute()
    return response.data
