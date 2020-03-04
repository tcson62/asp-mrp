
new_precondition(action(("load-truck", X1, X2, X3)), variable(("at", X2, X3)), value(variable(("at", X2, X3)), true)) :- action(action(("load-truck", X1, X2, X3))),
	new_precondition(action(("load-truck", Y1, Y2, Y3)), variable(("at", Y2, Y3)), value(variable(("at", Y2, Y3)), true)) , action(action(("load-truck", Y1, Y2, Y3))).

new_precondition(action(("load-truck", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("load-truck", X1, X2, X3))),
	new_precondition(action(("load-truck", Y1, Y2, Y3)), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("load-truck", Y1, Y2, Y3))).

new_postcondition(action(("load-truck", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), false)) :- action(action(("load-truck", X1, X2, X3))),
	new_postcondition(action(("load-truck", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), false)) , action(action(("load-truck", Y1, Y2, Y3))).

new_postcondition(action(("load-truck", X1, X2, X3)), effect(unconditional), variable(("in", X1, X2)), value(variable(("in", X1, X2)), true)) :- action(action(("load-truck", X1, X2, X3))),
	new_postcondition(action(("load-truck", Y1, Y2, Y3)), effect(unconditional), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), true)) , action(action(("load-truck", Y1, Y2, Y3))).

new_precondition(action(("load-airplane", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("load-airplane", X1, X2, X3))),
	new_precondition(action(("load-airplane", Y1, Y2, Y3)), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("load-airplane", Y1, Y2, Y3))).

new_precondition(action(("load-airplane", X1, X2, X3)), variable(("at", X2, X3)), value(variable(("at", X2, X3)), true)) :- action(action(("load-airplane", X1, X2, X3))),
	new_precondition(action(("load-airplane", Y1, Y2, Y3)), variable(("at", Y2, Y3)), value(variable(("at", Y2, Y3)), true)) , action(action(("load-airplane", Y1, Y2, Y3))).

new_postcondition(action(("load-airplane", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), false)) :- action(action(("load-airplane", X1, X2, X3))),
	new_postcondition(action(("load-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), false)) , action(action(("load-airplane", Y1, Y2, Y3))).

new_postcondition(action(("load-airplane", X1, X2, X3)), effect(unconditional), variable(("in", X1, X2)), value(variable(("in", X1, X2)), true)) :- action(action(("load-airplane", X1, X2, X3))),
	new_postcondition(action(("load-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), true)) , action(action(("load-airplane", Y1, Y2, Y3))).

new_precondition(action(("unload-truck", X1, X2, X3)), variable(("at", X2, X3)), value(variable(("at", X2, X3)), true)) :- action(action(("unload-truck", X1, X2, X3))),
	new_precondition(action(("unload-truck", Y1, Y2, Y3)), variable(("at", Y2, Y3)), value(variable(("at", Y2, Y3)), true)) , action(action(("unload-truck", Y1, Y2, Y3))).

new_precondition(action(("unload-truck", X1, X2, X3)), variable(("in", X1, X2)), value(variable(("in", X1, X2)), true)) :- action(action(("unload-truck", X1, X2, X3))),
	new_precondition(action(("unload-truck", Y1, Y2, Y3)), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), true)) , action(action(("unload-truck", Y1, Y2, Y3))).

new_postcondition(action(("unload-truck", X1, X2, X3)), effect(unconditional), variable(("in", X1, X2)), value(variable(("in", X1, X2)), false)) :- action(action(("unload-truck", X1, X2, X3))),
	new_postcondition(action(("unload-truck", Y1, Y2, Y3)), effect(unconditional), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), false)) , action(action(("unload-truck", Y1, Y2, Y3))).

new_postcondition(action(("unload-truck", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("unload-truck", X1, X2, X3))),
	new_postcondition(action(("unload-truck", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("unload-truck", Y1, Y2, Y3))).

new_precondition(action(("unload-airplane", X1, X2, X3)), variable(("in", X1, X2)), value(variable(("in", X1, X2)), true)) :- action(action(("unload-airplane", X1, X2, X3))),
	new_precondition(action(("unload-airplane", Y1, Y2, Y3)), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), true)) , action(action(("unload-airplane", Y1, Y2, Y3))).

new_precondition(action(("unload-airplane", X1, X2, X3)), variable(("at", X2, X3)), value(variable(("at", X2, X3)), true)) :- action(action(("unload-airplane", X1, X2, X3))),
	new_precondition(action(("unload-airplane", Y1, Y2, Y3)), variable(("at", Y2, Y3)), value(variable(("at", Y2, Y3)), true)) , action(action(("unload-airplane", Y1, Y2, Y3))).

new_postcondition(action(("unload-airplane", X1, X2, X3)), effect(unconditional), variable(("in", X1, X2)), value(variable(("in", X1, X2)), false)) :- action(action(("unload-airplane", X1, X2, X3))),
	new_postcondition(action(("unload-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("in", Y1, Y2)), value(variable(("in", Y1, Y2)), false)) , action(action(("unload-airplane", Y1, Y2, Y3))).

new_postcondition(action(("unload-airplane", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("unload-airplane", X1, X2, X3))),
	new_postcondition(action(("unload-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("unload-airplane", Y1, Y2, Y3))).

new_precondition(action(("drive-truck", X1, X2, X3, X4)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("drive-truck", X1, X2, X3, X4))),
	new_precondition(action(("drive-truck", Y1, Y2, Y3, Y4)), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), true)) , action(action(("drive-truck", Y1, Y2, Y3, Y4))).

new_precondition(action(("drive-truck", X1, X2, X3, X4)), variable(("in-city", X2, X4)), value(variable(("in-city", X2, X4)), true)) :- action(action(("drive-truck", X1, X2, X3, X4))),
	new_precondition(action(("drive-truck", Y1, Y2, Y3, Y4)), variable(("in-city", Y2, Y4)), value(variable(("in-city", Y2, Y4)), true)) , action(action(("drive-truck", Y1, Y2, Y3, Y4))).

new_precondition(action(("drive-truck", X1, X2, X3, X4)), variable(("in-city", X3, X4)), value(variable(("in-city", X3, X4)), true)):- action(action(("drive-truck", X1, X2, X3, X4))),
	new_precondition(action(("drive-truck", Y1, Y2, Y3, Y4)), variable(("in-city", Y3, Y4)), value(variable(("in-city", Y3, Y4)), true)) , action(action(("drive-truck", Y1, Y2, Y3, Y4))).

new_postcondition(action(("drive-truck", X1, X2, X3, X4)), effect(unconditional), variable(("at", X1, X2)), value(variable(("at", X1, X2)), false)) :- action(action(("drive-truck", X1, X2, X3, X4))),
	new_postcondition(action(("drive-truck", Y1, Y2, Y3, Y4)), effect(unconditional), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), false)) , action(action(("drive-truck", Y1, Y2, Y3, Y4))).

new_postcondition(action(("drive-truck", X1, X2, X3, X4)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("drive-truck", X1, X2, X3, X4))),
	new_postcondition(action(("drive-truck", Y1, Y2, Y3, Y4)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("drive-truck", Y1, Y2, Y3, Y4))).

new_precondition(action(("fly-airplane", X1, X2, X3)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("fly-airplane", X1, X2, X3))),
	new_precondition(action(("fly-airplane", Y1, Y2, Y3)), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), true)) , action(action(("fly-airplane", Y1, Y2, Y3))).

new_postcondition(action(("fly-airplane", X1, X2, X3)), effect(unconditional), variable(("at", X1, X2)), value(variable(("at", X1, X2)), false)) :- action(action(("fly-airplane", X1, X2, X3))),
	new_postcondition(action(("fly-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), false)) , action(action(("fly-airplane", Y1, Y2, Y3))).

new_postcondition(action(("fly-airplane", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("fly-airplane", X1, X2, X3))),
	new_postcondition(action(("fly-airplane", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("fly-airplane", Y1, Y2, Y3))).
