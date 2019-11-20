#include <incmode>.

#program base.
  
h(X, 1) :- initialState(X, value(X, true)).

{new_action(A)} :- rh_action(A).

action(action(A)) :- new_action(A).

g_precondition(A,B,C):- new_precondition(A,B,C).
g_postcondition(A,B,C,D):- new_postcondition(A,B,C,D).

g_precondition(A,B,value(X,true)):- precondition(A,B,value(X,true)), not new_precondition(A,B,value(X,false)).
g_precondition(A,B,value(X,false)):- precondition(A,B,value(X,false)), not new_precondition(A,B,value(X,true)).

g_postcondition(A,B,C,value(X,true)):- postcondition(A,B,C,value(X,true)), not new_postcondition(A,B,C,value(X,false)).
g_postcondition(A,B,C,value(X,false)):- postcondition(A,B,C,value(X,false)), not new_postcondition(A,B,C,value(X,true)).

#program step(t).

time(t). 

h(X, t) :- action(action(A)), occurs(A, t-1), 
                   g_postcondition(action(A), effect(unconditional), X, value(X, true)).
                   
h(X, t) :- action(action(A)), occurs(A, t-1), 
                   h(X, t-1), 
                   not g_postcondition(action(A), effect(unconditional), X, value(X, false)).                  

executable(A, t):-  action(action(A)), 
                    #count {1,X : g_precondition(action(A), X, value(X, true)), not h(X, t)} == 0. 

:- action(action(A)), occurs(A, t), not executable(A, t). 

1{occurs(A, t) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, t).



#program check(t).

:- query(t), goal(X, value(X, true)), not h(X, t).

#show occurs/2. 
#show new_action/1.
#show p_action(A) : occurs(A,_). 
#show p_postcondition(action(A),B,C,D) : occurs(A,_),g_postcondition(action(A),B,C,D).
#show p_precondition(action(A),B,C) : occurs(A,_),g_precondition(action(A),B,C).
#show time/1. 
#show new_precondition/3.
#show new_postcondition/4.


