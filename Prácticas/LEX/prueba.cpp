/* 
	Ejemplo ilustrativo del uso básico de funciones. Declaración
	y llamada de funciones tanto con parámetros como sin ellos.
*/ 
#include <stdlib.h>

int funcionuno (){ return 1; }
 
int funciondos ( int x ){ return x+1; }

int funciontres ( int aa , int ba , int c );

pair<int,char> funcioncuatro ( int a , char ba );

void main ( int arg , char argv  ){

	// Genera numero aleatorio entre 1 y 10
	int n = rand()%10 + 1;
	
	std::vector<int> v;
	// Añadimos número generado al final del vector
	v.push_back(n);

	return 0;
}
