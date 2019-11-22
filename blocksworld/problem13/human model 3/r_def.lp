

new_precondition(action(("pickup", X1)), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("pickup", X1))), 
      new_precondition(action(("pickup", Y)), variable(("clear", Y)), value(variable(("clear", Y)), true)), action(action(("pickup", Y))).

new_precondition(action(("pickup", X1)), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("pickup", X1))),
     new_precondition(action(("pickup", Y)), variable(("ontable", Y)), value(variable(("ontable", Y)), true)), action(action(("pickup", Y))). 

new_precondition(action(("pickup", X1)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("pickup", X1))),
     new_precondition(action(("pickup", Y)), variable("handempty"), value(variable("handempty"), true)), action(action(("pickup", Y))). 

new_postcondition(action(("pickup", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), false)) :- action(action(("pickup", X1))),
     new_postcondition(action(("pickup", Y)), effect(unconditional), variable(("ontable", Y)), value(variable(("ontable", Y)), false)), action(action(("pickup", Y))).

new_postcondition(action(("pickup", X1)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), false)) :- action(action(("pickup", X1))),
     new_postcondition(action(("pickup", Y)), effect(unconditional), variable(("clear", Y)), value(variable(("clear", Y)), false)) , action(action(("pickup", Y))).

new_postcondition(action(("pickup", X1)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("pickup", X1))),
     new_postcondition(action(("pickup", Y)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)), action(action(("pickup", Y))).

new_postcondition(action(("pickup", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("pickup", X1))),
     new_postcondition(action(("pickup", Y)), effect(unconditional), variable(("holding", Y)), value(variable(("holding", Y)), true)), action(action(("pickup", Y))).

new_precondition(action(("putdown", X1)), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("putdown", X1))),
     new_precondition(action(("putdown", Y)), variable(("holding", Y)), value(variable(("holding", Y)), true)), action(action(("putdown", Y))).

new_postcondition(action(("putdown", X1)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("putdown", X1))),
     new_postcondition(action(("putdown", Y)), effect(unconditional), variable(("holding", Y)), value(variable(("holding", Y)), false)), action(action(("putdown", Y))).
     
new_postcondition(action(("putdown", X1)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("putdown", X1))),
     new_postcondition(action(("putdown", Y)), effect(unconditional), variable(("clear", Y)), value(variable(("clear", Y)), true)), action(action(("putdown", Y))).

new_postcondition(action(("putdown", X1)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)) :- action(action(("putdown", X1))),
     new_postcondition(action(("putdown", Y)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)), action(action(("putdown", Y))).

new_postcondition(action(("putdown", X1)), effect(unconditional), variable(("ontable", X1)), value(variable(("ontable", X1)), true)) :- action(action(("putdown", X1))),
     new_postcondition(action(("putdown", Y)), effect(unconditional), variable(("ontable", Y)), value(variable(("ontable", Y)), true)), action(action(("putdown", Y))).

new_precondition(action(("stack", X1, X2)), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("stack", X1, X2))),
     new_precondition(action(("stack", Y, Z)), variable(("holding", Y)), value(variable(("holding", Y)), true)) , action(action(("stack", Y, Z))) .

new_precondition(action(("stack", X1, X2)), variable(("clear", X2)), value(variable(("clear", X2)), true)) :- action(action(("stack", X1, X2))),
     new_precondition(action(("stack", Y, Z)), variable(("clear", Z)), value(variable(("clear", Z)), true)) , action(action(("stack", Y, Z))) .

new_postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), false)) :- action(action(("stack", X1, X2))),
     new_postcondition(action(("stack", Y, Z)), effect(unconditional), variable(("holding", Y)), value(variable(("holding", Y)), false)) , action(action(("stack", Y, Z))) .

new_postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X2)), value(variable(("clear", X2)), false)) :- action(action(("stack", X1, X2))),
     new_postcondition(action(("stack", Y, Z)), effect(unconditional), variable(("clear", Z)), value(variable(("clear", Z)), false)) , action(action(("stack", Y, Z))) .

new_postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("stack", X1, X2))),
     new_postcondition(action(("stack", Y, Z)), effect(unconditional), variable(("clear", Y)), value(variable(("clear", Y)), true)) , action(action(("stack", Y, Z))) .

new_postcondition(action(("stack", X1, X2)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)) :- action(action(("stack", X1, X2))),
     new_postcondition(action(("stack", Y, Z)), effect(unconditional), variable("handempty"), value(variable("handempty"), true)) , action(action(("stack", Y, Z))) .

new_postcondition(action(("stack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), true)) :- action(action(("stack", X1, X2))),
     new_postcondition(action(("stack", Y, Z)), effect(unconditional), variable(("on", Y, Z)), value(variable(("on", Y, Z)), true)) , action(action(("stack", Y, Z))) .

new_precondition(action(("unstack", X1, X2)), variable(("on", X1, X2)), value(variable(("on", X1, X2)), true)) :- action(action(("unstack", X1, X2))),
     new_precondition(action(("unstack", Y, Z)), variable(("on", Y, Z)), value(variable(("on", Y, Z)), true)) , action(action(("unstack", Y, Z))) .

new_precondition(action(("unstack", X1, X2)), variable(("clear", X1)), value(variable(("clear", X1)), true)) :- action(action(("unstack", X1, X2))),
     new_precondition(action(("unstack", Y, Z)), variable(("clear", Y)), value(variable(("clear", Y)), true)) , action(action(("unstack", Y, Z))) .

new_precondition(action(("unstack", X1, X2)), variable("handempty"), value(variable("handempty"), true)) :- action(action(("unstack", X1, X2))),
     new_precondition(action(("unstack", Y, Z)), variable("handempty"), value(variable("handempty"), true)) , action(action(("unstack", Y, Z))) .

new_postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("holding", X1)), value(variable(("holding", X1)), true)) :- action(action(("unstack", X1, X2))),
     new_postcondition(action(("unstack", Y, Z)), effect(unconditional), variable(("holding", Y)), value(variable(("holding", Y)), true)) , action(action(("unstack", Y, Z))) .

new_postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("clear", X2)), value(variable(("clear", X2)), true)) :- action(action(("unstack", X1, X2))),
     new_postcondition(action(("unstack", Y, Z)), effect(unconditional), variable(("clear", Z)), value(variable(("clear", Z)), true)) , action(action(("unstack", Y, Z))) .

new_postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("clear", X1)), value(variable(("clear", X1)), false)) :- action(action(("unstack", X1, X2))),
     new_postcondition(action(("unstack", Y, Z)), effect(unconditional), variable(("clear", Y)), value(variable(("clear", Y)), false)) , action(action(("unstack", Y, Z))) .

new_postcondition(action(("unstack", X1, X2)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) :- action(action(("unstack", X1, X2))),
     new_postcondition(action(("unstack", Y, Z)), effect(unconditional), variable("handempty"), value(variable("handempty"), false)) , action(action(("unstack", Y, Z))) .

new_postcondition(action(("unstack", X1, X2)), effect(unconditional), variable(("on", X1, X2)), value(variable(("on", X1, X2)), false)) :- action(action(("unstack", X1, X2))),
     new_postcondition(action(("unstack", Y, Z)), effect(unconditional), variable(("on", Y, Z)), value(variable(("on", Y, Z)), false)) ,  action(action(("unstack", Y, Z))) .