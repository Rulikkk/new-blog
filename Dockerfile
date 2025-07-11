FROM python:3.12-alpine

ENV POETRY_VIRTUALENVS_CREATE=false
ENV PIP_DISABLE_PIP_VERSION_CHECK=true
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN apk add --no-cache make

WORKDIR /app

COPY . /app

RUN pip3 install poetry --break-system-packages && poetry install --no-interaction --no-ansi

CMD ["make", "docker-run-production"]
