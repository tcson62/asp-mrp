% This program generates a sequence of (parameter: max) actions, of which (parameter: atLeastK - 1) first actions must be executable 
% The number 5 indicates that you want 5 sequence of actions. 
% #show non_executable(A, T)): action is not executable at time T
% #show non_executable_expl(A, T, X): action is not executable at time T because precondition X is not satisfied 
% #show not_goal(T): goal is not satisfied at time T. 
% #show not_goal_expl(X, max): goal is not satisfied at time max because X is not satisfied.  

%  clingo gen.lp robot.lp -c max=5 -c atLeastK=3 5 --out-atomf=%s. --out-if=\\n --quiet=1,2,2 

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

non_executable_expl(A, T, X) :- action(action(A)), occurs(A, T) , time(T),  
                            precondition(action(A), X, value(X, true)), not h(X, T).

:- time(T), action(action(A)), not executable(A, T), occurs(A, T), T < atLeastK. 

1{occurs(A, T)  : action(action(A))} 1 :- time(T), T < max.

not_goal(T) :- time(T), goal(X, value(X, true)), not h(X, T).

not_goal_expl(max, X) :- goal(X, value(X, true)), not h(X, max).


#show executable/2.
#show non_executable/2.
#show non_executable_expl/3.
#show not_goal/1. 
#show not_goal_expl/2. 
#show occurs/2. 
#show time/1. 

