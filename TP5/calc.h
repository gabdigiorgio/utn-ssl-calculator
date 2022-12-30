#ifndef CALC_H

#define CALC_H



#define TYP_VAR 0

#define TYP_CTE 1

#define TYP_FNCT 2



typedef double (*fun) (double);



typedef struct dictionary {

	char *name;

	int type; //Tres tipos: TYP_VAR, TYP_CTE, TYP_FNCT

	union {

		double var;

		fun functptr; //Puntero a funcion

	} value;

	struct dictionary *next;

} dictionary;



extern dictionary *sym_table;

dictionary *putsym (char const *, int);

dictionary *getsym (char const *);



#endif