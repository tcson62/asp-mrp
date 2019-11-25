maxTime(N) :- N = #max {T : time(T)}. 
preTime(T) :- time(T), maxTime(N), T < N. 

h(X, 1) :- initialState(X, value(X, true)).

% condition for the robot plans 

contradictory(true, false).
contradictory(false, true).

%% action can be added if it occurs in the robot plan and is not in the set of actions in the human domain 

{add(action(A))} :- robot(occurs(A,_)), not human(action(A)).
action(action(A)) :- add(action(A)). 

%% false actions could be removed if necessary 

{remove(action(A))} :- human(action(A)), not robot(action(A)).

%% postconditions are added if they are necessary for the optimal plan 
  
{add(postcondition(action(A), B, X, value(X, BoolV)))} :- robot(postcondition(action(A), B, X, value(X, BoolV))), 
		robot(occurs(A,_)),  
		not human(postcondition(action(A), B, X, value(X, BoolV))).	

%% preconditions are added if they are necessary for the optimal plan 
		
{add(precondition(action(A), X, value(X, BoolV)))} :- robot(precondition(action(A), X, value(X, BoolV))), 
		robot(occurs(A,_)),
%		contradictory(BoolV, NBoolV),
		not human(precondition(action(A), X, value(X, BoolV))).	 

%% postconditions are removed if they are contradictory with what the robot believes 

{remove(postcondition(action(A), B, X, value(X, BoolV)))} :- 
		human(postcondition(action(A), B, X, value(X, BoolV))), 
		contradictory(BoolV, NBoolV),
		robot(postcondition(action(A), B, X, value(X, NBoolV))). 
		
%% preconditions are removed if they are contradictory with what the robot believes 

{remove(precondition(action(A), X, value(X, BoolV)))} :- 
		human(precondition(action(A), X, value(X, BoolV))), 
		contradictory(BoolV, NBoolV),
		robot(precondition(action(A), X, value(X, NBoolV))). 

%% actions 
		
true(action(A)) :- action(action(A)), not remove(action(A)).

true(postcondition(action(A), B, C, D)) :- add(postcondition(action(A), B, C, D)). 
true(postcondition(action(A), B, X, value(X, BoolV))) :- human(postcondition(action(A), B, X, value(X, BoolV))), 
		contradictory(BoolV, NBoolV),
		not add(postcondition(action(A), B, X, value(X, NBoolV))), 
		not remove(postcondition(action(A), B, X, value(X, BoolV))). 

true(precondition(action(A), C, D)) :- add(precondition(action(A), C, D)). 
true(precondition(action(A), X, value(X, BoolV))) :- human(precondition(action(A), X, value(X, BoolV))), 
		contradictory(BoolV, NBoolV),
		not add(precondition(action(A), X, value(X, NBoolV))), 
		not remove(precondition(action(A), X, value(X, BoolV))). 

%% effects of actions 

h(X, T+1)  :- preTime(T),  true(action(A)), occurs(A, T), 
                    true(postcondition(action(A), effect(unconditional), X, value(X, true))).
                  
h(X, T+1) :-  preTime(T),  true(action(A)), occurs(A, T), 
                    h(X, T), 
                    not true(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

not_executable(A, T):-  preTime(T),   true(action(A)), 
                    true(precondition(action(A), X, value(X, true))), not h(X, T).

not_executable(A, T, X):-  preTime(T),   true(action(A)), 
                    true(precondition(action(A), X, value(X, true))), not h(X, T).

:- preTime(T), action(action(A)), occurs(A, T), not_executable(A, T). 

:- maxTime(N), goal(X, value(X, true)), not h(X, N).

% :- not false. 

change(N) :- N1 = #count{1,(A,B,C,D) : add(postcondition(A, B, C, D))},
		    R1 = #count{1,(A,B,C,D) : remove(postcondition(A, B, C, D))}, 
                     N2 = #count{1,(A,B,C) : add(precondition(A, B, C))},
                     R2 = #count{1,(A,B,C) :  remove(precondition(A, B, C))},
                     N3 = #count{1,A : add(action(A))},
                     R3 = #count{1,A :  remove(action(A))},
                     N = N1 + N2 + N3 + R1 + R2 + R3.


                     
#minimize {N : change(N)}.                     

#show  robot(occurs(A,T)) : robot(occurs(A,T)).   
#show  add/1.   
#show  remove/1. 
#show  change/1.
#show  time/1. 
#show  maxTime/1. 
