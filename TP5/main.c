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



dictionary *sym_table;



struct init_fun

{

	char const *fname;

	double (*fun) (double);

};



struct init_const

{

  	char const *name;

  	double var;

};



struct init_fun const arith_fncts[] =

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



static void init_table(){

	int i;

    for (i = 0; arith_fncts[i].fname != 0; i++) {

	dictionary *ptr = putsym (arith_fncts[i].fname, TYP_FNCT);

	ptr->value.functptr = arith_fncts[i].fun;

    }

    

    for (i = 0; consts[i].name != 0; i++) {

      	dictionary *ptr = putsym (consts[i].name, TYP_CTE);

      	ptr->value.var = consts[i].var;

    }

    	

}



int main (int argc, char const* argv[])

{

	printf("> ");

	init_table();

  	return yyparse();

}