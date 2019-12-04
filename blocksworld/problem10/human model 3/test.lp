#script(python)

import clingo 

actionList = [] 
actionListName = [] 

global nameStr  

def all_model(m) :

    curr_as = m.symbols(shown=True)
    # print ("Current answer set ", curr_as) 
    for x in range(0, len(curr_as)) :  
             print (x, ':', curr_as[x], ' --- ', curr_as[x].arguments, '----', len(curr_as[x].arguments))     
             [(B)] = curr_as[x].arguments
             actionList.append(B)  

def second(m) :

    curr_as = m.symbols(atoms=True)
    print ("Current answer set  second", curr_as) 
     


def addSameName() :
    for x in range(0, len(actionList)) :
          (y) = actionList[x] 
          if (len(y.arguments) > 0) : 
               print ("Looking for similar action ", y.arguments[0])  
               for z in range(x, len(actionList)) :
                    (t) = actionList[z]  
                    print (x, z,  '---', y, ':', y.arguments, '+++', t.arguments)
                    if (len(t.arguments) > 0) : 
                          if (y.arguments[0] == t.arguments[0]) : 
                               addSimilar = clingo.Function("same",[actionList[x], actionList[z]]) 
                               print ("added : ",  addSimilar)

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
  

def main(prg):
    global nameStr

    nameStr = '' 
    prg.ground([("base",[])])
    prg.ground([("actions",[])])
    print ("Signature: {} ".format( prg.symbolic_atoms.signatures))
    prg.solve(None, on_model=all_model) 

    # print ("Actions: >>>>>>>>>  ", actionList) 

    createNameList()       
     
    createNameStr()               
    
    print ( nameStr )
    
    prg.add("names", [],  nameStr)
    
    prg.ground([("names",[])])
        
    prg.solve(None, on_model=second) 


#end. 
