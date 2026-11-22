FROM python:3.13-slim
ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1
WORKDIR /srv
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
RUN useradd --system --uid 10001 appuser && mkdir /data && chown 10001 /data
USER 10001
EXPOSE 8000
CMD ["python", "app.py"]
