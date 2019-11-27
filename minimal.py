#script (python) 

import datetime
import string
import sys 
import clingo 

#from clingo import *

global debug  

def print_conf(conf, ident):
    for key in conf.keys:
        print ("====>",key)    
        #  if (key == "heuristic"): 
        subconf = getattr(conf, key)
        if isinstance(subconf, clingo.Configuration):
            label = key
            if (len(subconf) >= 0):
                label += "[0.." + str(len(subconf)) + "]"
            print ("{0}{1} - {2}".format(ident, label, getattr(conf, "__desc_" + key)))
            print_conf(subconf, "  " + ident + label + ".")
        else:
            print ("{0}{1}[={2}] - {3}".format(ident, key, subconf, getattr(conf, "__desc_" + key)))


def all_model(m) :
    print ("Answer: {}".format(m))   


def main(prg):
    global debug 
    
    debug = True 

    start_time = datetime.datetime.now()  
    
    prg.ground([("base",[])])
    
    prg.configuration.solver.heuristic="Domain"
    
    blub = prg.configuration.solver

    print_conf(prg.configuration, "")

    
   
    prg.solve(None, on_model=all_model)
    
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  