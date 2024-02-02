# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtrautne <mtrautne@student.42wolfsburg.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/02 16:20:23 by mtrautne          #+#    #+#              #
#    Updated: 2024/02/02 22:20:25 by mtrautne         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

SRCS_DIR =	./srcs/
CONT_DIR =	requirements/

CONTAINERS = mariadb nginx wordpress

DOCKERFILES = $(addsuffix /Dockerfile, $(addprefix $(SRCS_DIR)$(CONT_DIR), $(CONTAINERS)))

all: $(NAME)

$(NAME): $(DOCKERFILES)
	cd $(SRCS_DIR) && docker-compose up -d

up:
	cd $(SRCS_DIR) && docker-compose up -d

down:
	cd $(SRCS_DIR) && docker-compose down -d

.PHONY: all up down