/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mem_handler.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 18:35:43 by sganon            #+#    #+#             */
/*   Updated: 2018/09/17 21:03:49 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "malloc.h"

t_mem_handler *g_mem_handler = NULL;

t_mem_handler *mem_handler(void)
{
  if (!g_mem_handler)
  {
    g_mem_handler = mmap(NULL, sizeof(t_mem_handler)
				+ getpagesize() * 100 * TNY_ALLOC_MAX
				+ getpagesize() * 100 * SML_ALLOC_MAX,
				PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    g_mem_handler->tiny = (t_allocs *)(g_mem_handler + 1);
		g_mem_handler->tiny->next = NULL;
		g_mem_handler->tiny->end = g_mem_handler->tiny + 2;
    g_mem_handler->small = (t_allocs*)((char*)g_mem_handler
      + getpagesize() * 100 * TNY_ALLOC_MAX);
		g_mem_handler->small->next = NULL;
		g_mem_handler->small->end = g_mem_handler->small + 2;
		g_mem_handler->large = (t_allocs *)(g_mem_handler->tiny + 1);
		g_mem_handler->large->end = g_mem_handler->large + 1;
		g_mem_handler->large->next = NULL;
  }
  return (g_mem_handler);
}