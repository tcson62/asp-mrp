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

actionList = [] 
actionListName = [] 

def checkMinimal(m) :
    global curr_as 
    global debug 
    global curr_plan
    
    if (debug) : print ("Answer: {}".format(m))   
    
    curr_as = m.symbols(atoms=True)
    
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
 
# collect all actions from robot list 
 
def getActions(m) :
    answer = m.symbols(shown=True)
    print ("Current answer set ", answer) 
    for x in range(0, len(answer)) :  
             print (x, ':', answer[x], ' --- ', answer[x].arguments, '----', len(answer[x].arguments))     
             [(B)] = answer[x].arguments
             actionList.append(B)  


def createNameList() :
    for x in range(0, len(actionList)) :
          (y) = actionList[x] 
          if (len(y.arguments) > 0) : 
               addListName = clingo.Function("name",[actionList[x], y.arguments[0]]) 
               actionListName.append(addListName)
               print (addListName,".")

def main(prg):
    global debug 
    global curr_as
    global minLength 
    global curr_plan   
    
    debug = False 
    curr_plan = []
  
    start_time = datetime.datetime.now()  

   
    prg.ground([("actions",[])])

    prg.solve(None, on_model=getActions)

    createNameList() 
    
    # print (">>>>> ", actionListName) 

    prg.ground([("robot",[])]) 
    
    prg.solve(None, on_model=computeMax)

    print ("Minimal robot plan length: {}".format(minLength)) 

    prg.ground([("base",[])])

    str = " "  
    for id in actionListName : 
          print (id, ">>>", id.name) 
          #str = str + id.string + "\n"  
     
    print (str)  
    
    #prg.add_clause("names", actionListName)
    
    prg.ground([("names",[])])
        
    prg.solve(None, on_model=checkMinimal)
    
    return 
  
    
        
 
  
    
     
    end_time = datetime.datetime.now()
    
    elapsed = end_time - start_time
    
    print ("Elapsed time: ", elapsed)
    
    return 

#end.
 
  