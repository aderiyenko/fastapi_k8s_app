from socket import gethostname
from time import time

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {
        "timestamp": time(),
        "hostname": gethostname(),
    }
