/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   show_alloc_mem.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 19:21:36 by sganon            #+#    #+#             */
/*   Updated: 2018/09/18 13:09:47 by sganon           ###   ########.fr       */
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

void print_addr(void *ptr)
{
  char *addr;

  addr = ft_itoa_base((uintptr_t)ptr, 16);
  to_upper_str(addr);
  ft_putstr("0x");
  ft_putstr(addr);
}

void display_allocs(t_allocs *allocs, char *name)
{
  ft_putstr(name);
  ft_putstr(" : ");
  print_addr(allocs);
  ft_putchar('\n');
  while (allocs->next)
  {
    // print_addr(allocs->next);
  }
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