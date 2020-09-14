import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

#########################
#                       #
#   Required settings   #
#                       #
#########################

ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '*').split(' ')

DATABASE = {
    'NAME': os.environ.get('DB_NAME', 'dcassistant'),               # Database name
    'USER': os.environ.get('DB_USER', 'dcassistant'),               # PostgreSQL username
    'PASSWORD': os.environ.get('DB_PASSWORD', ''),                  # PostgreSQL password

    'HOST': os.environ.get('DB_HOST', 'localhost'),                 # Database server
    'PORT': os.environ.get('DB_PORT', ''),                          # Database port (leave blank for default)
    'CONN_MAX_AGE': int(os.environ.get('DB_CONN_MAX_AGE', '300')),  # Database connection persistence
}

SECRET_KEY = os.environ.get('SECRET_KEY', '')

#########################
#                       #
#   Optional settings   #
#                       #
#########################

BASE_PATH = os.environ.get('BASE_PATH', '')

DEBUG = os.environ.get('DEBUG', 'False').lower() == 'true'

PAGINATE_COUNT = int(os.environ.get('PAGINATE_COUNT', 5))

MEDIA_ROOT = os.environ.get('MEDIA_ROOT', os.path.join(BASE_DIR, 'media'))

TIME_ZONE = os.environ.get('TIME_ZONE', 'Europe/Moscow')

