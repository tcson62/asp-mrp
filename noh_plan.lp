testTime(T) :- time(T), maxTime(N), T < N-1. 

h(X, 1) :- initialState(X, value(X, true)).

% {new_postcondition(A, B, C, D)} :- e_postcondition(A, B, C, D). 
% {new_precondition(A, B, D)} :- e_precondition(A, B, D). 
%
%old_postcondition(action(A), B, X, value(X, true)):-  postcondition(action(A), B, X, value(X, true)),
%		  not new_postcondition(action(A), effect(unconditional), X, value(X, false)),
%		  not e_postcondition(action(A), effect(unconditional), X, value(X, false)).
%
%old_postcondition(action(A), B, X, value(X, false)):-  postcondition(action(A), B, X, value(X, false)),
%		  not new_postcondition(action(A), effect(unconditional), X, value(X, true)),
%		  not e_postcondition(action(A), effect(unconditional), X, value(X, true)).
%
%old_precondition(action(A), X, value(X, true)):-  precondition(action(A), X, value(X, true)),
%		  not new_precondition(action(A),  X, value(X, false)),
%		  not e_precondition(action(A), X, value(X, false)).
%
%old_precondition(action(A), X, value(X, false)):-  precondition(action(A), X, value(X, false)),
%		  not new_precondition(action(A),  X, value(X, true)),
%		  not e_precondition(action(A), X, value(X, false)).


postcondition(A, B, C, D) :- new_postcondition(A, B, C, D). 
precondition(A, B, D) :- new_precondition(A, B, D). 
action(action(A)) :- new_action(A). 

h(X, T+1)  :- testTime(T),  action(action(A)), occurs(A, T), 
                   postcondition(action(A), effect(unconditional), X, value(X, true)).
               
h(X, T+1) :- testTime(T),  action(action(A)), occurs(A, T), 
                   h(X, T), 
                   not postcondition(action(A), effect(unconditional), X, value(X, false)).                  

not_executable(A, T):-  testTime(T),   action(action(A)), 
                    precondition(action(A), X, value(X, true)), not h(X, T).
                    
:- testTime(T), action(action(A)), occurs(A, T), not_executable(A, T). 

1{occurs(A, T) : action(action(A))} 1 :- testTime(T), goal(X, value(X, true)), not h(X, T).

:- maxTime(N), goal(X, value(X, true)), not h(X, N-1).

%change(N) :- N1 = #count{1,(A,B,C,D) : new_postcondition(A, B, C, D)}, 
%                     N2 = #count{1,(A,B,C) : new_precondition(A, B, C)},
%                     N = N1 + N2.
%                     
%#minimize {N : change(N)}.                     

%                     
%#show  robot_plan(A,T) : occurs(A,T). 
#show  new_postcondition/4. 
#show  new_precondition/3.
#show  new_action/1. 
%#show  time/1. 
%#show  maxTime/1. 