FROM python:3.11-slim

WORKDIR /app

# Install system deps
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential gcc && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy project
COPY . .

ENV PYTHONUNBUFFERED=1

# Run migrations and collectstatic during build
RUN python manage.py collectstatic --noinput || true

# Start Tabbycat with Gunicorn
CMD gunicorn tabbycat.wsgi:application --bind 0.0.0.0:${PORT:-8000}

