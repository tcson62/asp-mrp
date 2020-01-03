%%%
%%% 

maxTime(21). 
time(1..21). 

%---------------------------------------
% domain
%---------------------------------------

% utils
boolean(true).
boolean(false).

% types
type(type("block")).

has(X, type(T2)) :- has(X, type(T1)), inherits(type(T1), type(T2)).

% variables
variable(variable(("on", X1, X2))) :- has(X1, type("block")), has(X2, type("block")).
variable(variable(("ontable", X1))) :- has(X1, type("block")).
variable(variable(("clear", X1))) :- has(X1, type("block")).
variable(variable("handempty")).
variable(variable(("holding", X1))) :- has(X1, type("block")).

contains(X, value(X, B)) :- variable(X), boolean(B).

% actions
action(action(("pickup", X1))) :- has(X1, type("block")).
precondition(action(("pickup", X1)), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("pickup", X1))).
precondition(action(("pickup", X1)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("pickup", X1))).
postcondition(action(("pickup", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), false)) :- action(action(("pickup", X1))).
postcondition(action(("pickup", X1)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("pickup", X1))).
postcondition(action(("pickup", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("pickup", X1))).

action(action(("putdown", X1))) :- has(X1, type("block")).
precondition(action(("putdown", X1)), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("putdown", X1))).
postcondition(action(("putdown", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("putdown", X1))).
postcondition(action(("putdown", X1)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("putdown", X1))).
postcondition(action(("putdown", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("putdown", X1))).

action(action(("stack", X1, X2))) :- has(X1, type("block")), has(X2, type("block")).
precondition(action(("stack", X1, X2)), variable(("clear", X2)), value(variable(("clear", X2)), true)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X2)), value(variable(("clear", X2)), false)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), true)) :- action(action(("stack", X1, X2))).

action(action(("unstack", X1, X2))) :- has(X1, type("block")), has(X2, type("block")).
precondition(action(("unstack", X1, X2)), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("unstack", X1, X2))).
precondition(action(("unstack", X1, X2)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), false)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), false)) :- action(action(("unstack", X1, X2))).

%---------------------------------------
% problem
%---------------------------------------

% objects
constant(constant("c")).
has(constant("c"), type("block")).

constant(constant("f")).
has(constant("f"), type("block")).

constant(constant("a")).
has(constant("a"), type("block")).

constant(constant("b")).
has(constant("b"), type("block")).

constant(constant("g")).
has(constant("g"), type("block")).

constant(constant("d")).
has(constant("d"), type("block")).

constant(constant("e")).
has(constant("e"), type("block")).

% initial state
initialState(variable(("clear", constant("e"))), value(variable(("clear", constant("e"))), true)).
initialState(variable(("ontable", constant("d"))), value(variable(("ontable", constant("d"))), true)).
initialState(variable(("on", constant("e"), constant("g"))), value(variable(("on", constant("e"), constant("g"))), true)).
initialState(variable(("on", constant("g"), constant("b"))), value(variable(("on", constant("g"), constant("b"))), true)).
initialState(variable(("on", constant("b"), constant("a"))), value(variable(("on", constant("b"), constant("a"))), true)).
initialState(variable(("on", constant("a"), constant("f"))), value(variable(("on", constant("a"), constant("f"))), true)).
initialState(variable(("on", constant("f"), constant("c"))), value(variable(("on", constant("f"), constant("c"))), true)).
initialState(variable(("on", constant("c"), constant("d"))), value(variable(("on", constant("c"), constant("d"))), true)).
initialState(variable("handempty"), value(variable("handempty"), true)).

initialState(X, value(X, false)) :- variable(X), not initialState(X, value(X, true)).

% goal
goal(variable(("on", constant("a"), constant("g"))), value(variable(("on", constant("a"), constant("g"))), true)).
goal(variable(("on", constant("g"), constant("d"))), value(variable(("on", constant("g"), constant("d"))), true)).
goal(variable(("on", constant("d"), constant("b"))), value(variable(("on", constant("d"), constant("b"))), true)).
goal(variable(("on", constant("b"), constant("c"))), value(variable(("on", constant("b"), constant("c"))), true)).
goal(variable(("on", constant("c"), constant("f"))), value(variable(("on", constant("c"), constant("f"))), true)).
goal(variable(("on", constant("f"), constant("e"))), value(variable(("on", constant("f"), constant("e"))), true)).

%%%%% 

action(action(noop)).

h(X, 1) :- initialState(X, value(X, true)).

h(X, T+1) :- time(T), action(action(A)), occurs(A, T), 
                   postcondition(action(A), effect(unconditional), X, value(X, true)).
                   
h(X, T+1) :- time(T), action(action(A)), occurs(A, T), 
                   h(X, T), 
                   not postcondition(action(A), effect(unconditional), X, value(X, false)).                  

executable(A, T):-  time(T), action(action(A)), 
                    #count {1,X : precondition(action(A), X, value(X, true)), not h(X, T)} == 0. 

:- time(T), action(action(A)), occurs(A, T), not executable(A, T). 

1{occurs(A, T) : action(action(A))} 1 :- time(T), maxTime(M), T<M. %%, goal(X, value(X, true)), not h(X, T).

:- time(T), maxTime(M), T<M, goal(X, value(X, true)), not h(X, T), occurs(noop, T).

occurs(noop, T+1) :- time(T),  maxTime(M), T<M, occurs(noop, T).

:- maxTime(N), goal(X, value(X, true)), not h(X, N).

%occurs(noop, 10). 
  
#heuristic occurs(noop, T) : time(T).     [10, true] 
  
%% occurs(noop, 10).  
  
#show occurs/2.  