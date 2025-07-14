FROM python:3.12-alpine AS base

FROM base AS builder

ENV PIP_DISABLE_PIP_VERSION_CHECK=true
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV POETRY_CACHE_DIR=/tmp/poetry_cache
ENV POETRY_VIRTUALENVS_IN_PROJECT=false
ENV POETRY_VIRTUALENVS_CREATE=true
ENV POETRY_VIRTUALENVS_OPTIONS_ALWAYS_COPY=true

WORKDIR /app

COPY pyproject.toml poetry.lock /app

RUN pip3 install poetry --break-system-packages && \
    poetry install --no-interaction --no-ansi --only main --no-root --no-directory

FROM base

WORKDIR /app

# we all hope poetry won't rename this stuff later
ENV VIRTUAL_ENV=/tmp/poetry_cache/virtualenvs/vas3k-blog-9TtSrW0h-py3.12
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"
COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY . /app

CMD ["cp -r /app/frontend/static /tmp/ && python3 manage.py migrate && gunicorn vas3k_blog.asgi:application -w 5 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8022 --capture-output --log-level debug --access-logfile - --error-logfile -"]
