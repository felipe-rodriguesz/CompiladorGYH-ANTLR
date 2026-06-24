==== TEST: programa1.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if (parametro==0) {
	fatorial = 1;
}
	while (parametro>1) {
		fatorial = fatorial*(parametro-1);
		parametro = parametro-1;
	}
	printf("%d", fatorial);
}

==== TEST: programa2.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
Erro Semântico: Variável não declarada! -> num4
Erro Semântico: Variável não declarada! -> num4
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

	scanf("%d", &num1);
	scanf("%d", &num2);
	scanf("%d", &num3);
	if (num1>num2) {
	aux = 2+3-4+5-6*5-1;
	num2 = num1;
	num1 = aux;
}
	if (num1>num3Enum2<=num4Enum1>3OUnum2!=num4) {
	aux = num3;
	num3 = num1;
	num1 = aux;
}
	if (num2>num3) {
	aux = num3;
	num3 = num2;
	num2 = aux;
}
	printf("%d", num1);
	printf("%d", num2);
	printf("%d", num3);
}

==== TEST: programa3.gyh ====
line 4:0 missing 'DEC' at 'parametro'
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if (parametro==0) {
	fatorial = 1;
}
	while (parametro>1) {
		fatorial = fatorial*(parametro-1);
		parametro = parametro-1;
	}
	printf("%d", fatorial);
}

==== TEST: programa4.gyh ====
line 5:0 no viable alternative at input 'parametro:fatorial'
line 5:0 missing 'PROG' at 'fatorial'
#include<stdio.h>
#include<stdlib.h>

void main() { 

}

==== TEST: programa5.gyh ====
line 4:10 no viable alternative at input 'parametroINT'
line 5:9 mismatched input 'INT' expecting 'PROG'
==== TEST: programa6.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 10:9 no viable alternative at input 'fatorial=='
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
}

==== TEST: programa7.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
Erro Semântico: Incompatibilidade de tipos! Variável 'aux' é INT e não pode receber REAL.
line 20:45 no viable alternative at input 'SEnum1>num3Enum2<=num4Enum1>3num2'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

	scanf("%d", &num1);
	scanf("%d", &num2);
	scanf("%d", &num3);
	if (num1>num2) {
	aux = 2.1+3-4+5-6*5-1;
	num2 = num1;
	num1 = aux;
}
}

==== TEST: programa8.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
line 18:6 no viable alternative at input 'SEnum1>num2ENTAOINIaux:=2+3-(4+5)-6*(5-1num2'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

	scanf("%d", &num1);
	scanf("%d", &num2);
	scanf("%d", &num3);
}

==== TEST: programa9.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
line 16:20 no viable alternative at input 'SEnum1>num2ENTAOINIaux:=2+3-4+5)'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

	scanf("%d", &num1);
	scanf("%d", &num2);
	scanf("%d", &num3);
}

==== TEST: programa10.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
line 11:4 no viable alternative at input 'LERREAL'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

}

==== TEST: programa11.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if ((parametro==0)) {
	fatorial = 1;
}
	while ((parametro>1)) {
		fatorial = ((fatorial)*(parametro-1));
		parametro = (((parametro)-1));
	}
	printf("%d", fatorial);
}

==== TEST: programa12.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 15:1 no viable alternative at input 'ENQTO(parametro>1)INIfatorial:=((fatorial)*(parametro-1))parametro:=(((parametro)-1)FIM'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if ((parametro==0)) {
	fatorial = 1;
}
}

==== TEST: programa13.gyh ====
Adicionei um simbolo Symbol [name=num1, type=1, value=null]
Adicionei um simbolo Symbol [name=num2, type=1, value=null]
Adicionei um simbolo Symbol [name=num3, type=1, value=null]
Adicionei um simbolo Symbol [name=aux, type=1, value=null]
Erro Semântico: Variável não declarada! -> num4
Erro Semântico: Variável não declarada! -> num4
line 35:0 no viable alternative at input 'IMPRIMIRIMPRIMIR'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int aux;
	int num1;
	int num3;
	int num2;

	scanf("%d", &num1);
	scanf("%d", &num2);
	scanf("%d", &num3);
	if (num1>num2) {
	aux = 2+3-(4+5)-6*(5-1);
	num2 = num1;
	num1 = aux;
}
	if (num1>num3Enum2<=num4Enum1>3OUnum2!=num4) {
	aux = num3;
	num3 = num1;
	num1 = aux;
}
	if (num2>num3) {
	aux = num3;
	num3 = num2;
	num2 = aux;
}
	printf("%d", num1);
}

==== TEST: programa14.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 19:0 no viable alternative at input 'ENQTO(parametro>1)INIfatorial:=((fatorial)*(parametro-1))parametro:=(((parametro)-1))IMPRIMIRfatorialIMPRIMIR"Oi"'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if ((parametro==0)) {
	fatorial = 1;
}
}

==== TEST: programa15.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 15:30 no viable alternative at input 'ENQTO(parametro>1)INIfatorial:=((fatorial)*(parametro-1))parametro:=(((parametro)1'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if ((parametro==0)) {
	fatorial = 1;
}
}

==== TEST: programa16.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 15:29 no viable alternative at input 'ENQTO(parametro>1)INIfatorial:=((fatorial)*(parametro-1))parametro:=(((parametro)>'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
	if ((parametro==0)) {
	fatorial = 1;
}
}

==== TEST: programa17.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 11:20 no viable alternative at input 'SE(parametro==0)fatorial'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	fatorial = parametro;
}

==== TEST: programa18.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	if ((parametro==0)) {
	fatorial = 1;
} else {
	fatorial = parametro;
}
	while ((parametro>1)) {
		fatorial = (fatorial*(parametro-1));
		parametro = parametro-1;
	}
	printf("%d", fatorial);
}

==== TEST: programa19.gyh ====
Adicionei um simbolo Symbol [name=parametro, type=1, value=null]
Adicionei um simbolo Symbol [name=fatorial, type=1, value=null]
line 14:24 no viable alternative at input 'ENQTO(parametro>1)EOU'
#include<stdio.h>
#include<stdlib.h>

void main() { 
	int fatorial;
	int parametro;

	scanf("%d", &parametro);
	if ((parametro==0)) {
	fatorial = 1;
} else {
	fatorial = parametro;
}
}

