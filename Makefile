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

# builds containers specified in docker-compose.yml and starts them
# add flag -d for detached mode (to run in background)
up: $(DOCKERFILES)
	cd srcs && docker-compose up

stop:
	cd srcs && docker-compose stop

down:
	cd srcs && docker-compose down

# forces a rebuild of the docker containers before starting
rebuild:
	cd srcs && docker-compose up --build

# remove all containers
clean:
	docker rm -vf $$(docker ps -aq)

# remove all containers and images
fclean: clean
	docker rmi -f $$(docker images -aq)

# add alias for localhost (or do by hand)
# linux_add_host_alias:
# 	@echo "Adding host alias for mtrautne.42.fr to /etc/hosts..."
# 	sudo -- sh -c "echo '127.0.0.1 mtrautne.42.fr' >> /etc/hosts"
# 	@echo "Host alias added."

# linux_remove_host_alias:
# 	@echo "Removing host alias for mtrautne.42.fr from /etc/hosts..."
# 	sudo sed -i '' '/mtrautne.42.fr/d' /etc/hosts
# 	@echo "Host alias removed."

re: fclean all

.PHONY: all clean fclean re stop down linux_add_host_alias linux_remove_host_alias