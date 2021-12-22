#include <iostream>

extern "C" double reciprocal_sum(double sum);

double reciprocal_sum(double sum)
{
  double reciprocal = 1.0 / sum;
  std::cout << "The reciprocal of the sum is " << reciprocal << " Have a nice day. \n";
  return reciprocal;
}
