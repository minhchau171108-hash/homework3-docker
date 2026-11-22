# ДЗ 3: Docker

Запуск:
```bash
cp .env.example .env
docker compose up -d --build
```
Проверка:
```bash
curl -fsS http://127.0.0.1:8080/
curl -fsS -X POST http://127.0.0.1:8080/increment
curl -fsS http://127.0.0.1:8080/readyz
```
Настройки в `.env`: `HOST_PORT` (порт на компьютере), `PORT` (порт в контейнере), `GREETING` (приветствие).
Счётчик хранится в именованном volume `counter-data`. Не используйте `docker compose down -v`: он удаляет volume со счётчиком.
Отчёт: `REPORT.md`.
