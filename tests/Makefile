# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sganon <sganon@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/11/24 14:11:30 by sganon            #+#    #+#              #
#    Updated: 2018/11/24 14:15:22 by sganon           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OS							= $(shell uname)
CC							= gcc
CC_FLAGS				= -Wall -Werror -Wextra
INC_FLAG				= -I../includes -I../libft
LIBFT_FLAG			= -L../libft -lft
BUILD_DIR				= objects
NAME						= malloc_tests

ifeq ($(OS), Linux)
	SRCS			= $(shell find . -regex '[a-zA-Z.\/_0-9]+\.c$$')
endif
ifeq ($(OS), Darwin)
	SRCS			= $(shell find -E . -regex '[a-zA-Z.\/_0-9]+\.c$$' | sed 's|^./||')
endif
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	@printf "Creating objects for:\n\t$<\n"
	$(CC) $(CC_FLAGS) -c $< -o $@ $(INC_FLAG)

all: $(NAME)

$(NAME): $(OBJS)
	@printf "\e[36mStarting tests compilation\e[0m\n"
	@printf "Using sources:\n\t$(SRCS)\n"
	$(CC) $(OBJS) -o $@ $(INC_FLAG) $(LIBFT_FLAG)

clean:
	@printf "\e[36mCleaning test binary\e[0m\n"
	@rm -f $(NAME)

fclean: clean
	@printf "\e[36mCleaning test objects\e[0m\n"
	@rm -rf $(BUILD_DIR)