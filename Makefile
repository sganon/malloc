# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sganon <sganon@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/05 17:32:32 by sganon            #+#    #+#              #
#    Updated: 2018/09/17 15:22:24 by sganon           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OS = $(shell uname)

ifeq ($(HOSTTYPE), )
	HOSTTYPE 		:= $(shell uname -m)_$(shell uname -s)
endif

NAME						= libft_malloc_${HOSTTYPE}.so
LINKED_NAME			= libft_malloc.so

TESTS_NAME			= malloc_tests

CC							= gcc
CC_FLAGS				= -shared -Wall -Werror -Wextra -fPIC
CC_FLAGS_TESTS	= -Wall -Werror -Wextra
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

$(TESTS_NAME): $(NAME)
	@printf "\e[36mStarting tests compilation\e[0m\n"
	@printf "Using sources:\n\t$(TEST_SRCS)\n"
	@$(CC) $(CC_FLAGS_TESTS) $(TEST_SRCS) $(INC_FLAG) $(LIBFT_FLAG) -o $(TESTS_NAME)

test: $(TESTS_NAME) run

run:
	./$(TESTS_NAME)

symlink:
	@if [ ! -e ${LINKED_NAME} ]; then \
		/bin/ln -s ${NAME} ${LINKED_NAME}; \
		printf "\e[36mSymlink $(NAME) -> $(LINKED_NAME) created\e[0m\n"; \
	fi

clean:
	@make -C libft/ clean
	@rm -rf $(BUILD_DIR)
	@printf "\e[36mObject cleaned\e[0m\n"

fclean : clean
	@make -C libft/ fclean
	@rm -f $(NAME) $(LINKED_NAME)
	@printf "\e[36mMalloc libraries removed\e[0m\n"

re : fclean all

.PHONY: clean fclean run
