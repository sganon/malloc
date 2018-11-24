/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   malloc.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sganon <sganon@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/08/05 17:35:09 by sganon            #+#    #+#             */
/*   Updated: 2018/11/24 13:44:41 by sganon           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "malloc.h"

static void		*add_alloc(t_allocs *start, long size, long max)
{
	t_allocs	*ptr;
	t_allocs	*tmp;

	ptr = start;
	while (ptr->next)
	{
		if ((char *)ptr->next - (char *)ptr->end >= size)
			break ;
		ptr = ptr->next;
	}
	if ((char *)ptr->end + size > (char *)start + max)
		return (NULL);
	tmp = ptr->next;
	ptr->next = ptr->end;
	ptr->next->end = (t_allocs*)((char*)ptr->next + size);
	ptr->next->next = tmp;
	return (ptr->next + 1);
}

void    *malloc(size_t size)
{
  ft_putstr("Calling malloc with: "); ft_putnbr(size); ft_putchar('\n');
  show_alloc_mem();
    
  void	    *alloc;
	t_allocs	*lrg;

	size += sizeof(t_allocs);
	alloc = NULL;
	if (size <= TNY_ALLOC_MAX)
		alloc = add_alloc(mem_handler()->tiny,
				(long)size, getpagesize() * 100 * TNY_ALLOC_MAX);
	else if (size <= SML_ALLOC_MAX)
		alloc = add_alloc(mem_handler()->small,
				(long)size, getpagesize() * 100 * SML_ALLOC_MAX);
    ft_putendl("Alloc is a large one or no place has been found");
	if (!alloc)
	{
		lrg = mem_handler()->large;
		while (lrg->next)
			lrg = lrg->next;
		lrg->next = mmap(NULL, size,
				PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
		if (!lrg->next)
			return (NULL);
		lrg->next->end = (t_allocs *)((char *)lrg->next + size);
		lrg->next->next = NULL;
		return (lrg->next + 1);
	}
	return (alloc);
}