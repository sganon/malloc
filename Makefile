# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sganon <sganon@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/05 17:32:32 by sganon            #+#    #+#              #
#    Updated: 2018/08/05 18:05:08 by sganon           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ifeq ($(HOSTTYPE), )
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

NAME			= libft_malloc_${HOSTTYPE}.so
LINKED_NAME		= libft_malloc.so

CC				= gcc
CC_FLAGS		= -shared -Wall -Werror -Wextra -fPIC
INC_FLAGS		= -I./includes

SRC_DIRS		= ./src
SRCS			:= $(shell find $(SRC_DIRS) -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')


$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) -c $< -o $@ $(INC_FLAG)

all: $(NAME) symlink

$(NAME): $(SRCS)
	@printf "\e[36mStarting lib malloc compilation\e[0m\n"
	@printf "Using sources:\n\t$(SRCS)\n"
	@$(CC) $(CC_FLAGS) $(SRCS) $(INC_FLAG) -o $@ 
	@printf "\e[32m$@ created\e[0m\n"

symlink:
	@if [ ! -e ${LINKED_NAME} ]; then \
		/bin/ln -s ${NAME} ${LINKED_NAME}; \
		printf "\e[36mSymlink $(NAME) -> $(LINKED_NAME) created\e[0m\n"; \
	fi
