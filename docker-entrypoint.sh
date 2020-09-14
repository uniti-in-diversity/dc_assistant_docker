#!/bin/bash

#stop if errors
set -e

#run as non-root users
umask 775

#try to connect to DB
DB_WAIT_TIMEOUT=${DB_WAIT_TIMEOUT-3}
MAX_DB_WAIT_TIME=${MAX_DB_WAIT_TIME-30}
CUR_DB_WAIT_TIME=0

./dc_assistant/manage.py makemigrations
while ! ./dc_assistant/manage.py migrate 2>&1 && [ "${CUR_DB_WAIT_TIME}" -lt "${MAX_DB_WAIT_TIME}" ]; do
  echo "⏳ Waiting on DB... (${CUR_DB_WAIT_TIME}s / ${MAX_DB_WAIT_TIME}s)"
  sleep "${DB_WAIT_TIMEOUT}"
  CUR_DB_WAIT_TIME=$(( CUR_DB_WAIT_TIME + DB_WAIT_TIMEOUT ))
done
if [ "${CUR_DB_WAIT_TIME}" -ge "${MAX_DB_WAIT_TIME}" ]; then
  echo "❌ Waited ${MAX_DB_WAIT_TIME}s or more for the DB to become ready."
  exit 1
fi

# Create Superuser
if [ -z ${SUPERUSER_NAME} ]; then
SUPERUSER_NAME='admin'
fi
if [ -z ${SUPERUSER_EMAIL} ]; then
SUPERUSER_EMAIL='admin@example.com'
fi
if [ -z ${SUPERUSER_PASSWORD} ]; then
SUPERUSER_PASSWORD='admin'
fi

  ./dc_assistant/manage.py shell --interface python << END
from django.contrib.auth.models import User
if not User.objects.filter(username='${SUPERUSER_NAME}'):
    u=User.objects.create_superuser('${SUPERUSER_NAME}', '${SUPERUSER_EMAIL}', '${SUPERUSER_PASSWORD}')
END

echo "💡 Superuser Username: ${SUPERUSER_NAME}, E-Mail: ${SUPERUSER_EMAIL}"

#./dc_assistant/manage.py collectstatic --no-input

echo "✅ Initialisation is done."

exec $@
