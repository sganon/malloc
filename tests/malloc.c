/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   malloc.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/09/08 19:54:18 by sganon            #+#    #+#             */
/*   Updated: 2019/05/11 21:22:18 by simon            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./tests.h"

int main()
{
  char *str;
  char *str2;
  ft_putendl("Welcome to malloc tests");
  str = (char *)malloc(sizeof(char) * 424);
  if (str == NULL)
  {
    ft_putendl("Pointer shouldn\'t be null after calling malloc");
    return(1);
  }
  str2 = (char *)malloc(sizeof(char) * 42424242424);
  if (str2 == NULL)
  {
    ft_putendl("Pointer shouldn\'t be null after calling malloc");
    return(1);
  }
  show_alloc_mem();
  return(0);
}
