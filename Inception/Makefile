PATH_DOCKER_COMPOSE = ./srcs/docker-compose.yml
PATH_WORDPRESS = /Users/fabio/data/srcs_wordpress
PATH_MARIADB = /Users/fabio/data/srcs_mariadb

all:
	mkdir -p $(PATH_WORDPRESS)
	mkdir -p $(PATH_MARIADB)
	@sudo docker-compose -f $(PATH_DOCKER_COMPOSE) up -d --build

clean:
	@sudo docker-compose -f $(PATH_DOCKER_COMPOSE) down

fclean: clean
	@sudo rm -rf $(PATH_WORDPRESS)
	@sudo rm -rf $(PATH_MARIADB)
	@sudo docker system prune -af