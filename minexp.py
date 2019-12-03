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
    
    curr_plan = []
    
    for x in range(0, len(curr_as)) : 
        if (curr_as[x].match("occurs",2)) :
             print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
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

def addToProgram(prg, plan, maxTime):
    # add to the current program all action occurrences of the 
    for x in range(0, len(plan)) : 
        if (not plan[x].arguments[0].match("noop",0)): 
             print (">>> added >>>> ", plan[x]) 
             prg.assign_external(plan[x], True) 
 

def main(prg):
    global debug 
    global curr_as
    global minLength 
    global curr_plan
    global needToContinue  
    
    debug = False 
    curr_plan = []
    needToContinue = True 

    start_time = datetime.datetime.now()  
    
    prg.ground([("robot",[])]) 
    
    prg.solve(None, on_model=computeMax)

    print ("Minimal robot plan length: {}".format(minLength)) 

    prg.ground([("base",[])])
    
    # if (debug) :  print(prg.configuration.solver.heuristic, "")
    
    # prg.configuration.solver.heuristic="Domain"

    # if (debug) :  
    #    print(prg.configuration.solver.heuristic, "")
    #    print ("Signature: {} ".format( prg.symbolic_atoms.signatures))
     
    # Need to do 
    #     get all the actions  
    #     check for noop 
    #     if noop does not exist then done 
    #     else change the programs  
    
    # while needToContinue: 
    #    prg.solve(None, on_model=all_model)
    #    needToContinue = checkNotMinimal(curr_plan, minLength)

    #    if (needToContinue): 
    #         if (debug) : 
    #              print ("Need to continue ===============")
    #              print ("Current plan : {}".format(curr_plan))    
    #         addToProgram(curr_plan, minLength)
    #    break   
    
    
        
    while True :  
          symbol = clingo.Function("start", [minLength.number-1])
          print ("Starting ... ", symbol) 
          prg.assign_external(symbol, True) 
          ret = prg.solve(None, on_model=all_model) 
          # print ("Result [", id, "]:", ret)
          if (ret.unsatisfiable) :
                 # print ("No plan  ===============  ", id)
                 print ("No plan  ===============  of length < ", minLength)
                 break 
          if (not ret.unsatisfiable) :
                 # print ("Need modification  =============== ", id)
                 print ("Need modification  =============== ")
                 # addToProgram(prg, curr_plan, minLength)
                 for x in range(0, len(curr_plan)) : 
                      print (x, ':', curr_plan[x], ' --- ', curr_plan[x].arguments)     
                      if (curr_plan[x].arguments[0].string ==  "noop") :
                             print ("<<< added now >>>>", curr_plan[x].arguments)     
                      else :
                             act = clingo.Function("human_occurs", [curr_plan[x].arguments[0]]) 
                             print (">>> checked >>>> ", act)
                             prg.assign_external(act, True)   

          prg.assign_external(symbol, False) 


#    for id in range(1, minLength.number) :   
#           symbol = clingo.Function("start", [id])
#           print ("Starting ... ", symbol) 
#           prg.assign_external(symbol, True) 
#           ret = prg.solve(None, on_model=all_model) 
#           print ("Result [", id, "]:", ret)
#           if (ret.unsatisfiable) :
#                  print ("No plan  ===============  ", id)
#                  # print ("No plan  ===============  ")
#                   
#           if (not ret.unsatisfiable) :
#                  print ("Need modification  =============== ", id)
#                  
#                  for x in range(0, len(curr_plan)) : 
#                       print (x, ':', curr_plan[x], ' --- ', curr_plan[x].arguments)     
#                       if (curr_plan[x].arguments[0].string ==  "noop") :
#                              print ("<<< added now >>>>", curr_plan[x].arguments)     
#                       else :
#                              act = clingo.Function("human_occurs", [curr_plan[x].arguments[0]]) 
#                              print (">>> checked >>>> ", act)
#                              prg.assign_external(act, True)   
# 
#           prg.assign_external(symbol, False) 

  
    
     
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  