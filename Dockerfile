FROM python:3.12-alpine

ENV POETRY_VIRTUALENVS_CREATE=false \
    PIP_DISABLE_PIP_VERSION_CHECK=true \
    DEBIAN_FRONTEND=noninteractive \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN apk add --no-cache make

WORKDIR /app

COPY . /app

RUN pip3 install poetry --break-system-packages && poetry install --no-interaction --no-ansi --no-cache --without dev

CMD ["make", "docker-run-production"]
