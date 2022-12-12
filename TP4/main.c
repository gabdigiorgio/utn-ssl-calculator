#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include "parser.h"



int main(void){

    switch( yyparse() ) {

        case 0:

            printf("Compilación terminada con éxito\n");

            break;

        case 1:

            printf("Errores de compilación\n");

            break;

        case 2:

            printf("Memoria insuficiente\n");

            break;

    }

    return EXIT_SUCCESS;

}