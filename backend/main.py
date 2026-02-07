from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
from typing import List

from backend.models import RecommendationRequest, RecommendationResponse, IntakeLogBase
from backend.logic import CaffeineDecayModel

app = FastAPI(
    title="PulseBrew API",
    version="2.0.0",
    description="Offline-first, AI-driven caffeine companion backend"
)

# CORS Middleware
origins = [
    "*", # Allow all for now, restrict for production if needed
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"status": "PulseBrew backend running ☕", "version": "2.0.0"}

@app.get("/health")
def health_check():
    """
    Simple health check for Railway/Uptime monitors.
    """
    return {"status": "healthy", "timestamp": datetime.now()}

@app.post("/recommend", response_model=RecommendationResponse)
def get_recommendation(request: RecommendationRequest):
    """
    Get a caffeine recommendation based on deterministic decay model.
    """
    # Default values for now if not provided
    last_amount = 0.0
    last_time = None
    heart_rate = 70 # Default resting heart rate
    
    if request.last_intake:
        last_amount = request.last_intake.caffeine_amount_mg
        last_time = request.last_intake.timestamp
    
    # In a real scenario, we'd parse biometric string or object
    # For now, we assume a safe default or extract from a structured field if we add one
    
    result = CaffeineDecayModel.process_request(
        last_intake_time=last_time,
        last_intake_amount=last_amount,
        current_time=request.current_time,
        heart_rate=heart_rate
    )
    
    return RecommendationResponse(**result)

@app.post("/sync")
def sync_data(data: dict):
    """
    Placeholder for bi-directional sync logic with Supabase.
    Receives JSON with 'pushed_changes' and 'last_pulled_at'.
    Returns 'new_changes' since 'last_pulled_at'.
    """
    # TODO: Implement Supabase client interaction here using supabase-py
    return {"status": "sync_received", "message": "Logic to be implemented in Step 2"}

