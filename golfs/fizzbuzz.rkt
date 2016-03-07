#lang racket

; For http://codegolf.stackexchange.com/questions/58615/1-2-fizz-4-buzz

(for([x(range 1 101)])(define(m n)(=(modulo x n)0))(displayln(cond[(and(m 3)(m 5))"FizzBuzz"][(m 3)"Fizz"][(m 5)"Buzz"][x])))
