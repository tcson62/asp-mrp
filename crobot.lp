#show. 
#show robot(precondition(A,B,C))    : precondition(A,B,C).
#show robot(postcondition(A,B,C,D)) : postcondition(A,B,C,D). 
#show robot(action(action(A))) : action(action(A)).
#show robot(initialState(X,V)) : initialState(X,V).
#show robot(variable(V)) : variable(V). 
#show robot(constant(V)) : constant(V). 
#show robot(goal(V, value(V,T))) : goal(V, value(V,T)). 
