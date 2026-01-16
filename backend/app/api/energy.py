from fastapi import APIRouter
from ai_engine.inference import should_drink

router = APIRouter(prefix="/energy")

@router.post("/check")
def check_energy(bio: dict):
    return {
        "coffee": should_drink(bio)
    }
