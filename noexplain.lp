maxTime(N+1) :- N = #max {T : time(T), occurs(_,T)}. 
preTime(T) :- time(T), maxTime(N), T < N. 

h(X, 1) :- initialState(X, value(X, true)).

% condition for the robot plans 


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

%%%%%%BAD ONE 
%%%%%%not_executable(A, T):-  preTime(T),   action(action(A)), 
%%%%%%                    new_precondition(action(A), X, value(X, false)), h(X, T).
%%%%%%
%%%%%%not_executable(A, T):-  preTime(T),   action(action(A)), 
%%%%%%                    old_precondition(action(A), X, value(X, false)), h(X, T).
                     
false :- preTime(T), action(action(A)), occurs(A, T), not_executable(A, T). 

%% 1{occurs(A, T) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, T).

false  :- maxTime(N), #count{1,X : goal(X, value(X, true)), not h(X, N)} > 0.

:- not false. 

change(N) :- N1 = #count{1,(A,B,C,D) : new_postcondition(A, B, C, D)}, 
                     N2 = #count{1,(A,B,C) : new_precondition(A, B, C)},
                     N = N1 + N2.
                     
#minimize {N : change(N)}.                     
%
%%                     
#show  robot_plan(A,T) : occurs(A,T). 
#show  new_postcondition/4. 
#show  new_precondition/3. 
#show  new_action/1.

%%#show  old_postcondition/4. 
%%%#show  old_precondition/3. 

#show change/1.

%#show holds(X) : h(X,N), maxTime(N). 
%#show holds(X) : h(X,3). 

%#show  time/1. 
%#show  maxTime/1. 
%#show false/1.
%#show nogood/2.