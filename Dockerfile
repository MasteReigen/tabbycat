FROM python:3.11-slim

WORKDIR /app
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

# Install runtime tools
RUN pip install --no-cache-dir pipenv gunicorn

# Install Python deps from Pipenv (no apt-get needed)
COPY Pipfile Pipfile.lock ./
RUN pipenv install --system --deploy

# Copy project files
COPY . .

# Start Tabbycat with Gunicorn; Railway injects $PORT
CMD gunicorn tabbycat.wsgi:application --bind 0.0.0.0:${PORT:-8000}
