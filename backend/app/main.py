from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# API Routers
from app.api import health, user, coffee


app = FastAPI(
    title="PulseBrew API",
    description="Open-source AI-powered coffee & energy companion",
    version="1.0.0"
)



app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # tighten later if needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



@app.get("/", tags=["Root"])
def root():
    return {
        "status": "PulseBrew backend running ☕",
        "docs": "/docs"
    }



app.include_router(health.router, prefix="/health", tags=["Health"])
app.include_router(user.router, prefix="/users", tags=["Users"])
app.include_router(coffee.router, prefix="/coffee", tags=["Coffee"])



@app.on_event("startup")
async def startup_event():
    print("🚀 PulseBrew backend started")

@app.on_event("shutdown")
async def shutdown_event():
    print("🛑 PulseBrew backend shutting down")
