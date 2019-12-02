#script (python) 

import datetime
import string
import sys 
import clingo 

global debug                   
global curr_as                 # current answer set 
global minLength            # minimal plan length 
global curr_plan              # current plan 
global needToContinue   # true indicates that the plan length in human problem is shorter than in robot problem  

def all_model(m) :
    global curr_as 
    global debug 
    global curr_plan
    
    if (debug) : print ("Answer: {}".format(m))   
    
    curr_as = m.symbols(shown=True)
    
    if (debug) :  print ("List of shown elements: {}".format(curr_as))   
    
    for x in range(0, len(curr_as)) : 
        if (curr_as[x].match("occurs",2)) :
             # print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
             curr_plan.append(curr_as[x])

    if (debug) :  print (curr_plan)


def computeMax(m):
    global curr_as
    global minLength
    curr_as = m.symbols(atoms=True)  
    if (debug) :  print ("List of all elements: {}".format(curr_as))        
    for x in range(0, len(curr_as)) : 
         if (curr_as[x].match("maxTime",1)) :
             print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
             minLength = curr_as[x].arguments[0]  

def checkNotMinimal(plan, maxTime):
    # if plan contains occurs(noop, x) for x < maxTime then it is not optimal 
    
    symbol = clingo.Function("occurs", ["noop",maxTime])
    
    if (symbol in plan) :
        if (debug) : print (">>>>>> True >>>>>")  
        return True 
    
    # print ("..................", symbol)
    # for x in range(0, len(plan)) : 
    #    if (plan[x].arguments[0].match("noop",0) and plan[x].arguments[1] < maxTime): 
    #         return True
    return False      

def addToProgram(plan, maxTime):
    # add to the current program all action occurrences of the 
    for x in range(0, len(plan)) : 
        if (not plan[x].arguments[0].match("noop",0)): 
             print ("human(",plan[x] ,').') 
 

def main(prg):
    global debug 
    global curr_as
    global minLength 
    global curr_plan
    global needToContinue  
    
    debug = True 
    curr_plan = []
    needToContinue = True 

    start_time = datetime.datetime.now()  
    
    prg.ground([("robot",[])]) 
    
    prg.solve(None, on_model=computeMax)

    print ("Minimal robot plan length: {}".format(minLength)) 

    prg.ground([("base",[])])
    
    if (debug) :  
        print(prg.configuration.solver.heuristic, "")
    
    prg.configuration.solver.heuristic="Domain"

    if (debug) :  
        print(prg.configuration.solver.heuristic, "")
        print ("Signature: {} ".format( prg.symbolic_atoms.signatures))
     
    # Need to do 
    #     get all the actions  
    #     check for noop 
    #     if noop does not exist then done 
    #     else change the programs  
    
    while needToContinue: 
        prg.solve(None, on_model=all_model)
        needToContinue = checkNotMinimal(curr_plan, minLength)

        if (needToContinue): 
             if (debug) : 
                  print ("Need to continue ===============")
                  print ("Current plan : {}".format(curr_plan))    
             addToProgram(curr_plan, minLength)
        break   
    
    
     
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  