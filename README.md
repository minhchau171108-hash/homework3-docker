# ДЗ 3: Docker

Запуск:
```bash
cp .env.example .env
docker compose up -d --build --wait
```

Проверка:
```bash
curl -fsS http://127.0.0.1:8080/
curl -fsS -X POST http://127.0.0.1:8080/increment
curl -fsS http://127.0.0.1:8080/readyz
```

Остановка (данные сохраняются):
```bash
docker compose down
```
Не используйте `docker compose down -v`: он удаляет volume с данными.

Настройки в `.env`: `HOST_PORT` (порт на компьютере), `PORT` (порт в контейнере), `GREETING` (приветствие).

Данные хранит Redis (сервис `redis`, именованный volume `redis-data` в `/data`, запись на диск включена). У обоих сервисов есть healthcheck.

Отчёт: `REPORT.md`.