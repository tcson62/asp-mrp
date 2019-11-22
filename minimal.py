#script (python) 

import datetime
import string
import sys 

from clingo import *

global debug  

def all_model(m) :
    print (m)   


def main(prg):
    global debug 
    
    debug = True 

    start_time = datetime.datetime.now()  

    prg.ground([(["base"],[])])
   
    prg.solve(None, on_model=all_model)
    
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  