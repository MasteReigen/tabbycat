# tabbycat/settings/local.py
import os
from .base import *

# Read critical settings from Railway env vars
SECRET_KEY = os.environ["SECRET_KEY"]
DEBUG = False

# Hosts / CSRF (paste your exact Railway host below if you prefer hard-coding)
ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "").split() or ["blissful-serenity.up.railway.app"]
CSRF_TRUSTED_ORIGINS = os.environ.get("CSRF_TRUSTED_ORIGINS", "").split() or ["https://blissful-serenity.up.railway.app"]

# Database – use DATABASE_URL provided by Railway Postgres
# If dj-database-url is already in requirements (it is for Tabbycat), this will Just Work.
import dj_database_url
DATABASES = {
    "default": dj_database_url.config(default=os.environ["DATABASE_URL"], conn_max_age=600)
}

# (Optional) If behind a proxy/HTTPS:
SECURE_PROXY_SSL_HEADER = ("HTTP_X_FORWARDED_PROTO", "https")
