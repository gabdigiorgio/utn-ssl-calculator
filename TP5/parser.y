%code top {

#include <stdio.h>

#include <math.h> 

#include "scanner.h"

#include "calc.h"



dictionary *aux;

}



%code provides {

void yyerror(const char *);

}



%defines "parser.h"

%output "parser.c"



%union {

	double real;

	char *str;

}



%define parse.error verbose



%start calculadora



%token<str> VAR CTE FUN ID 

%token<real> CONSTANTE_REAL

%token SALIR

%token ASIGNACION_SUMA "+="

%token ASIGNACION_RESTA "-="

%token ASIGNACION_MULT "*="

%token ASIGNACION_DIV "/="

%right '=' ASIGNACION_SUMA ASIGNACION_RESTA ASIGNACION_MULT ASIGNACION_DIV

%left '+' '-'

%left '*' '/'

%precedence NEG // menos unario

%right '^'



%type<real> expresion 



%%



calculadora : 		   %empty

			 | calculadora linea					

                         ;

                         

linea :        		   '\n'				

                         | expresion '\n'   		   		{printf("\t Resultado: %.10g\n>", $1);}

                         | SALIR '\n'					{exit(0);}

                         | error '\n'

                         ;                   

                         

// gramática achatada //

expresion : 		   CONSTANTE_REAL				{$$ = $1;}

                         | ID						{ aux=getsym($<str>1); if (aux) { $$=(aux->value.var)    ;} else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | ID '=' expresion				{ aux=getsym($<str>1); if (aux) { if(aux->type == TYP_VAR) { $$=(aux->value.var)+=$3 ;} else { printf("Los operadores de asignación solo admiten una variable como operanado izquierdo \n"); YYERROR;} } else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | VAR ID					{ aux=getsym($<str>2); if (aux) { if(aux->type == TYP_VAR) { printf("Error, identificador ya declarado como variable \n"); YYERROR; } else if(aux->type == TYP_CTE) { printf("Error, identificador ya declarado como constante \n"); YYERROR; } else $$=(aux->value.var) ;} else { aux=putsym(strdup($2),TYP_VAR); $$=(aux->value.var)=0 ;} }

			 | CTE ID '=' expresion 			{ aux=getsym($<str>2); if (aux) { if(aux->type == TYP_VAR) { printf("Error, identificador ya declarado como variable \n"); YYERROR; } else if(aux->type == TYP_CTE) { printf("Error, identificador ya declarado como constante \n"); YYERROR; } else $$=(aux->value.var) ;} else { aux=putsym(strdup($2),TYP_CTE); $$=(aux->value.var)=$4 ;}}

			 | VAR ID '=' expresion 			{ aux=getsym($<str>2); if (aux) { if(aux->type == TYP_VAR) { printf("Error, identificador ya declarado como variable \n"); YYERROR; } else if(aux->type == TYP_CTE) { printf("Error, identificador ya declarado como constante \n"); YYERROR; } else $$=(aux->value.var) ;} else { aux=putsym(strdup($2),TYP_VAR); $$=(aux->value.var)=$4 ;} }

			 | ID "+=" expresion 				{ aux=getsym($<str>1); if (aux) { if(aux->type == TYP_VAR) { $$=(aux->value.var)+=$3 ;} else { printf("Los operadores de asignación solo admiten una variable como operanado izquierdo \n"); YYERROR;} } else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | ID "-=" expresion 				{ aux=getsym($<str>1); if (aux) { if(aux->type == TYP_VAR) { $$=(aux->value.var)-=$3 ;} else { printf("Los operadores de asignación solo admiten una variable como operanado izquierdo \n"); YYERROR;} } else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | ID "*=" expresion 				{ aux=getsym($<str>1); if (aux) { if(aux->type == TYP_VAR) { $$=(aux->value.var)*=$3 ;} else { printf("Los operadores de asignación solo admiten una variable como operanado izquierdo \n"); YYERROR;} } else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | ID "/=" expresion 				{ aux=getsym($<str>1); if (aux) { if(aux->type == TYP_VAR) { $$=(aux->value.var)/=$3 ;} else { printf("Los operadores de asignación solo admiten una variable como operanado izquierdo \n"); YYERROR;} } else { printf("ID %s no declarado\n",$1); YYERROR; } }

			 | expresion '+' expresion			{$$ = $1 + $3;}

                         | expresion '-' expresion			{$$ = $1 - $3;}

                         | expresion '*' expresion			{$$ = $1 * $3;}

                         | expresion '/' expresion			{$$ = $1 / $3;}

                         | '-' expresion %prec NEG			{$$ = -$2;}

                         | expresion '^' expresion			{$$ = pow($1, $3);}

                         | ID '(' expresion ')' 			{aux=getsym($<str>1); if (aux) { $$ = (*(aux->value.functptr))($3); } else { printf("La funcion %s no esta definida, \n",$1); $$=0; }}

                         | '(' expresion ')'				{$$ = $2;} 

                         ;	

                         

%%



/* Informar ocurrencia de un error */

void yyerror(const char *s){

    printf("Línea #%d: %s\n", yylineno, s);

    return;

}