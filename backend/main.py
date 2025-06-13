from fastapi import FastAPI
import uvicorn
from starlette.middleware.cors import CORSMiddleware

from FishModule.app import router as fishModule

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(fishModule, prefix="/api/fish", tags=["Fish Module"])

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)


