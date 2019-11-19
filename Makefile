# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sganon <sganon@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/05 17:32:32 by sganon            #+#    #+#              #
#    Updated: 2019/11/19 12:53:40 by simon            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OS = $(shell uname)
ifeq ($(HOSTTYPE), )
	HOSTTYPE 		:= $(shell uname -m)_$(shell uname -s)
endif

NAME						= libft_malloc_${HOSTTYPE}.so
LINKED_NAME			= libft_malloc.so
TEST_NAME				= malloc_tests

CC							= clang
CC_FLAGS				= -Wall -Werror -Wextra -fPIC
INC_FLAG				= -I./includes -I./libft
LIBFT_FLAG			= -L./libft -lft


ifeq ($(OS), Linux)
	SRCS			= $(shell find src -regex '[a-zA-Z.\/_0-9]+\.c$$')
	TEST_SRCS	= $(shell find tests -regex '[a-zA-Z.\/_0-9]+\.c$$')
endif
ifeq ($(OS), Darwin)
	SRCS			= $(shell find -E src -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')
	TEST_SRCS	= $(shell find -E tests -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')
endif

BUILD_DIR	= ./build
OBJS 			:= $(SRCS:%=$(BUILD_DIR)/%.o)
TEST_OBJS := $(TEST_SRCS:%=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	@printf "Creating objects for:\n\t$<\n"
ifeq ($(CC_JSON_FLAG), -MJ)
	$(CC) $(CC_JSON_FLAG) $@.json $(CC_FLAGS) -c $< -o $@ $(INC_FLAG)
else
	$(CC) $(CC_FLAGS) -c $< -o $@ $(INC_FLAG)
endif
	@printf "\e[32mCreated $@\e[0m\n"

all: deps $(NAME) symlink

deps:
	@printf "\e[36mUpdating dependencies (libft)\e[0m\n"
	@sh ./deps_install.sh
	@printf "\e[36mBuilding libft\e[0m\n"
	@make -C libft/

$(NAME): deps includes/malloc.h $(OBJS)
	@printf "\e[36mStarting lib malloc compilation\e[0m\n"
	@printf "Using object files:\n\t$(OBJS)\n"
	@$(CC) $(CC_FLAGS) $(LIBFT_FLAG) -shared $(OBJS) -o $@
	@printf "\e[32m$@ created\e[0m\n"
	@make symlink

compile_commands.json:
	@rm -rf $(BUILD_DIR)
	@make CC_JSON_FLAG="-MJ" $(NAME)
	@/usr/bin/sed -e '1s/^/[/' -e '$$s/,$$/]/' $(BUILD_DIR)/**/*.o.json > compile_commands.json

symlink:
	@if [ ! -e ${LINKED_NAME} ]; then \
		/bin/ln -s ${NAME} ${LINKED_NAME}; \
		printf "\e[36mSymlink $(NAME) -> $(LINKED_NAME) created\e[0m\n"; \
	fi

test: $(NAME) $(TEST_OBJS)
	@$(CC) $(CC_FLAGS) -o $(TEST_NAME) $(TEST_OBJS) $(LIBFT_FLAG) -L./ -lft_malloc
	@printf "\e[36mTest compiled you can run $(TEST_NAME) or make run_test\e[0m\n"

run_test: test
	./$(TEST_NAME)

clean:
	@make -C libft/ clean
	@rm -rf $(BUILD_DIR)
	@printf "\e[36mObject cleaned\e[0m\n"

fclean : clean
	@make -C libft/ fclean
	@rm -f $(NAME) $(LINKED_NAME)
	@printf "\e[36mMalloc libraries removed\e[0m\n"

re : fclean all

.PHONY: clean fclean run_test
