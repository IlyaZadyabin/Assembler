from ctypes import *

#load the shared object file
adder = CDLL('./adder.so')

#Find sum of integers
res_int = adder.process(2, 2, 1)
#print ("Sum of 4 and 5 = " + str(res_int))