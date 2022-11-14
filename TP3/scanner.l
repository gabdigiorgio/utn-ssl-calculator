%top{

	#include <stdio.h>

	#include "tokens.h"	

}



%option header-file="scanner.h"

%option outfile="scanner.c"

%option noinput

%option nounput

 

Letra									[a-z]|[A-Z]

Digito									[0-9]

Letra_Digito								{Letra}|{Digito}

Constante_Real								{Digito}+|{Digito}+\.{Digito}*												

Operador_Suma_Resta                                         		(\+|\-)

Operador_Mult_Div							(\*|\/)

Operador_Potencia							[\^]

Operador_Asignacion							(\+=|\-=|\*=|\/=)

Operador_Igualacion							(\=)

Caracter_Puntuacion							[();,]

Funcion									(sin|cos|tan|asin|acos|atan|sqrt|log) 

Otros									[[:punct:]]{-}[()+\-*/^]

Caracter_Simple								{Operador_Suma_Resta}|{Operador_Mult_Div}|{Operador_Potencia}|{Operador_Igualacion}|{Caracter_Puntuacion}



%% 

"\n"                                                          		return NL;                                                  

salir									return SALIR;

var                                                   			return VAR;

cte 									return CTE;

{Caracter_Simple}							return CARACTER_SIMPLE;

{Operador_Asignacion}							return OPERADOR_ASIGNACION;

{Constante_Real}							return CONSTANTE_REAL;

{Funcion}+								return IDENTIFICADOR;

{Letra}{Letra_Digito}*							return IDENTIFICADOR;             

{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*			printf("Error léxico: identificador inválido: %s\n",yytext);  

{Constante_Real}({Constante_Real}|{Letra_Digito}|{Otros})+		printf("Error léxico: numero inválido: %s\n",yytext);

{Otros}+                                                   		printf("Error léxico: cadena inválida: %s\n",yytext);												

%%
