FROM python:3.11-alpine

COPY requirements*.* /app/
WORKDIR /app
RUN python3 -m pip install -r requirements.txt --no-cache-dir && \
    python3 -m pip install -r requirements-test.txt --no-cache-dir

COPY docker/tests_entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]