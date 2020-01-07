%#include <incmode>.
%
%#program base.

time(1..length). 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% robot planning 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
hr(X, 1) :- robot(initialState(X, value(X, true))).

%#program step(t).

%time(t). 

hr(X, T+1) :- time(T), robot(action(action(A))), occurs(A, T), 
                   robot(postcondition(action(A), effect(unconditional), X, value(X, true))).
                   
hr(X, T+1) :- time(T), robot(action(action(A))), occurs(A, T), 
                   hr(X, T), 
                   not robot(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

robot(executable(A, T)):-  time(T), robot(action(action(A))), 
                    #count {1,X : robot(precondition(action(A), X, value(X, true))), not hr(X, T)} == 0. 

:- time(T), robot(action(action(A))), occurs(A, T), not robot(executable(A, T)). 

1{occurs(A, T) : robot(action(action(A)))} 1 :- time(T), T < length, robot(goal(X, value(X, true))), not hr(X, T).

:- robot(goal(X, value(X, true))), not hr(X, length).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% human planning 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hh(X, 1) :- human(initialState(X, value(X, true))), not remove(initial(X)).


%#program step(t).

%time(t). 

hh(X, T+1) :- time(T), occurs(A, T), 
                   human(postcondition(action(A), effect(unconditional), X, value(X, true))), 
                   not remove(postcondition(action(A), effect(unconditional), X, value(X, true))).

hh(X, T+1) :- time(T), human(action(action(A))), occurs(A, T), 
                   add(postcondition(action(A), effect(unconditional), X, value(X, true))). 
                   
hh(X, T+1) :- time(T), human(action(action(A))), occurs(A, T), 
                   hh(X, T), 
                   not human(postcondition(action(A), effect(unconditional), X, value(X, false))).                  

human(executable(A, T)):-  time(T), human(action(action(A))), 
                    #count {1,X : human(precondition(action(A), X, value(X, true))), not hh(X, T)} == 0. 

:- time(T), human(action(action(A))), occurs(A, T), not human(executable(A, T)). 

%% 1{occurs(A, T) : human(action(action(A)))} 1 :- time(T), T < length, human(goal(X, value(X, true))), not hh(X, T).

:- human(goal(X, value(X, true))), not hh(X, length).

#show occurs/2. 
%#show A : robot(executable(A,1)). 
%#show X : h(X, 1). 

%%% differences 

diff_plus(X, 1) :- hr(X, 1), not human(initialState(X, value(X, true))),  time(T), not hr(X, T). 
diff_mnus(X, 1) :- human(initialState(X, value(X, true))), not hr(X, 1), time(T), hr(X, T). 

add(initial(X))  :-  diff_plus(X).
remove(initial(X))  :-  diff_mnus(X).

add(action(A)) :- occurs(A, _), not human(action(action(A))). 

add(postcondition(action(A), effect(unconditional), X, value(X, true))) :- 
         occurs(A, _),  
         robot(postcondition(action(A), effect(unconditional), X, value(X, true))), 
         not human(postcondition(action(A), effect(unconditional), X, value(X, true))).
add(postcondition(action(A), effect(unconditional), X, value(X, false))) :- 
         occurs(A, _),  
         robot(postcondition(action(A), effect(unconditional), X, value(X, false))), 
         not human(postcondition(action(A), effect(unconditional), X, value(X, false))).
remove(postcondition(action(A), effect(unconditional), X, value(X, true))) :- 
         occurs(A, _),  
         robot(postcondition(action(A), effect(unconditional), X, value(X, false))), 
         human(postcondition(action(A), effect(unconditional), X, value(X, true))).
remove(postcondition(action(A), effect(unconditional), X, value(X, false))) :- 
         occurs(A, _),  
         robot(postcondition(action(A), effect(unconditional), X, value(X, true))), 
         human(postcondition(action(A), effect(unconditional), X, value(X, false))).

add(precondition(action(A), X, value(X, true))) :- 
         occurs(A, _),  
	robot(precondition(action(A), X, value(X, true))), 
	not human(precondition(action(A), X, value(X, true))).
add(precondition(action(A), X, value(X, false))) :- 
         occurs(A, _),  
	robot(precondition(action(A), X, value(X, false))), 
	not human(precondition(action(A), X, value(X, false))).
remove(precondition(action(A), X, value(X, true))) :- 
         occurs(A, _),  
	robot(precondition(action(A), X, value(X, false))), 
	human(precondition(action(A), X, value(X, true))).
remove(precondition(action(A), X, value(X, false))) :- 
         occurs(A, _),  
	robot(precondition(action(A), X, value(X, true))), 
	human(precondition(action(A), X, value(X, false))).
