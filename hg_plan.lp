#include <incmode>.

#program base.
  
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


#program step(t).

time(t). 

h(X, t) :- action(action(A)), occurs(A, t-1), 
                   true(postcondition(action(A), effect(unconditional), X, value(X, true))).
                   
h(X, t) :- action(action(A)), occurs(A, t-1), 
                   h(X, t-1), 
                   not true(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

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


