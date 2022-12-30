#include "calc.h"

#include <stdio.h>

#include <stdlib.h>

#include <string.h>



dictionary *putsym (char const *sym_name, int sym_type)

{

  dictionary *ptr = (dictionary *) malloc (sizeof (dictionary));

  ptr->name = (char *) malloc (strlen (sym_name) + 1);

  strcpy (ptr->name,sym_name);

  ptr->type = sym_type;

  ptr->value.var = 0;

  ptr->next = (struct dictionary *)sym_table;

  sym_table = ptr;

  return ptr;

}



dictionary *getsym (char const *sym_name)

{

  dictionary *ptr;

  for (ptr = sym_table; ptr != (dictionary *) 0;

       ptr = (dictionary *)ptr->next)

    if (strcmp (ptr->name, sym_name) == 0)

      return ptr;

  return 0;

}