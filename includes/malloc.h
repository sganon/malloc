/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   malloc.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/08/05 17:35:54 by sganon            #+#    #+#             */
/*   Updated: 2018/09/17 21:48:55 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MALLOC_H
# define MALLOC_H

# include <stdlib.h>
# include <sys/mman.h>
# include <sys/types.h>
# include <stdint.h>

# include "libft.h"
# include "mem_handler.h"

void    show_alloc_mem();
void    *malloc(size_t size);

#endif