time(1..n). 

h(X, 1) :- initialState(X, value(X, true)).
nh(X, 1) :- initialState(X, value(X, false)).

h(X, T+1) :- time(T), action(action(A)), occurs(A, T),
                   postcondition(action(A), effect(unconditional), X, value(X, true)).
                   
h(X, T+1) :- time(T), action(action(A)), occurs(A, T), h(X, T), 
                   #count{X : postcondition(action(A), effect(unconditional), X, value(X, false))} == 0.
                   
nh(X, T+1) :- time(T), action(action(A)), occurs(A, T), nh(X, T), 
                   #count{X : postcondition(action(A), effect(unconditional), X, value(X, true))} == 0.

nh(X, T+1) :- time(T), action(action(A)), occurs(A, T), 
                   postcondition(action(A), effect(unconditional), X, value(X, false)).

%%% version no impossible 

%%%%h(X, T+1) :- time(T),  h(X, T), not some_occurs(T). 
%%%%                   
%%%%nh(X, T+1) :- time(T),   nh(X, T), not some_occurs(T).  
%%%%
%%%%invalid :- time(T), action(action(A)), occurs(A, T), precondition(action(A), X, value(X, true)),  nh(X, T), T < n.
%%%%
%%%%some_occurs(T) :- time(T), T < n, action(action(A)), occurs(A, T).
 
%%% version with impossible 

impossible(A, T):-  time(T), action(action(A)), precondition(action(A), X, value(X, true)),  nh(X, T), T < n.
impossible(A, T):-  time(T), action(action(A)), precondition(action(A), X, value(X, false)), h(X, T), T < n.

not_plan :- time(T), action(action(A)), occurs(A, T), impossible(A, T), T < n.

not_plan :- time(T), T < n, #count {A : occurs(A,T)} == 0. 
 
occurs(A, T) | noccurs(A, T) :- action(action(A)), time(T), T < n.

% invalid :- time(T), goal(X, value(X, true)), nh(X, T).

ngoals(N) :- N = #count{X : goal(X, value(X, true))}.

sat :- time(T), ngoals(N), K = #count{X : goal(X, value(X, true)), h(X, T), not nh(X, T)}, K==N.

not_good :- not sat.

occurs(A, T)   :- not_plan, action(action(A)), time(T), T < n.
noccurs(A, T) :- not_plan , action(action(A)), time(T), T < n.

occurs(A, T)   :- not_good, action(action(A)), time(T), T < n.
noccurs(A, T) :- not_good, action(action(A)), time(T), T < n.


#show occurs/2. 
% #show noccurs/2. 	
#show not_plan/0.
#show sat/0.
#show ngoals/1. 
% #show imp(A) : impossible(A,1).


%%imp(("putdown",constant("a"))) 
%%imp(("stack",constant("a"),constant("b"))) 
%%imp(("stack",constant("a"),constant("a"))) 
%%imp(("putdown",constant("b"))) 
%%imp(("stack",constant("b"),constant("b"))) 
%%imp(("stack",constant("b"),constant("a"))) 
%%imp(("pickup",constant("b"))) 
%%imp(("unstack",constant("b"),constant("b"))) 
%%imp(("unstack",constant("b"),constant("a"))) 
%%imp(("pickup",constant("a"))) 
%%imp(("unstack",constant("a"),constant("a"))) 
%%
%%occurs(("stack",constant("b"),constant("a")),1) 
%%occurs(("unstack",constant("a"),constant("b")),1) 
%%
%%invalid 