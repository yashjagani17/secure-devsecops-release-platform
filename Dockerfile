FROM python:3.12-slim

RUN adduser --disabled-password app

WORKDIR /app

COPY --chown=app:app app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=app:app app/ .

USER app

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]