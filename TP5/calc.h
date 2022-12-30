#ifndef CALC_H

#define CALC_H



#define TIPO_VAR 0

#define TIPO_CTE 1

#define TIPO_FUN 2



typedef double (*fun) (double);



typedef struct diccionario {

	char *nombre;

	int tipo; //Tres tipos: TIPO_VAR, TIPO_CTE, TIPO_FUN

	union {

		double nro;

		fun functptr; //Puntero a funcion

	} valor;

	struct diccionario *sgte;

} diccionario;



extern diccionario *sim_tabla;

diccionario *ponerSimbolo (char const *, int);

diccionario *obtenerSimbolo (char const *);



#endif
