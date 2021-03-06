FROM python:3.7-buster
RUN set -ex apk add --no-cache postgresql-client postgresql-dev build-base nano ca-certificates ttf-ubuntu-font-family gunicorn git

RUN git clone https://github.com/uniti-in-diversity/dc_assistant.git /tmp/app && mkdir -p /app/dc_assistant && cp -r /tmp/app/dc_assistant /app/dc_assistant/dc_assistant
RUN pip install --no-cache-dir --no-warn-script-location -r /tmp/app/requirements.txt
RUN pip install --no-cache-dir --no-warn-script-location gunicorn
RUN rm -R /tmp/app && chmod -R 775 /app

COPY ./conf/configuration.py /app/dc_assistant/dc_assistant/dc_assistant/configuration.py
COPY ./conf/gunicorn_config.py /app/dc_assistant/gunicorn_config.py
COPY ./docker-entrypoint.sh /app/dc_assistant/docker-entrypoint.sh

WORKDIR /app/dc_assistant

ENTRYPOINT ["bash","/app/dc_assistant/docker-entrypoint.sh" ]

CMD ["gunicorn", "-c /app/dc_assistant/gunicorn_config.py", "dc_assistant.wsgi"]