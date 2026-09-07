FROM python:3.12-slim AS builder

WORKDIR /build

RUN python -m pip install --no-cache-dir --upgrade pip

COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir --prefix=/install -r requirements.txt



FROM python:3.12-slim AS runner

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --disabled-password app

WORKDIR /app

COPY --from=builder /install /usr/local

COPY --chown=app:app app/ .

USER app

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]