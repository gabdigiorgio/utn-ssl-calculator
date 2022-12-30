/* Grupo 12:

 * Integrantes:

 * - Gonzalo Schaller 175.693-0

 * - Agustin Neustadt 203.895-0

 * - Federico Tortolano 176.368-4

 * - Gabriel Di Giorgio 176.304-0

 */



#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include "calc.h"

#include <math.h>

#include "parser.h"



diccionario *sim_tabla;



struct init_fun

{

	char const *fnombre;

	double (*fun) (double);

};



struct init_const

{

  	char const *nombre;

  	double nro;

};



struct init_fun const funcs[] =

{

	{ "atan", atan },

	{ "cos",  cos  },

	{ "exp",  exp  },

	{ "ln",   log  },

	{ "sin",  sin  },

	{ "sqrt", sqrt },

	{ 0, 0 },

};



struct init_const const consts[] =

{

    	{ "pi",  M_PI   },

    	{ "e" ,  exp(1) },

    	{ 0, 0 }

};



static void init_tabla(){

	int i;

    for (i = 0; funcs[i].fnombre != 0; i++) {

	diccionario *ptr = ponerSimbolo (funcs[i].fnombre, TIPO_FUN);

	ptr->valor.functptr = funcs[i].fun;

    }

    

    for (i = 0; consts[i].nombre != 0; i++) {

      	diccionario *ptr = ponerSimbolo (consts[i].nombre, TIPO_CTE);

      	ptr->valor.nro = consts[i].nro;

    }

    	

}



int main (int argc, char const* argv[])

{

	printf("> ");

	init_tabla();

  	return yyparse();

}
