DOCKER_COMPOSE_PATH= ./srcs/docker-compose.yml

all: folders
	docker-compose -f ${DOCKER_COMPOSE_PATH} up -d --build

folders:
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress

clean:
	-docker stop `docker ps -qa` 2> /dev/null
	-docker rm `docker ps -qa` 2> /dev/null
	-docker rmi -f `docker images -qa` 2> /dev/null
	-docker volume rm `docker volume ls -q` 2> /dev/null
	-docker network rm `docker network ls -q` 2> /dev/null

re: clean all
