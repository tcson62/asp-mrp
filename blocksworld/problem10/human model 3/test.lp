#script(python)

import clingo 

maxTime = 21

symbol = clingo.Function("occurs",["noop",maxTime])

print (symbol) 

print (symbol.name)

print (symbol.arguments)



print (symbol.arguments[0].string == "noop")

print (symbol.arguments[0].name == "noop")

for id in range(maxTime - 1, 0, -1) : 
     print ("ID ... ", id) 

#end. 
