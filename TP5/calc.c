#include "calc.h"

#include <stdio.h>

#include <stdlib.h>

#include <string.h>



diccionario *ponerSimbolo (char const *sim_nombre, int sim_tipo)

{

  diccionario *ptr = (diccionario *) malloc (sizeof (diccionario));

  ptr->nombre = (char *) malloc (strlen (sim_nombre) + 1);

  strcpy (ptr->nombre,sim_nombre);

  ptr->tipo = sim_tipo;

  ptr->valor.nro = 0;

  ptr->sgte = (struct diccionario *)sim_tabla;

  sim_tabla = ptr;

  return ptr;

}



diccionario *obtenerSimbolo (char const *sim_nombre)

{

  diccionario *ptr;

  for (ptr = sim_tabla; ptr != (diccionario *) 0;

       ptr = (diccionario *)ptr->sgte)

    if (strcmp (ptr->nombre, sim_nombre) == 0)

      return ptr;

  return 0;

}
