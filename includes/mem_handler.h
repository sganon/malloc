/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mem_handler.h                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 18:36:51 by sganon            #+#    #+#             */
/*   Updated: 2018/09/18 13:13:20 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MEM_HANDLER_H
# define MEM_HANDLER_H

# define TNY_ALLOC_MAX 512
# define SML_ALLOC_MAX 1024

typedef struct    s_allocs
{
 struct  s_allocs *end;
 struct  s_allocs *next;
}                 t_allocs;

typedef struct    s_mem_handler
{
  t_allocs        *tiny;
  t_allocs        *small;
  t_allocs        *large;
}                 t_mem_handler;

t_mem_handler     *mem_handler(void);

#endif