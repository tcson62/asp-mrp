#include <incmode>.

#program base.
  
h(X, 1) :- initialState(X, value(X, true)).

#program step(t).

time(t). 

h(X, t) :- action(action(A)), occurs(A, t-1), 
                   postcondition(action(A), effect(unconditional), X, value(X, true)).
                   
h(X, t) :- action(action(A)), occurs(A, t-1), 
                   h(X, t-1), 
                   not postcondition(action(A), effect(unconditional), X, value(X, false)).                  

executable(A, t):-  action(action(A)), 
                    #count {1,X : precondition(action(A), X, value(X, true)), not h(X, t)} == 0. 

:- action(action(A)), occurs(A, t), not executable(A, t). 

1{occurs(A, t) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, t).

#program check(t).

:- query(t), goal(X, value(X, true)), not h(X, t).

#show occurs/2. 
#show e_action(A) : occurs(A,_). 
#show e_postcondition(action(A),B,C,D) : occurs(A,_),postcondition(action(A),B,C,D).
#show e_precondition(action(A),B,C) : occurs(A,_),precondition(action(A),B,C).
#show time/1. 

