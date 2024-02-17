# Smarthome

This repository contains a Home Assistant instance with an MQTT broker as well as a Postgres database.

## Requirements

Make sure that the [nginx reverse proxy](https://gitlab.com/hueske-digital/services/proxy) is already set up and started.

## Setup instructions

Clone the code to your server:<br>
```
git clone git@gitlab.com:hueske-digital/services/smarthome.git ~/services/smarthome
```

Create environment file and fill up with your values:<br>
```
cd ~/services/smarthome && cp .env.example .env && vim .env
```

Pull images and start the docker compose file:<br>
```
docker compose up -d
```

Add some configuration to Home Assistant:<br>
```
docker compose exec app /bin/sh -c 'vi /config/configuration.yaml'
```

```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.16.0.0/12

recorder:
  purge_keep_days: 14
  commit_interval: 5
  db_url: !env_var DATABASE_URL
```

Recreate all container to get things ready:<br>
```
docker compose up -d --force-recreate
```

While waiting you can create a host in your nginx proxy manager which points to `smarthome-app-1` with port `8123` and websockets enabled. Some other vhost should redirect to `smarthome-bridge-1` with port `8080` and those for the config editor to `smarthome-editor-1` and port `8443`. The mqtt broker can be used by adding host `broker` on port `1883` in the Home Assistant integration.

If you want to make your broker available in your network start the container with
```
docker compose -f docker-compose.yml -f docker-compose.publicbroker.yml up -d
```

### ESPHome

This repository ships with [ESPHome](https://esphome.io/). You can start it by adding the `docker-compose.esphome.yml` when starting:

```
docker compose -f docker-compose.yml -f docker-compose.esphome.yml up -d
```

Add a host in the reverse proxy pointing to `smarthome-esphome-1` on port `6052`.

## Other information

Update all container images and recreate them if new images are available:<br>
```
docker compose pull && docker compose up -d
```

Restart a single container:<br>
```
docker compose restart app
```

Shutdown all container of this compose file:<br>
```
docker compose down
```

Show and follow logs:<br>
```
docker compose logs -ft
```

Additional configuration:<br>
You can include any other docker config by using an additional [compose file](https://docs.docker.com/compose/extends/).
