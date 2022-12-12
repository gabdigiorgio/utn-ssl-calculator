%code top{

#include <stdio.h>

#include <math.h> 

#include "scanner.h"

}

%code provides{

struct YYSTYPE {

	double real;

	char *str;

	};

void yyerror(const char *);

}

%defines "parser.h"

%output "parser.c"

%define api.value.type {struct YYSTYPE}

%define parse.error verbose

%start programa



%token VAR CTE CONSTANTE_REAL SALIR

%token ASIGNACION_SUMA "+="

%token ASIGNACION_RESTA "-="

%token ASIGNACION_MULT "*="

%token ASIGNACION_DIV "/="

%precedence '=' ASIGNACION_SUMA ASIGNACION_RESTA ASIGNACION_MULT ASIGNACION_DIV

%left '+' '-'

%left '*' '/'

%left ID

%precedence NEG // menos unario

%right '^'

%%



programa : 		   input SALIR

		         | input

			 ;



input : 		   %empty

			 | input line					

                         ;

                         

line :        		   '\n'				

			 | VAR ID 		   			{printf("Define ID como variable\n"); printf("\n");}

			 | VAR ID '=' expresion 			{printf("Define ID como variable con valor inicial\n"); printf("\n");}

			 | CTE ID '=' expresion 			{printf("Define ID como constante\n"); printf("\n");}	  

                         | expresion '\n'   		   		{printf("Expresión\n"); printf("\n");}

                         | error '\n'

                         ;                   

                         

// gramática achatada //

expresion : 		   CONSTANTE_REAL				{printf("Número\n");}

			 | ID '=' expresion				{printf("Asignación\n");}

			 | ID "+=" expresion 				{printf("Asignación con suma\n");}

			 | ID "-=" expresion 				{printf("Asignación con resta\n");}

			 | ID "*=" expresion 				{printf("Asignación con multiplicación\n");}

			 | ID "/=" expresion 				{printf("Asignación con división\n");}

			 | expresion '+' expresion			{printf("Suma\n");}

                         | expresion '-' expresion			{printf("Resta\n");}

                         | expresion '*' expresion			{printf("Multiplicación\n");}

                         | expresion '/' expresion			{printf("División\n");}

                         | '-' expresion %prec NEG			{printf("Cambio Signo\n");}

                         | expresion '^' expresion			{printf("Potenciación\n");}

                         | ID '(' expresion ')' 			{printf("Función\n");}

                         | '(' expresion ')'				{printf("Cierra paréntesis\n");}

                         | ID						{printf("ID\n");} 

                         ;	

                         

%%

/* Informar ocurrencia de un error */

void yyerror(const char *s){

    printf("Línea #%d: %s\n", yylineno, s);

    printf("\n");

    return;

}