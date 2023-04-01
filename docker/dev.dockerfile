FROM python:3.11-alpine

COPY requirements.txt /app/
WORKDIR /app
RUN python3 -m pip install -r requirements.txt --no-cache-dir

EXPOSE 8000

ENTRYPOINT ["uvicorn", "fastapi_k8s_app.app:app", "--reload", "--host", "0.0.0.0"]