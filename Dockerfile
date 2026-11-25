FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/*

COPY ["ARIX_SCREEN_SHARING_REMOTE_CONTROL_SOURCE (2).zip", "/tmp/arix-source.zip"]
RUN unzip -q /tmp/arix-source.zip -d /app \
    && rm /tmp/arix-source.zip \
    && pip install --no-cache-dir -r /app/ARIX_SCREEN_SHARING/backend/requirements.txt

WORKDIR /app/ARIX_SCREEN_SHARING
EXPOSE 10000
CMD ["sh", "-c", "python -m uvicorn backend.main:app --host 0.0.0.0 --port ${PORT:-10000}"]
