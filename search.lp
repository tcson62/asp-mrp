%#include <incmode>.
%
%#program base.

time(1..length). 
  
h(X, 1) :- robot(initialState(X, value(X, true))).

%#program step(t).

%time(t). 

h(X, T+1) :- time(T), robot(action(action(A))), occurs(A, T), 
                   robot(postcondition(action(A), effect(unconditional), X, value(X, true))).
                   
h(X, T+1) :- time(T), robot(action(action(A))), occurs(A, T), 
                   h(X, T), 
                   not robot(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

robot(executable(A, T)):-  time(T), robot(action(action(A))), 
                    #count {1,X : robot(precondition(action(A), X, value(X, true))), not h(X, T)} == 0. 

:- time(T), robot(action(action(A))), occurs(A, T), not robot(executable(A, T)). 

1{occurs(A, T) : robot(action(action(A)))} 1 :- time(T), T < length, robot(goal(X, value(X, true))), not h(X, T).

:- robot(goal(X, value(X, true))), not h(X, length).

%#program check(t).

%:- query(t), goal(X, value(X, true)), not h(X, t).

#show occurs/2. 
%#show A : robot(executable(A,1)). 
%#show X : h(X, 1). 

