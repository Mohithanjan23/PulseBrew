from fastapi import FastAPI
from app.api import health

app = FastAPI(
    title="PulseBrew API",
    version="1.0.0",
    description="Open AI-powered caffeine companion backend"
)

@app.get("/")
def root():
    return {"status": "PulseBrew backend running ☕"}

# Routers
app.include_router(health.router, prefix="/health", tags=["Health"])
