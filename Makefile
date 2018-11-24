# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sganon <sganon@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/05 17:32:32 by sganon            #+#    #+#              #
#    Updated: 2018/11/24 14:13:58 by sganon           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OS = $(shell uname)

ifeq ($(HOSTTYPE), )
	HOSTTYPE 		:= $(shell uname -m)_$(shell uname -s)
endif

NAME						= libft_malloc_${HOSTTYPE}.so
LINKED_NAME			= libft_malloc.so

CC							= gcc
CC_FLAGS				= -shared -Wall -Werror -Wextra -fPIC
INC_FLAG				= -I./includes -I./libft
LIBFT_FLAG			= -L./libft -lft


ifeq ($(OS), Linux)
	SRCS			= $(shell find src -regex '[a-zA-Z.\/_0-9]+\.c$$')
endif
ifeq ($(OS), Darwin)
	SRCS			= $(shell find -E src -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')
endif

ifeq ($(OS), Linux)
	TEST_SRCS			= $(shell find tests -regex '[a-zA-Z.\/_0-9]+\.c$$')
endif
ifeq ($(OS), Darwin)
	TEST_SRCS			= $(shell find -E tests -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')
endif

$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	@printf "Creating objects for:\n\t$<\n"
	$(CC) $(CC_FLAGS) -c $< -o $@ $(INC_FLAG)

all: deps $(NAME) symlink

deps:
	@printf "\e[36mUpdating dependencies (libft)\e[0m\n"
	@sh ./deps_install.sh
	@printf "\e[36mBuilding libft\e[0m\n"
	@make -C libft/

$(NAME): $(SRCS)
	@printf "\e[36mStarting lib malloc compilation\e[0m\n"
	@printf "Using sources:\n\t$(SRCS)\n"
	@$(CC) $(CC_FLAGS) $(SRCS) $(INC_FLAG) $(LIBFT_FLAG) -o $@ 
	@printf "\e[32m$@ created\e[0m\n"

symlink:
	@if [ ! -e ${LINKED_NAME} ]; then \
		/bin/ln -s ${NAME} ${LINKED_NAME}; \
		printf "\e[36mSymlink $(NAME) -> $(LINKED_NAME) created\e[0m\n"; \
	fi

test: $(NAME)
	@make -C tests
	@printf "\e[36mTest compiled you can run ./tests/malloc_tests\e[0m\n"

clean:
	@make -C libft/ clean
	@rm -rf $(BUILD_DIR)
	@printf "\e[36mObject cleaned\e[0m\n"
	@make -C tests/ clean

fclean : clean
	@make -C libft/ fclean
	@rm -f $(NAME) $(LINKED_NAME)
	@printf "\e[36mMalloc libraries removed\e[0m\n"
	@make -C tests/ fclean

re : fclean all

.PHONY: clean fclean run
