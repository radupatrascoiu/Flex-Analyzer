// Patrascoiu Ion - Radu, 336CC

#include <stdio.h>

int suma(int v[], int n)
{   
    int sum = 0, i;
    /* int s = 0; */
    for(i = 0; i < n; i++) /* actualizeaza suma */ sum += v[i];
    return sum;
}

void main()
{
    int a[] = {1, 2, 3}, i = 0, s;
    while (i < 3)
    {
        s = suma(a, 3);
        printf("%d \n", s);
        i++;
    }
}