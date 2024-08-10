PATH_DOCKER_COMPOSE = ./srcs/docker-compose.yml
PATH_WORDPRESS = /home/fpalumbo/data/srcs_wordpress
PATH_MARIADB = /home/fpalumbo/data/srcs_mariadb

all:
	mkdir -p $(PATH_WORDPRESS)
	mkdir -p $(PATH_MARIADB)
	@sudo docker-compose -f $(PATH_DOCKER_COMPOSE) up -d --build

stop:
	@sudo docker-compose -f $(PATH_DOCKER_COMPOSE) down

clean: stop
	@sudo rm -rf $(PATH_WORDPRESS)
	@sudo rm -rf $(PATH_MARIADB)

fclean: stop clean
	@sudo docker system prune -af