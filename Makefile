# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtrautne <mtrautne@student.42wolfsburg.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/31 10:54:48 by mtrautne          #+#    #+#              #
#    Updated: 2024/02/14 10:50:23 by mtrautne         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CONT_DIR =	./srcs/requirements/
CONTAINERS =	nginx wordpress mariadb

DOCKERFILES =	$(addsuffix /Dockerfile, $(addprefix $(CONT_DIR), $(CONTAINERS)))

all: up

# add -d for detached mode
up: $(DOCKERFILES)
	@cd srcs && docker-compose up

# ps = process status
status:
	@cd srcs && docker-compose ps

# stops in 0 seconds time (immediately)
kill:
	@cd srcs && docker-compose stop -t 0

# shuts down all containers and removes them
down:
	@cd srcs && docker-compose down

# forces rebuild of all containers before starting
re: $(DOCKERFILES) kill down
	@echo "Rebuilding all containers..."
	@cd srcs && docker-compose up --build

# remove all containers of this project and their volumes
clean: down
	@echo "Attempting removal of the following containers: nginx, wordpress, mariadb..."
	@docker rm -vf nginx wordpress mariadb

# remove all containers, networks and images Todo: remove volumes
fclean: clean
	@echo "Attempting removal of the following images: srcs-wordpress, srcs-mariadb, srcs-nginx..."
	@docker rmi -f srcs-wordpress srcs-mariadb srcs-nginx
	@echo "Attempting removal of the following volumes: wordpress_vol, mariadb_vol..."
	@docker volume rm mariadb_vol wordpress_vol
	@echo "Attempting removal of the following networks: inception_network..."
	@docker network rm inception_network

# add alias for localhost (or do by hand)
linux_add_host_alias:
	@echo "Adding host alias for mtrautne.42.fr to /etc/hosts..."
	sudo -- sh -c "echo '127.0.0.1 mtrautne.42.fr' >> /etc/hosts"

linux_remove_host_alias:
	@echo "Removing host alias for mtrautne.42.fr from /etc/hosts..."
	sudo sed -i '/127.0.0.1 mtrautne.42.fr/d' /etc/hosts
	@echo "Host alias removed."

.PHONY: all up status kill down re clean fclean linux_add_host_alias linux_remove_host_alias