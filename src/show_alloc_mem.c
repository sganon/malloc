/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   show_alloc_mem.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 19:21:36 by sganon            #+#    #+#             */
/*   Updated: 2018/09/17 21:36:38 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

# include "malloc.h"

void to_upper_str(char *str)
{
  int i;

  i = -1;
  while (str[++i])
  {
    str[i] = ft_toupper(str[i]);
  }
}

void display_allocs(t_allocs *allocs, char *name)
{
  char *base_addr;

  base_addr = ft_itoa_base((unsigned int)allocs, 16);
  to_upper_str(base_addr);
  ft_putstr(name);
  ft_putstr(" : 0x");
  ft_putendl(base_addr);
}

void  show_alloc_mem()
{
  void *tny;
  void *sml;
  void *lrg;

  tny = mem_handler()->tiny;
  sml = mem_handler()->small;
  lrg = mem_handler()->large;

  display_allocs(tny, "TINY");
  display_allocs(sml, "SMALL");
  display_allocs(lrg, "LARGE");
}