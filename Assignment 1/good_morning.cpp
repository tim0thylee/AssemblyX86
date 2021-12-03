//****************************************************************************************************************************
//Program name: "Hello Program Assignment 1".  This program demonstrates how to input and output a string with embedded white  *
//space.  Copyright (C) 2021 Timothy Lee                                                                                *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// Author information
//  Author name: Timothy Lee
//  Author email: timothylee43@csu.fullerton.edu
//
// Program information
//  Program name: The Hello World Program
//  Programming languages X86 with one module in C++
//  Date program began 9/6/21
//  Date program completed 9/6/21
//
//Project information
//  Files: good_morning.cpp, hello.asm, run.sh
//  Status: The program has been tested extensively with no detectable errors.
//
//Translator information
//  Gnu compiler: g++ -c -m64 -Wall -l good-moring.lis -o good_morning.o good_morning.cpp
//  Gnu linker:   g++ -m64 -o good.out good_morning.o hello.o
//
//Execution: ./good.out
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

extern "C" char* hello_world();                            //The "C" is a directive to the C++ compiler to use standard "CCC" rules for parameter passing.

int main(int argc, char* argv[]){
  char * message;

  printf("%s","Welcome to this friendly ‘Hello’ program created by Timothy Lee\n");
  message = hello_world();
  printf("%s%s%s\n","Stay away from viruses ",message,".\nBye. The integer zero will now be returned to the operating system.");

  return 0;                                                 //'0' is the traditional code for 'no errors'.

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
