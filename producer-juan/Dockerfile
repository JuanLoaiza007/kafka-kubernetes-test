# Base image
FROM python:3.12.7-slim

# Working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY producer-juan.py .

# Expose port
EXPOSE 8000

# Start app
CMD ["uvicorn", "producer-juan:app", "--host", "0.0.0.0", "--port", "8000"]
