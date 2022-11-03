#include "part1-functions.h"

/*
 * Name: YOUR NAME HERE
 * Collaborators:
 * Please list anyone you collaborated with on this file here.
 */

/** divide
 *
 * Calculates the quotient of two numbers.
 *
 * @param "a" the divident
 * @param "b" the divisor
 * @return if b is a valid divisor, the quotient a/b
 *         0 otherwise
 */
int divide(int a, int b) {

    if (b == 0) {
        return b;
    } else {
        return a/b;
    }
}

/** toLowercase
 * 
 * Converts a string in-place to lowercase.
 * In-place means that the inputted string will be modified itself.
 * You will NOT create a new string.
 *
 * @param "str" a NULL-terminated string to be converted to lowercase
 */
void toLowercase(char *str) {
    for(char *p = str; *p; ++p)
        *p = *p > 0x40 && *p < 0x5b ? *p | 0x60 : *p;
}

/** gcd
 *
 * Calculates the greatest common divisor (GCD) of two integers.
 * The GCD of a and b is the largest integer that divides both a and b without any remainder.
 *
 * @param "a" the first of the two integers whose GCD is to be computed.
 * @param "b" the second of the two integers whose GCD is to be computed.
 * @return the greatest common divisor of a and b.
 */
int gcd(int a, int b) {
    UNUSED(a);
    UNUSED(b);
    return 0;
}

/** fib
 * 
 * Computes the nth integer in the Fibonnacci sequence.
 * The Fibonacci sequence begins with F(0) = 0, F(1) = 1.
 * Successive elements are the sum of the previous two elements in the sequence.
 *
 * @param "n" the index of the Fibonacci number to calculate.
 * @return the nth Fibonacci number.
 */
int fib(int n) {
    UNUSED(n);
    return 0;
}

/** countOnes
 * 
 * Counts the number of bits set in the 2's complement binary representation of an integer.
 *
 * @param "num" the number whose bits are to be counted.
 * @return the number of bits set in num.
 */
int countOnes(int num) {
    UNUSED(num);
    return 0;
}
