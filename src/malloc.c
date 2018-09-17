/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   malloc.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/08/05 17:35:09 by sganon            #+#    #+#             */
/*   Updated: 2018/09/17 21:32:19 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "malloc.h"

void    *malloc(size_t size)
{
    ft_putstr("Calling malloc with: "); ft_putnbr(size); ft_putchar('\n');
    show_alloc_mem();
    return mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE,
            -1, 0);
}