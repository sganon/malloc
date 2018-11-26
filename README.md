# malloc
[![Build Status](https://travis-ci.org/sganon/malloc.svg?branch=master)](https://travis-ci.org/sganon/malloc)

Custom implementation of malloc, realloc and free functions of the lib C. This is a school project.

## Objectives

This project aims to create a shared library containing these three functions: 
```c
void    free(void *ptr)
void    *malloc(size_t size)
void    *realloc(void *ptr, size_t size)

void show_alloc_mem() // explained later
```
These functions should behave at least exactly as defined in `stdlib.h`, for more info on these functions see man pages: `malloc(3) realloc(3) free(3)`

## Technics considerations

This project use `mmap(2)` and `munmap(2)` to handle memory allocations. In order to avoid making a call to these functions every time pre-allocated memory spaces should be defined beforehand to store "tiny" and "small" allocations, this spaces will be called **zones**.

The size of a zone should be a multipule of `getpagesize()`

Each zone should contains at least 100 allocations

A function called `show_alloc_mem()` is implemented in the library to display zones state like so:

```
TINY : 0xA0000
0xA0020 - 0xA004A : 42 bytes
0xA006A - 0xA00BE : 84 bytes
SMALL : 0xAD000
0xAD020 - 0xADEAD : 3725 bytes
LARGE : 0xB0000
0xB0020 - 0xBBEEF : 48847 bytes
Total : 52698 bytes
```