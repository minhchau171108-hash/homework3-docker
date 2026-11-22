Уровень 4:
```bash
docker build -t counter-app .
docker run -d --name counter -p 8080:8000 -e GREETING="Привет" counter-app
curl -fsS http://127.0.0.1:8080/
curl -fsS -X POST http://127.0.0.1:8080/increment
curl -fsS http://127.0.0.1:8080/readyz
curl -fsS -X POST http://127.0.0.1:8080/increment
```
Вывод:
```
{"greeting": "Привет", "count": 0, "hostname": "26706b63455d", "storage": "sqlite"}
{"greeting": "Привет", "count": 1, "hostname": "26706b63455d", "storage": "sqlite"}
{"status": "ready", "storage": "sqlite"}
{"greeting": "Привет", "count": 2, "hostname": "26706b63455d", "storage": "sqlite"}
```
Логи:
```
2026-11-22 15:10:00,089 listening port=8000 storage=sqlite
2026-11-22 15:15:44,705 http 192.168.65.1 "GET / HTTP/1.1" 200 -
2026-11-22 15:15:44,736 http 192.168.65.1 "POST /increment HTTP/1.1" 200 -
2026-11-22 15:15:44,753 http 192.168.65.1 "GET /readyz HTTP/1.1" 200 -
2026-11-22 15:15:50,542 http 192.168.65.1 "POST /increment HTTP/1.1" 200 -
```


Уровень 6:
```bash
docker compose up -d --build
curl -fsS -X POST http://127.0.0.1:8080/increment
curl -fsS -X POST http://127.0.0.1:8080/increment
curl -fsS -X POST http://127.0.0.1:8080/increment
docker compose down
docker compose up -d
curl -fsS http://127.0.0.1:8080/
```
Вывод:
```
{"greeting": "Hello, Docker!", "count": 3, "hostname": "56df293edac3", "storage": "sqlite"}
{"greeting": "Hello, Docker!", "count": 3, "hostname": "1a638265d04f", "storage": "sqlite"}
```
Счётчик остался 3 после пересоздания контейнера (hostname другой): данные сохранились в volume.


Уровень 8:
```bash
docker compose up -d --build --wait
docker compose ps
curl -fsS -X POST http://127.0.0.1:8080/increment #три раза
docker compose down
docker compose up -d --wait
curl -fsS http://127.0.0.1:8080/
```
Вывод:
```
homework3-docker-app-1     Up 22 seconds (healthy)   0.0.0.0:8080->8000/tcp
homework3-docker-redis-1   Up 28 seconds (healthy)   6379/tcp
{"greeting": "Hello, Docker!", "count": 1, "hostname": "ec4081d6bd76", "storage": "redis"}
{"greeting": "Hello, Docker!", "count": 2, "hostname": "ec4081d6bd76", "storage": "redis"}
{"greeting": "Hello, Docker!", "count": 3, "hostname": "ec4081d6bd76", "storage": "redis"}

после down и up -d:
{"greeting": "Hello, Docker!", "count": 3, "hostname": "83e80976cf0c", "storage": "redis"}
```
Счётчик остался 3 после пересоздания контейнеров (hostname другой), данные в Redis.

Остановка и запуск Redis:
```bash
docker compose stop redis
curl -s -o /dev/null -w "healthz %{http_code}\n" http://127.0.0.1:8080/healthz
curl -s -o /dev/null -w "readyz %{http_code}\n" http://127.0.0.1:8080/readyz
curl -s -o /dev/null -w "increment %{http_code}\n" -X POST http://127.0.0.1:8080/increment
docker compose start redis
curl -fsS http://127.0.0.1:8080/
curl -fsS -X POST http://127.0.0.1:8080/increment
```
Вывод:
```
healthz 200
readyz 503
increment 503
{"greeting": "Hello, Docker!", "count": 3, "hostname": "83e80976cf0c", "storage": "redis"}
{"greeting": "Hello, Docker!", "count": 4, "hostname": "83e80976cf0c", "storage": "redis"}
```
