//Program name: "Assignment 6 - Execution Time".  This program demonstrates how to input and output floats with calcuations
//Copyright (C) 2021 Timothy Lee
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
//version 3 as published by the Free Software Foundation.
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// Author information
//  Author name: Timothy Lee
//  Author email: timothylee43@csu.fullerton.edu
//
// Program information
//  Program name: Summation
//  Programming languages X86 with one module in C++
//  Date program began 12/6/21
//  Date program completed 12/7/21
//
//Project information
//  Files: main.cpp, clock.asm, r.sh
//  Status: The program has been tested extensively with no detectable errors.
//
//Execution: ./calc.out
//
//References and credits
//  No references: this module is standard C++
//
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ===================================================================================================================================================

#include <stdio.h>
#include <stdint.h>                                         //To students: the second, third, and fourth header files are probably not needed.
#include <string.h>
#include <ctime>
#include <cstring>
#include <cstdlib>

extern "C" double summation();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  float power = -1.0;

  printf("%s","\nWelcome to this wonderful program written by Timothy Lee planning a career in microprocessor architecture.\n");
  power = summation();
  printf("%s%lf%s","The main function received this number ",power," and plans to keep it.\n");
  printf("%s", "Next zero will be returned to the OS.  Bye\n");
  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
