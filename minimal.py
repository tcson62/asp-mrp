#script (python) 

import datetime
import string
import sys 
import clingo 

global debug                   
global curr_as            # current answer set 
global minLength       # minimal plan length 
global curr_plan         # current plan 

def all_model(m) :
    global curr_as 
    global debug 
    global curr_plan
    
    if (debug) : print ("Answer: {}".format(m))   
    
    curr_as = m.symbols(shown=True)
    
    if (debug) :  print ("List of shown elements: {}".format(curr_as))   
    
    for x in range(0, len(curr_as)) : 
        if (curr_as[x].match("occurs",2)) :
             print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
             curr_plan.append(curr_as[x])


def computeMax(m):
    global curr_as
    global minLength
    curr_as = m.symbols(atoms=True)  
    if (debug) :  print ("List of all elements: {}".format(curr_as))        
    for x in range(0, len(curr_as)) : 
         if (curr_as[x].match("maxTime",1)) :
             print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
             minLength = curr_as[x].arguments[0]  


def main(prg):
    global debug 
    global curr_as
    global minLength 
    global curr_plan 
    
    debug = True 
    curr_plan = []

    start_time = datetime.datetime.now()  
    
    prg.ground([("robot",[])]) 
    
    prg.solve(None, on_model=computeMax)

    print ("Minimal plan length: {}".format(minLength)) 

    prg.ground([("base",[])])
    
    if (debug) :  print(prg.configuration.solver.heuristic, "")
    
    prg.configuration.solver.heuristic="Domain"

    if (debug) :  print(prg.configuration.solver.heuristic, "")
     
    # Need to do 
    #     get all the actions  
    #     check for noop 
    #     if noop does not exist then done 
    #     else change the programs  
      
    prg.solve(None, on_model=all_model)
    
    if (debug) : print ("Signature: {} ".format( prg.symbolic_atoms.signatures))
    
    print ("Current plan :".format(curr_plan))    
     
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  