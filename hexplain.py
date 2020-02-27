#script (python) 

import datetime
import string
import sys 
import clingo 
import os

global debug                   
global curr_as                 # current answer set 
global minLength            # minimal plan length 
global nameStr  
global extraAction 
robot_plan = []
actionList = [] 
actionListName = [] 
global human_plan
global changes_set

def actionsList(m) :
    curr_as = m.symbols(atoms=True)
    # if (debug) : print ("Current answer set ", curr_as)
    for x in range(0, len(curr_as)) :  
             if (curr_as[x].match("act", 1)) : 
                  if (debug) :   print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments, '----', len(curr_as[x].arguments))     
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
    global extraAction
    global human_plan
    global changes_set
    
    human_plan = []
    changes_set = []
    
    if (debug) : print ("Answer: {}".format(m))     
    curr_as = m.symbols(shown=True)
    
    for x in range(0, len(curr_as)) :  
        if (curr_as[x].match("occurs", 2)) : 
            (y) =  curr_as[x].arguments[0] 
            if (debug) :  print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments, ' === ', y, ' +++ ', y.arguments) 
            elem = clingo.Function("considered",[y.arguments[0]]) 
            if (debug) :  print (elem)
            if (not (elem in extraAction)) : extraAction.append(elem)
            human_plan.append(curr_as[x])
        
        if (curr_as[x].match("changes", 1)) : 
            changes_set.append(curr_as[x])
            
        if (curr_as[x].match("considered",1)) :
            if (debug) :  print (x, ':', curr_as[x], ' <<< ', curr_as[x].arguments)
            if (not (curr_as[x] in extraAction)) : extraAction.append(curr_as[x])
 

def computeMax(m):
    global curr_as
    global minLength

    curr_as = m.symbols(atoms=True)  
    if (debug) :  print ("List of all elements: {}".format(curr_as))        
    for x in range(0, len(curr_as)) : 
        if (curr_as[x].match("maxTime",1)) :
             if (debug) :  print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments)     
             minLength = curr_as[x].arguments[0]   
             
        if (curr_as[x].match("robot",1)) :
            if (curr_as[x].arguments[0].name == "occurs") :
                robot_plan.append( curr_as[x].arguments[0] )

def compare(robot_plan, human_plan):
    def extract_step(plan, step):
        for p in plan:
            if p.arguments[1].number == step:
                return p
        
    global minLength
    t = 1
    while (t < minLength.number+1):
        robot_step = extract_step(robot_plan, t)
        human_step = extract_step(human_plan, t)
        print("The first action that is different in robot plan and human plan: ")
        print("Robot: " + str(robot_step))
        print("Human: " + str(human_step))
        if str(robot_step) != str(human_step):
            return robot_step, human_step
            
        t = t + 1

def main(prg):
    global debug 
    global curr_as
    global minLength
    global nameStr  
    global extraAction
    
    changes_set = []
    
    debug = True
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
    # ret = prg.solve()
        #
    t = 1
    print ("Number of steps .... ", minLength.number)

    while (t < minLength.number+1):
        prg.ground([("step",[t])])
        step = clingo.Function("query", [t])
        print()
        print ("Step .... ", t, " >>> ", step)
        prg.ground([("step",[t])])
        prg.ground([("check",[t])])
        prg.assign_external(step, True)
        print()
        while (prg.solve(None, on_model=steps).satisfiable) :
            if (t == minLength.number) :
                print ("\n\nMinimal plan has the same length as robot plan. Done!\nThe following actions have been modified to match with the robot's specification.")
                t = t+1
                break
            else :
                print ("Need modification on changes set =============== ")
                print ("Robot plan: " + str(robot_plan))
                print ("Human plan: " + str(human_plan))
                robot_step, human_step = compare(robot_plan, human_plan)
                
                print ("Put action of robot step in considered")
                a = clingo.Function("action", [human_step.arguments[0]])
                change_act = clingo.Function("considered", [a])
                prg.assign_external(change_act, True)

                changes_set.append(a.arguments[0])
                
                # activate human action in verify_v2
                # for s in human_plan:
                #     a = clingo.Function("action", [s.arguments[0]])
                #     change_act = clingo.Function("considered", [a])
                #     prg.assign_external(change_act, True)
                #
                #     changes_set.append(a.arguments[0])
                
                # activate robot action in verify_v2
                # for s in robot_plan:
                #     a = clingo.Function("action", [s.arguments[0]])
                #     change_act = clingo.Function("considered", [a])
                #     prg.assign_external(change_act, True)
                #
                #     changes_set.append(a.arguments[0])
        else:
            prg.assign_external(step, False)
            t = t+1


    
    # print (extraAction)
    print (set(changes_set))

    end_time = datetime.datetime.now()

    elapsed = end_time - start_time

    print ("Elapsed time: ", elapsed)

    return

#end.
 
  