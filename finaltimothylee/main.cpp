// Name: Timothy Lee
// Email: timothylee43@csu.fullerton.edu
// Final Exam Section Section 3
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <string.h>
#include <ctime>
#include <cstring>
#include <cstdlib>

extern "C" double clock_exec();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  float power = -1.0;

  printf("%s","\nThe Final exam by Timothy Lee\n");
  power = clock_exec();
  printf("%s%lf%s","The main function received this number ",power," and plans to keep it.\n");
  printf("%s", "Have a nice day.\n");
  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
