# bittorrent-tracker
bittorrent-tracker docker

```
cd ~  
git clone https://github.com/buzzkillb/bittorrent-tracker  
cd bittorrent-tracker 

docker build -t tracker .  
```
test run  
```
docker run -d --name bittorrent-tracker --restart=unless-stopped -p 6969:8000 -p 6969:8000/udp tracker
```

docker-compose.yml  

```
version: "3.3"

services:

  traefik:
    image: "traefik:v2.4"
    container_name: "traefik"
    command:
      #- "--log.level=DEBUG"
      - "--api.insecure=true"
      #- "--api.dashboard=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.myresolver.acme.dnschallenge=true"
      - "--certificatesresolvers.myresolver.acme.dnschallenge.provider=cloudflare"
      #- "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
      - "--certificatesresolvers.myresolver.acme.email=email@example.com"
      - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "80:80"
      - "443:443"
      - "8080:8080"
    environment:
      - "CF_API_EMAIL=email@example.com"
      - "CF_API_KEY=SECRETAPIKEY"
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  tracker:
    image: "tracker"
    container_name: "bittorrent-tracker"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.tracker.rule=Host(`yourwebsite.example.com`)"
      - "traefik.http.routers.tracker.entrypoints=web"
      - "traefik.http.routers.tracker.entrypoints=websecure"
      - "traefik.http.routers.tracker.tls.certresolver=myresolver"
      - traefik.webservice.frontend.entryPoints=http,https,ws,wss
      - "traefik.http.services.tracker.loadbalancer.server.port=8000"
```
