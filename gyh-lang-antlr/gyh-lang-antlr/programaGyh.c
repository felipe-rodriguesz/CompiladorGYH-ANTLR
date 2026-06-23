#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	fatorial = 1;
	fatorial = fatorial*(parametro-1);
	parametro = parametro-1;
	printf("%d", fatorial);
}
