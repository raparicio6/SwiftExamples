#include "include/libfac.h"

long factorial(long n){
    return(n<=1)?1:n*factorial(n-1);
}
