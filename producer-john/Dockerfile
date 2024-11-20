FROM python:3.12.7-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY producer-john.py .

EXPOSE 5000

CMD ["python", "producer-john.py"]
