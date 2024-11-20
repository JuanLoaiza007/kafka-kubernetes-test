# Base image
FROM python:3.12.7-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY producer-sebastian.py .

# Expose port 8003
EXPOSE 8003

# Start app
CMD ["uvicorn", "producer-sebastian:app", "--host", "0.0.0.0", "--port", "8003"]