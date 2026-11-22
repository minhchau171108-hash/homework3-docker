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