#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "scanner.h"

int main()
{
    TOKEN token;
    do {
        char resultado[50];
        token = yylex();
        switch (token)
        {
            case VAR:
                strcpy(resultado, "Token: var");
            break;
            case CTE:
                strcpy(resultado, "Token: cte");
            break;
            case SALIR:
                strcpy(resultado, "Token: salir");
            break;
            case IDENTIFICADOR:
                strcpy(resultado, "Token: Identificador\tlexema: ");
                strcat(resultado, yytext);
            break;
            case CONSTANTE_REAL:
                strcpy(resultado, "Token: Constante real\tlexema: ");
                strcat(resultado, yytext);
            break;
            case OPERADOR_ASIGNACION:
                strcpy(resultado, "Token: ");
                strcat(resultado, yytext);
            break;
            case FDT:
                strcpy(resultado, "Token: Fin de Archivo");
            break;
            case CARACTER_SIMPLE:
            	strcpy(resultado, "Token: '");
                strcat(resultado, yytext);
                strcat(resultado, "'");
            break;
            case NL:
                strcpy(resultado, "Token: 'NL'");
            break;
        }
        
        puts(resultado);
        
    } while (token != FDT);

    return EXIT_SUCCESS;
}
