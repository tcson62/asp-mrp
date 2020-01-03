#script(python)

import clingo 

global nameStr  
braveCons = [] 
cautiousCons = [] 

def brave_model(m) :
    global braveCons 
    braveCons =[] 
    print ("Current answer set type ", m.type) 
   
    curr_as = m.symbols(atoms=True)
    
    for x in curr_as : 
             braveCons.append(x)  


def cautious_model(m) :
    global cautiousCons 
    cautiousCons =[] 
    print ("Current answer set type ", m.type) 
   
    curr_as = m.symbols(atoms=True)
    
    for x in curr_as : 
            cautiousCons.append(x)  

def prg_model(m) : 
    global nameStr  

    listAdd = [] 
    nameStr = ':- '
    print ("Current answer set type ", m.type) 
    print ("Content: {}". format(m)) 
   
    curr_as = m.symbols(atoms=True)
    
    # the following can be rewritten to make it nicer 
    # this is pretty naive encoding 
    
    for x in curr_as :
         if (x not in cautiousCons) : listAdd.append(x) 
   
    print ("List of brave consequence not in the model : {}". format(listAdd)) 
    for id in range(0, len(listAdd)):  
         if (id < len(listAdd) - 1) :  nameStr = nameStr + format(listAdd[id]) + ','
         else :  nameStr = nameStr + format(listAdd[id]) + '.\n'


 
def main(prg):
    global nameStr

    nameStr = '' 
    prg.ground([("base",[])])

    # getting brave consequences 
    
    prg.configuration.solve.enum_mode = "brave" 
    
    prg.solve(None, on_model=brave_model) 

    print ("Brave consequences: {}". format(braveCons)) 

    # getting cautious consequences 

    prg.configuration.solve.enum_mode = "cautious" 
    
    prg.solve(None, on_model=cautious_model) 

    print ("Cautious consequences: {}". format(cautiousCons)) 

    # getting stable models  

    prg.configuration.solve.enum_mode = "auto" 

    prg.solve(None, on_model=prg_model) 
    
    print ("Add constraint: {}". format(nameStr)) 
    
    prg.add("names", [],  nameStr)

    prg.ground([("names",[])]) 
    
    # getting next models  
    
    prg.solve(None, on_model=prg_model) 
    
    # what you need to do is to create a loop and making sure that "names"
    # get different names in each iteration 
    
#end. 
