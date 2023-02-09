THIS_FILE := $(lastword $(MAKEFILE_LIST))

docker-compose := srcs/docker-compose.yml

all:	build up

build:
		mkdir -p ${HOME}/data/nginx/
		mkdir -p ${HOME}/data/mariadb/
		docker-compose -f $(docker-compose) build $(c)

up:
		docker-compose -f $(docker-compose) up -d $(c)

start:
		docker-compose -f $(docker-compose) start $(c)

down:
		docker-compose -f $(docker-compose) down $(c)

destroy:
		docker-compose -f $(docker-compose) down --rmi all -v $(c)

stop:
		docker-compose -f $(docker-compose) stop $(c)

restart:
		docker-compose -f $(docker-compose) stop $(c)
		docker-compose -f $(docker-compose) up -d $(c)

logs:
		docker-compose -f $(docker-compose) logs --tail=100 -f $(c)

logs-api:
		docker-compose -f $(docker-compose) logs --tail=100 -f api

ps:
		docker-compose -f $(docker-compose) ps

fclean: destroy
		rm -rf ${HOME}/data/mariadb/*
		rm -rf ${HOME}/data/nginx/*

re: fclean all

.PHONY: all help build up start down destroy stop restart logs logs-api ps re
