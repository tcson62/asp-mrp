#show. 
#show human(precondition(A,B,C))    : precondition(A,B,C).
#show human(postcondition(A,B,C,D)) : postcondition(A,B,C,D). 
#show human(action(action(A))) : action(action(A)).
#show human(initialState(X,V)) : initialState(X,V).
#show human(variable(V)) : variable(V).  
#show human(constant(V)) : constant(V). 
#show human(goal(V, value(V,T))) : goal(V, value(V,T)). 
