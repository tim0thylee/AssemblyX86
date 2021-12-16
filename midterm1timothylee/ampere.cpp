// #Author: Timothy Lee
// #Class: CPSC240-03
// #Email: timothylee43@csu.fullerton.edu
// #Program name: Midterm 1 - Electricity

//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <string.h>

extern "C" char* ampere();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  char * name_title;

  printf("%s","\nWelcome to the Welcome to the High Voltage Software System by Timothy Lee\n");
  name_title = ampere();
  printf("%s%s%s","Goodbye ",name_title,". Have a nice party.\n");
  printf("%s","Zero is returned to the operating system.\n");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
