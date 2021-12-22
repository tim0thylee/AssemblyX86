// #Author: Timothy Lee
// #Class: CSPC240-03
// #Email: timothylee43@csu.fullerton.edu
// #Program name: Midterm 2 - Harmonic
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <string.h>
#include <ctime>
#include <cstring>
#include <cstdlib>

extern "C" double harmonic();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  double reciprocal = -1.0;

  printf("%s","\nWelcome to Harmonic Sum by Timothy Lee\n");
  reciprocal = harmonic();
  printf("%s%lf%s","The main function received this number ",reciprocal," and plans to keep it.\n");
  printf("%s", "I hope you enjoyed this summation program.  A zero will be sent to the OS.  Bye\n");
  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
