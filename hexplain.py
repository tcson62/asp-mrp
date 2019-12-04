#script (python) 

import datetime
import string
import sys 
import clingo 

global debug                   
global curr_as                 # current answer set 
global minLength            # minimal plan length 
global curr_plan              # current plan 
global nameStr  
global extraAction 
actionList = [] 
actionListName = [] 

def actionsList(m) :
    curr_as = m.symbols(atoms=True)
    if (debug) : print ("Current answer set ", curr_as) 
    for x in range(0, len(curr_as)) :  
             if (curr_as[x].match("act", 1)) : 
                  # print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments, '----', len(curr_as[x].arguments))     
                  [(B)] = curr_as[x].arguments
                  actionList.append(B)  

def createNameList() : 
    for x in range(0, len(actionList)) :
          (y) = actionList[x] 
          if (len(y.arguments) > 0) :                     
               addListName = clingo.Function("name",[actionList[x], y.arguments[0]]) 
               actionListName.append(addListName)
                 
def createNameStr() :
    global nameStr 
    for x in range(0, len(actionList)) :
          (y) = actionList[x] 
          if (len(y.arguments) > 0) :
               nameStr = nameStr + "name(" + format(y) +", "+format(y.arguments[0])+").\n"

def steps(m) :
    global curr_as 
    global debug 
    global curr_plan
    global extraAction
    
    if (debug) : print ("Answer: {}".format(m))     
    curr_as = m.symbols(shown=True)
    
    for x in range(0, len(curr_as)) :  
             if (curr_as[x].match("occurs", 2)) : 
                  (y) =  curr_as[x].arguments[0] 
                  print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments, ' === ', y, ' +++ ', y.arguments) 
                  elem = clingo.Function("considered",[y.arguments[0]]) 
                  if (not (elem in extraAction)) : extraAction.append(elem)
             
             if (curr_as[x].match("considered",1)) :
                  print (x, ':', curr_as[x], ' <<< ', curr_as[x].arguments)   
                  if (not (curr_as[x] in extraAction)) : extraAction.append(curr_as[x])
 


def getPlan(): 
    
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

def main(prg):
    global debug 
    global curr_as
    global minLength 
    global curr_plan
    global nameStr  
    global extraAction
    
    debug = False 
    curr_plan = []
    nameStr = ''
    extraAction = [] 
    
    start_time = datetime.datetime.now()  
    
    prg.ground([("actions",[])])
    
    prg.solve(None, on_model=actionsList)
    
    createNameStr() 
    
    if (debug) : print ("List of names: >>>> ", nameStr) 
    
    prg.add("names", [],  nameStr)
    
    prg.ground([("names",[])])
    
    prg.ground([("robot",[])]) 
    
    prg.solve(None, on_model=computeMax)

    print ("Minimal robot plan length: {}".format(minLength)) 

    prg.ground([("base",[])])
    
    t = 1 
    print ("Max Step .... ", minLength.number) 

    while (t < minLength.number+1): 
            prg.ground([("step",[t])])
            act = clingo.Function("query", [t]) 
            print ("Step .... ", t, " >>> ", act) 
            prg.ground([("step",[t])])        
            prg.ground([("check",[t])])            
            prg.assign_external(act, True)      
            ret = prg.solve(None, on_model=steps)  
            if (ret.satisfiable) : 
                 if (t == minLength.number) :  
                     print ("Minimal plan has the same length as robot plan. Done!\nThe following actions have been modified to match with the robot's specification.") 
                 else :                   
                     print ("Need modification  =============== ") 
                     
          
            prg.assign_external(act, False)  
            t = t+1 
    
     
    print (extraAction)	
             
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  