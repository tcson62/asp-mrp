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
action(action(("pick-up", X1))) :- has(X1, type("block")).
precondition(action(("pick-up", X1)), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("pick-up", X1))).
precondition(action(("pick-up", X1)), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("pick-up", X1))).
precondition(action(("pick-up", X1)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("pick-up", X1))).
postcondition(action(("pick-up", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), false)) :- action(action(("pick-up", X1))).
postcondition(action(("pick-up", X1)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), false)) :- action(action(("pick-up", X1))).
postcondition(action(("pick-up", X1)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("pick-up", X1))).
postcondition(action(("pick-up", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("pick-up", X1))).

action(action(("put-down", X1))) :- has(X1, type("block")).
precondition(action(("put-down", X1)), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("put-down", X1))).
postcondition(action(("put-down", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("put-down", X1))).
postcondition(action(("put-down", X1)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("put-down", X1))).
postcondition(action(("put-down", X1)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)) :- action(action(("put-down", X1))).
postcondition(action(("put-down", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("put-down", X1))).

action(action(("stack", X1, X2))) :- has(X1, type("block")), has(X2, type("block")).
precondition(action(("stack", X1, X2)), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("stack", X1, X2))).
precondition(action(("stack", X1, X2)), variable(("clear", X2)), value(variable(("clear", X2)), true)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X2)), value(variable(("clear", X2)), false)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)) :- action(action(("stack", X1, X2))).
postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), true)) :- action(action(("stack", X1, X2))).

action(action(("unstack", X1, X2))) :- has(X1, type("block")), has(X2, type("block")).
precondition(action(("unstack", X1, X2)), variable(("on", X1, X2)), value(variable(("on", X1, X2)), true)) :- action(action(("unstack", X1, X2))).
precondition(action(("unstack", X1, X2)), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("unstack", X1, X2))).
precondition(action(("unstack", X1, X2)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("clear", X2)), value(variable(("clear", X2)), true)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), false)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("unstack", X1, X2))).
postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), false)) :- action(action(("unstack", X1, X2))).

%---------------------------------------
% problem
%---------------------------------------

% objects
constant(constant("d")).
has(constant("d"), type("block")).

constant(constant("b")).
has(constant("b"), type("block")).

constant(constant("a")).
has(constant("a"), type("block")).

constant(constant("c")).
has(constant("c"), type("block")).

constant(constant("z")).
has(constant("z"), type("block")).

constant(constant("x")).
has(constant("x"), type("block")).

constant(constant("y")).
has(constant("y"), type("block")).

constant(constant("p")).
has(constant("p"), type("block")).

constant(constant("q")).
has(constant("q"), type("block")).

% initial state
initialState(variable(("clear", constant("c"))), value(variable(("clear", constant("c"))), true)).
initialState(variable(("clear", constant("a"))), value(variable(("clear", constant("a"))), true)).
initialState(variable(("clear", constant("b"))), value(variable(("clear", constant("b"))), true)).
initialState(variable(("clear", constant("d"))), value(variable(("clear", constant("d"))), true)).
initialState(variable(("ontable", constant("c"))), value(variable(("ontable", constant("c"))), true)).
initialState(variable(("ontable", constant("a"))), value(variable(("ontable", constant("a"))), true)).
initialState(variable(("ontable", constant("b"))), value(variable(("ontable", constant("b"))), true)).
initialState(variable(("ontable", constant("d"))), value(variable(("ontable", constant("d"))), true)).
initialState(variable(("ontable", constant("z"))), value(variable(("ontable", constant("z"))), true)).
initialState(variable(("ontable", constant("x"))), value(variable(("ontable", constant("x"))), true)).
initialState(variable(("ontable", constant("y"))), value(variable(("ontable", constant("y"))), true)).
initialState(variable(("ontable", constant("p"))), value(variable(("ontable", constant("p"))), true)).
initialState(variable(("ontable", constant("q"))), value(variable(("ontable", constant("q"))), true)).
initialState(variable("handempty"), value(variable("handempty"), true)).

initialState(X, value(X, false)) :- variable(X), not initialState(X, value(X, true)).

% goal
goal(variable(("on", constant("d"), constant("c"))), value(variable(("on", constant("d"), constant("c"))), true)).
goal(variable(("on", constant("c"), constant("b"))), value(variable(("on", constant("c"), constant("b"))), true)).
goal(variable(("on", constant("b"), constant("a"))), value(variable(("on", constant("b"), constant("a"))), true)).
