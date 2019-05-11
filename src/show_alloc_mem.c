/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   show_alloc_mem.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/17 19:21:36 by sganon            #+#    #+#             */
/*   Updated: 2019/05/11 21:03:16 by simon            ###   ########.fr       */
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
    allocs = allocs->next;
    print_addr((void *)allocs - sizeof(t_allocs)); 
    ft_putstr(" - ");
    print_addr(allocs->end);
    ft_putstr(" : ");
    ft_putnbr((char *)allocs->end - (char *)allocs - sizeof(t_allocs));
    ft_putchar('\n');
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
