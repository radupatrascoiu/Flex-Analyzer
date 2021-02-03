// Patrascoiu Ion - Radu, 336CC

#include <stdio.h>

int show(int a) {
    if (a > 0) {
        a = -2;
    }

    printf("Ana are mere, pere si gutui.\n");

    return a;
}

float media(int a, int b) {
    int m;
    m = (a+b)/2.0;

    return m;
}

int main()
{
    int a, b, s;
    printf("a = ");
    scanf("%d", &a);

    printf("b = ");
    scanf("%d", &b);
    
    s = a + b;

    printf("Suma numerelor este: %d\n", s);
}

