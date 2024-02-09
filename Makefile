# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtrautne <mtrautne@student.42wolfsburg.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/31 10:54:48 by mtrautne          #+#    #+#              #
#    Updated: 2024/01/31 14:45:06 by mtrautne         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception

CONT_DIR =	./srcs/requirements/

CONTAINERS =	nginx wordpress mariadb

DOCKERFILES =	$(addsuffix /Dockerfile, $(addprefix $(CONT_DIR), $(CONTAINERS)))

all: $(NAME)

$(NAME): $(DOCKERFILES)
	cd srcs && docker-compose up -d
	@echo "make all finished"

stop:

	cd srcs && docker-compose stop

down:
	cd srcs && docker-compose down

clean:
	@echo "clean not implemented"

fclean: clean
	@echo "fclean not implemented"

re: fclean all

.PHONY: all clean fclean re