
%top{
	#include <stdio.h>
	#include "tokens.h"	
}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
 
Letra													    [a-z]|[A-Z]
Digito														[0-9]
Letra_Digito												{Letra}|{Digito}												
Numero														{Digito}|{Digito}{Numero} 
Operador_Suma_Resta                                         (\+|\-)
Operador_Asignacion 									    (\+=|\-=|\*=|[/]=) 
Otros														[[:punct:]]{-}[();,]
Espacio														[ \t\r\v\f]

%% 
/n                                                          return NL;                                                  
./calc 													    return PROGRAMA;
salir														return FIN_PROG;
var|cte                                                     return PALABRA_RESERVADA;
{Letra}{Letra_Digito}*										return IDENTIFICADOR;
{Numero}|{Numero}\.{Numero}							        return CONSTANTE_REAL;                                    
{Operador_Asignacion}|{Operador_Suma_Resta}|[)*^/(]         return CARACTER_PUNTUACION;								  
sin|cos|tan |asin |acos |atan |sqrt |log                    return IDENTIFICADOR  

{Otros}+													printf("Error léxico: cadena inválida: %s\n",yytext);
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		printf("Error léxico: identificador inválido: %s\n",yytext);  
{Digito}+{Letra}+{Letra_Digito}*							printf("Error léxico: numero inválido: %s\n",yytext);
{Espacio}+													;
												
%%







