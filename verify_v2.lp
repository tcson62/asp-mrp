#program base.

#external considered(A) : robot(action(A)). 
#external considered(A) : human(action(A)). 

h(X, 1) :- initialState(X, value(X, true)).

% condition for the robot plans 

add(postcondition(action(A), B, X, value(X, BoolV))):- 
	considered(A), 
	robot(postcondition(action(A), B, X, value(X, BoolV))).

add(precondition(action(A), X, value(X, BoolV))):- 
  considered(A), 
	robot(precondition(action(A), X, value(X, BoolV))).

add(postcondition(action(B), E, X, value(X, BoolV))):- 
  considered(A), 
  name(A,NA), name(B,NA), B != A,
	robot(postcondition(action(B), E, X, value(X, BoolV))).

add(precondition(action(B), X, value(X, BoolV))):- 
	considered(A), 
	name(A,NA), name(B,NA), B != A,
	robot(precondition(action(B), X, value(X, BoolV))).

true(postcondition(action(A), B, C, D)) :- 
  human(postcondition(action(A), B, C, D)),
  not remove(postcondition(action(A), B, C, D)), 
  not remove(action(A)).
  
true(precondition(action(A), C, D)) :- 
  human(precondition(action(A), C, D)),
  not remove(precondition(action(A), C, D)), 
  not remove(action(A)).
  
true(postcondition(action(A), B, C, D)) :- add(postcondition(action(A), B, C, D)). 

true(precondition(action(A), C, D)) :- add(precondition(action(A), C, D)). 

remove(action(A)) :-  considered(A), not robot(action(A)).

considered(A) :- add(action(A)).

{remove(action(A))} :- human(action(A)), not robot(action(A)).

#program step(t).

time(t). 

h(X, t) :- action(action(A)), occurs(A, t-1), 
    true(postcondition(action(A), effect(unconditional), X, value(X, true))).

h(X, t) :- action(action(A)), occurs(A, t-1), 
    h(X, t-1), 
    not true(postcondition(action(A), effect(unconditional), X, value(X, false))). 
    
executable(A, t):-  action(action(A)), 
    #count {1,X : true(precondition(action(A), X, value(X, true))), not h(X, t)} == 0. 

:- action(action(A)), occurs(A, t), not executable(A, t). 

1{occurs(A, t) : action(action(A))} 1 :- goal(X, value(X, true)), not h(X, t).

#program check(t).
#external query(t). 

:- query(t), goal(X, value(X, true)), not h(X, t).

#show.
#show occurs/2. 
% #show time/1.
% #show maxTime/1. 
#show considered/1. 
% #show changes(X) : true(X), not human(X).
% #show true/1.
% #show h/2.
% #show robot_action(A) : robot(action(A)).
#show remove/1.