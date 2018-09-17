/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   malloc.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/08 19:54:18 by sganon            #+#    #+#             */
/*   Updated: 2018/09/17 21:09:26 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "malloc.h"

int main()
{
  char *str;
  ft_putendl("Welcome to malloc tests");
  str = (char *)malloc(sizeof(char) * 42);
  if (str == NULL)
  {
    ft_putendl("Pointer shouldn\'t be null after calling malloc");
    return(1);
  }
  // show_alloc_mem();
  return(0);
}