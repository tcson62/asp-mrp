%% --outf=0 -V0 --out-atomf=%s. --out-if=\\n --quiet=1,2,2

time(1..max). 

h(X, 1) :- initialState(X, value(X, true)).

h(X, T+1) :- action(action(A)), occurs(A, T), time(T), T < max, 
                   executable(A, T), 
                   postcondition(action(A), effect(unconditional), X, value(X, true)).
                   
h(X, T+1)  :- action(action(A)), occurs(A, T), time(T), T < max, 
                   h(X, T),
                   1 {non_executable(A, T);   
                   not postcondition(action(A), effect(unconditional), X, value(X, false))}.                  

executable(A, T) :-  action(action(A)), occurs(A, T) , time(T), T < max, 
                    #count {1,X : precondition(action(A), X, value(X, true)), not h(X, T)} == 0. 

non_executable(A, T) :- action(action(A)), occurs(A, T) , time(T), not executable(A, T) . 

1{occurs(A, T)  : action(action(A))} 1 :- time(T), T < max.

not_goal(T) :- time(T), goal(X, value(X, true)), not h(X, T).

#show executable/2.
#show non_executable/2.
#show not_goal/1. 
#show occurs/2. 
#show time/1. 

