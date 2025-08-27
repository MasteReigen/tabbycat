FROM python:3.11-slim

WORKDIR /app
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1
# If your requirements use psycopg2, switch them to psycopg2-binary to avoid gcc/libpq
# so we don't need apt-get at all.

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

COPY . .

# Collect static at build time (non-fatal if settings aren't ready)
RUN python manage.py collectstatic --noinput || true

CMD gunicorn tabbycat.wsgi:application --bind 0.0.0.0:${PORT:-8000}
