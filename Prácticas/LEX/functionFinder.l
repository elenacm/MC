%{
#include<stdio.h>
#include<string.h>
FILE *source,*destiny;
char sourceName[20];

void clean(char v[]);
void doxygen(char *text);

%}

palabra			[^= \n\t]+
espacio			[" "]+
p_i				\(
p_d				\)
declaracion		{palabra}{espacio}{palabra}
parametros		({espacio}?{declaracion}{espacio}?(,{espacio}?{declaracion}{espacio}?)*{espacio}?)
funcion			{declaracion}{espacio}?{p_i}{espacio}?{parametros}?{espacio}?{p_d}

/* Hasta aqui las declaraciones*/


/* Reglas */
%%
 
{funcion} { //La regla function engloba todas nuestras necesidades de restricción
	// Escribe la función encontrada en la salida de pantalla
	printf(yytext); 
	doxygen(yytext);
}

%%

/* Procedimientos de usuario */

int main(int argc,char *argv[]){
   
  if (argc == 2){
    yyin = fopen (argv[1], "rt");
    if (yyin == NULL){
      printf( "El fichero %s no se puede abrir \n", argv[1]);
      exit(-1);
    }
  }
  else
    yyin = stdin;

  destiny=fopen("funciones.txt","w");
  
  yylex();
  return(0);
}

void clean(char v[]){
	for(int i = 0; i < 25; i++)	v[i] = '\0';
}

void doxygen(char *text){

	//Captura y escribe el tipo de la función
	char tipo[25], nombre[25];
	int i = 0;

	//Mientras no se lea un espacio
	while(text[i] != ' '){
		tipo[i] = text[i];
		i++;
	}
	
	fprintf(destiny, "/*\n * @brief \"Añade una descripción\" \n ");
	fprintf(destiny, "* @return %s \n", tipo); //Tipo devuelto por la función
	
	//Saltamos los espacios y el nombre de la función hasta llegar al primer paréntesis
	while( text[i] != '(' )
		i++;
	
	i++; //Saltamos abrir el paréntesis
	
	while( text[i] != ')' ){
		//Saltamos espacios y comas entre parametros
		while( text[i] == ' ' || text[i] == ',')	
			i++;	

		//Si no es el fin de función
		if(text[i]!=')' ){
			int j = 0;
			char params[25];
			clean(params);

			//Capturamos un parámetro
			while( text[i] != ',' && text[i] != ')' ){
				params[j] = text[i];
				j++; i++;			
			}

			fprintf(destiny, " * @param  %s \n", params);
			clean(params);
		
		}		
	}
	
	fprintf(destiny, " */\n \n");
	fprintf(destiny, "%s \n \n",text);
	
	//Limpiamos el tipo para las siguientes funciones
	clean(tipo);
	clean(nombre);

}
