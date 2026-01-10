COMPOSE = docker compose
BASE = -f docker-compose.yml

.PHONY: up down logs ps

# Standard
up:
	$(COMPOSE) $(BASE) up -d

# Mit USB-Zigbee-Stick
up-usb:
	$(COMPOSE) $(BASE) -f docker-compose.usb.yml up -d

# Mit ESPHome
up-esphome:
	$(COMPOSE) $(BASE) -f docker-compose.esphome.yml up -d

# Mit öffentlichem Broker
up-public:
	$(COMPOSE) $(BASE) -f docker-compose.publicbroker.yml up -d

# Kombinationen
up-usb-esphome:
	$(COMPOSE) $(BASE) -f docker-compose.usb.yml -f docker-compose.esphome.yml up -d

up-all:
	$(COMPOSE) $(BASE) -f docker-compose.usb.yml -f docker-compose.esphome.yml -f docker-compose.publicbroker.yml up -d

down:
	$(COMPOSE) $(BASE) down

logs:
	$(COMPOSE) $(BASE) logs -f

ps:
	$(COMPOSE) $(BASE) ps
