%%%
%%% 

h(X, 1) :- initialState(X, value(X, true)).

% condition for the robot plans 

contradictory(true, false).
contradictory(false, true).

%% action can be added if it occurs in the robot plan and is not in the set of actions in the human domain 

{add(action(A))} :- robot(occurs(A,_)), not human(action(A)).
action(action(A)) :- add(action(A)). 
action(action(noop)).

%% false actions could be removed if necessary 

{remove(action(A))} :- human(action(A)), not robot(action(A)).

%% postconditions are added if they are necessary for the optimal plan 
  
{add(postcondition(action(A), B, X, value(X, BoolV)))} :- robot(postcondition(action(A), B, X, value(X, BoolV))), 
		robot(occurs(A,_)),  
		not human(postcondition(action(A), B, X, value(X, BoolV))).	

%% preconditions are added if they are necessary for the optimal plan 
		
{add(precondition(action(A), X, value(X, BoolV)))} :- robot(precondition(action(A), X, value(X, BoolV))), 
		robot(occurs(A,_)),
		contradictory(BoolV, NBoolV),
		not human(precondition(action(A), X, value(X, NBoolV))).	 

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

h(X, T+1) :- time(T), action(action(A)), occurs(A, T), 
                   true(postcondition(action(A), effect(unconditional), X, value(X, true))).
                   
h(X, T+1) :- time(T), action(action(A)), occurs(A, T), 
                   h(X, T), 
                   not true(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

executable(A, T):-  time(T), action(action(A)), 
                    #count {1,X : true(precondition(action(A), X, value(X, true))), not h(X, T)} == 0. 

:- time(T), action(action(A)), occurs(A, T), not executable(A, T). 

1{occurs(A, T) : action(action(A))} 1 :- time(T), maxTime(M), T<M, goal(X, value(X, true)), not h(X, T).

:- time(T), maxTime(M), T<M, goal(X, value(X, true)), not h(X, T), occurs(noop, T).

occurs(noop, T+1) :- time(T),  maxTime(M), T<M, occurs(noop, T).

:- maxTime(N), goal(X, value(X, true)), not h(X, N).
  
#show occurs/2.  