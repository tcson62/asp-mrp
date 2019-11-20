maxTime(N) :- N = #max {T : time(T)}. 
preTime(T) :- time(T), maxTime(N), T < N. 

h(X, 1) :- initialState(X, value(X, true)).

% condition for the robot plans 

%%%new_postcondition(A, B, C, D) :- e_postcondition(A, B, C, D). 
%%%new_precondition(A, B, C) :- e_precondition(A, B, C). 

 {new_action(A)} :- e_action(A).
 
 {new_postcondition(A, B, C, D)} :- e_postcondition(A, B, C, D). 
 {new_precondition(A, B, C)} :- e_precondition(A, B, C). 

action(action(A)) :- new_action(A).

new_postcondition(action(A), B, C, D) :-  new_action(A), e_postcondition(action(A), B, C, D).  
new_precondition(action(A), B, C) :-  new_action(A), e_precondition(action(A), B, C). 


% :-  new_action(A), e_postcondition(action(A), B, C, D), not new_postcondition(A, B, C, D).  
% :-  new_action(A), e_precondition(action(A), B, C), new_precondition(A, B, C) . 

% 
 {new_postcondition(A, B, C, D)} :- rh_postcondition(A, B, C, D). 
 {new_precondition(A, B, C)} :- rh_precondition(A, B, C). 

% condition for the human plans 
 
% {false_postcondition(A, B, C, D)} :- p_postcondition(A, B, C, D). 
% {false_precondition(A, B, C)} :- p_precondition(A, B, C). 
 

old_postcondition(action(A), B, X, value(X, true)):-  postcondition(action(A), B, X, value(X, true)),
		  not new_postcondition(action(A), effect(unconditional), X, value(X, false)),
		  not e_postcondition(action(A), effect(unconditional), X, value(X, false)).
%		  ,
%		  not false_postcondition(action(A), effect(unconditional), X, value(X, true)).

old_postcondition(action(A), B, X, value(X, false)):-  postcondition(action(A), B, X, value(X, false)),
		  not new_postcondition(action(A), effect(unconditional), X, value(X, true)),
		  not e_postcondition(action(A), effect(unconditional), X, value(X, true)).
%		  ,
%		  not false_postcondition(action(A), effect(unconditional), X, value(X, false)).

old_precondition(action(A), X, value(X, true)):-  precondition(action(A), X, value(X, true)),
		  not new_precondition(action(A),  X, value(X, false)),
		  not e_precondition(action(A), X, value(X, false)).
%		  ,
%		  not false_precondition(action(A),  X, value(X, false)).

old_precondition(action(A), X, value(X, false)):-  precondition(action(A), X, value(X, false)),
		  not new_precondition(action(A),  X, value(X, true)),
		  not e_precondition(action(A), X, value(X, true)).
%		  ,
%		  not false_precondition(action(A),  X, value(X, false)).

h(X, T+1)  :- preTime(T),  action(action(A)), occurs(A, T), 
                   new_postcondition(action(A), effect(unconditional), X, value(X, true)).

h(X, T+1)  :- preTime(T),  action(action(A)), occurs(A, T), 
                   old_postcondition(action(A), effect(unconditional), X, value(X, true)).
                  
h(X, T+1) :- preTime(T),  action(action(A)), occurs(A, T), 
                   h(X, T), 
                   not new_postcondition(action(A), effect(unconditional), X, value(X, false)), 
                   not old_postcondition(action(A), effect(unconditional), X, value(X, false)).                  

not_executable(A, T):-  preTime(T),   action(action(A)), 
                    new_precondition(action(A), X, value(X, true)), not h(X, T).

not_executable(A, T):-  preTime(T),   action(action(A)), 
                    old_precondition(action(A), X, value(X, true)), not h(X, T).

:- preTime(T), action(action(A)), occurs(A, T), not_executable(A, T). 

%% 1{occurs(A, T) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, T).

:- maxTime(N), goal(X, value(X, true)), not h(X, N).

                     
%%%%false(A,T) :- preTime(T), action(action(A)), occurs(A, T), not_executable(A, T). 
%%%%
%%%%%% 1{occurs(A, T) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, T).
%%%%
%%%%f(X) :- maxTime(N), goal(X, value(X, true)), not h(X, N).

% :- not false. 

change(N) :- N1 = #count{1,(A,B,C,D) : new_postcondition(A, B, C, D)}, 
                     N2 = #count{1,(A,B,C) : new_precondition(A, B, C)},
                     N3 = #count{1,A : new_action(A)},
                     N = N1 + N2 + N3.
                     
#minimize {N : change(N)}.                     

%                     
#show  robot_plan(A,T) : occurs(A,T). 
#show  new_postcondition/4. 
#show  new_precondition/3.  
#show  new_action/1. 
#show  change/1.
%#show  old_postcondition/4. 
%#show  old_precondition/3.  
%#show  time/1. 
%#show  maxTime/1. 
%#show t(X) : h(X,8).
%#show false/2.
%#show f/1.