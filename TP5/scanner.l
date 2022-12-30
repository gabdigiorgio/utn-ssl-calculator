%{

#include <stdio.h>

#include <strings.h>

#include "parser.h"

#include <math.h>

#include "calc.h"

char msg[120];

%}

%option outfile="scanner.c"

%option header-file="scanner.h"

%option noinput

%option nounput

%option yylineno



Letra									[a-z]|[A-Z]

Digito									[0-9]

Letra_Digito								{Letra}|{Digito}

Constante_Real								{Digito}+|{Digito}+\.{Digito}*												

Otros									[[:punct:]]{-}[()+\-*/^]



%%

\+=									return ASIGNACION_SUMA;     

\-=									return ASIGNACION_RESTA;      

\*=									return ASIGNACION_MULT;

\/=									return ASIGNACION_DIV;                           

[-|+|*|/|\n|=|(|)|^]                            			return *yytext;

salir									return SALIR;

var                                                   			return VAR;

cte 									return CTE;

{Constante_Real}							{yylval.real = atof(yytext); return CONSTANTE_REAL;}

{Letra}{Letra_Digito}*							{yylval.str = strdup(yytext); return ID;}



{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*              	{sprintf(msg, "Error léxico: identificador inválido: %s\n", yytext); yyerror(msg);}

{Constante_Real}({Constante_Real}|{Letra_Digito}|{Otros})+              {sprintf(msg, "Error léxico: REAL inválido: %s\n", yytext); yyerror(msg);}

{Otros}+                                                                {sprintf(msg, "Error léxico: cadena inválida: %s\n", yytext); yyerror(msg);}