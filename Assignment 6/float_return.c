// Header file for printf function.
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

// Declaration for assembly manager function which returns largest integer in the array.
extern double float_return();

double float_return()
{
	const int SIZE = 100;
	char str[SIZE];
	double convert = 0.0;

	//run while invalid input
	while(convert==0.0) {
	   printf("Please enter the precision number and press enter: ");
	   //input string
	   fgets(str,SIZE,stdin);
	   //below is part of billial isfloat cpp, reused
	   bool result = true;
	   bool onepoint = false;
	   int start = 0;
	   if (str[0] == '+') start = 1;
	   unsigned long int k = start;
	   while (!(str[k] == '\0'||str[k] == '\n') && result )
	   {    if (str[k] == '.' && !onepoint)
	                onepoint = true;
	        else
	                result = result && isdigit(str[k]);
	        k++;
	      }
	   // above is part of billial isfloat cpp, reused
	   // result returned  as (result && onepoint)
	   //attempt to convert if only one decimal point in string
	   if (result && onepoint) {
	           convert = atof(str);
	   }
	   else{
	           printf("Invalid input encountered.  Please try again.\n");
	   }
	   //check if atof failed

	}
	printf("You entered %lf which will be returned to the caller function.\n",convert);
	return convert;
}
