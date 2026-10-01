FROM python:3.11-slim

WORKDIR /app
ENV TZ=Asia/Shanghai \
    PYTHONUNBUFFERED=1 \
    PIP_INDEX_URL=https://mirrors.cloud.tencent.com/pypi/simple \
    PIP_DEFAULT_TIMEOUT=120

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

EXPOSE 8000
CMD ["uvicorn", "app_main:app", "--host", "0.0.0.0", "--port", "8000"]
