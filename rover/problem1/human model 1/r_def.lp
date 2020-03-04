
new_precondition(action(("navigate", X1, X2, X3)), variable(("can_traverse", X1, X2, X3)), value(variable(("can_traverse", X1, X2, X3)), true)) :- action(action(("navigate", X1, X2, X3))),
	new_precondition(action(("navigate", Y1, Y2, Y3)), variable(("can_traverse", Y1, Y2, Y3)), value(variable(("can_traverse", Y1, Y2, Y3)), true)) , action(action(("navigate", Y1, Y2, Y3))).
	
new_precondition(action(("navigate", X1, X2, X3)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("navigate", X1, X2, X3))),
	new_precondition(action(("navigate", Y1, Y2, Y3)), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("navigate", Y1, Y2, Y3))).

new_precondition(action(("navigate", X1, X2, X3)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("navigate", X1, X2, X3))),
	new_precondition(action(("navigate", Y1, Y2, Y3)), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), true)) , action(action(("navigate", Y1, Y2, Y3))).

new_precondition(action(("navigate", X1, X2, X3)), variable(("visible", X2, X3)), value(variable(("visible", X2, X3)), true)) :- action(action(("navigate", X1, X2, X3))),
	new_precondition(action(("navigate", Y1, Y2, Y3)), variable(("visible", Y2, Y3)), value(variable(("visible", Y2, Y3)), true)) , action(action(("navigate", Y1, Y2, Y3))).

new_postcondition(action(("navigate", X1, X2, X3)), effect(unconditional), variable(("at", X1, X2)), value(variable(("at", X1, X2)), false)) :- action(action(("navigate", X1, X2, X3))),
	new_postcondition(action(("navigate", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), false)) , action(action(("navigate", Y1, Y2, Y3))).

new_postcondition(action(("navigate", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("navigate", X1, X2, X3))),
	new_postcondition(action(("navigate", Y1, Y2, Y3)), effect(unconditional), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("navigate", Y1, Y2, Y3))).

new_precondition(action(("sample_soil", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_precondition(action(("sample_soil", Y1, Y2, Y3)), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_precondition(action(("sample_soil", X1, X2, X3)), variable(("at_soil_sample", X3)), value(variable(("at_soil_sample", X3)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_precondition(action(("sample_soil", Y1, Y2, Y3)), variable(("at_soil_sample", Y3)), value(variable(("at_soil_sample", Y3)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_precondition(action(("sample_soil", X1, X2, X3)), variable(("equipped_for_soil_analysis", X1)), value(variable(("equipped_for_soil_analysis", X1)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_precondition(action(("sample_soil", Y1, Y2, Y3)), variable(("equipped_for_soil_analysis", Y1)), value(variable(("equipped_for_soil_analysis", Y1)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_precondition(action(("sample_soil", X1, X2, X3)), variable(("store_of", X2, X1)), value(variable(("store_of", X2, X1)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_precondition(action(("sample_soil", Y1, Y2, Y3)), variable(("store_of", Y2, Y1)), value(variable(("store_of", Y2, Y1)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_precondition(action(("sample_soil", X1, X2, X3)), variable(("empty", X2)), value(variable(("empty", X2)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_precondition(action(("sample_soil", Y1, Y2, Y3)), variable(("empty", Y2)), value(variable(("empty", Y2)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("empty", X2)), value(variable(("empty", X2)), false)) :- action(action(("sample_soil", X1, X2, X3))),
	new_postcondition(action(("sample_soil", Y1, Y2, Y3)), effect(unconditional), variable(("empty", Y2)), value(variable(("empty", Y2)), false)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("full", X2)), value(variable(("full", X2)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_postcondition(action(("sample_soil", Y1, Y2, Y3)), effect(unconditional), variable(("full", Y2)), value(variable(("full", Y2)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("have_soil_analysis", X1, X3)), value(variable(("have_soil_analysis", X1, X3)), true)) :- action(action(("sample_soil", X1, X2, X3))),
	new_postcondition(action(("sample_soil", Y1, Y2, Y3)), effect(unconditional), variable(("have_soil_analysis", Y1, Y3)), value(variable(("have_soil_analysis", Y1, Y3)), true)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("at_soil_sample", X3)), value(variable(("at_soil_sample", X3)), false)) :- action(action(("sample_soil", X1, X2, X3))),
	new_postcondition(action(("sample_soil", Y1, Y2, Y3)), effect(unconditional), variable(("at_soil_sample", Y3)), value(variable(("at_soil_sample", Y3)), false)) , action(action(("sample_soil", Y1, Y2, Y3))).

new_precondition(action(("sample_rock", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_precondition(action(("sample_rock", Y1, Y2, Y3)), variable(("at", Y1, Y3)), value(variable(("at", Y1, Y3)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_precondition(action(("sample_rock", X1, X2, X3)), variable(("at_rock_sample", X3)), value(variable(("at_rock_sample", X3)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_precondition(action(("sample_rock", Y1, Y2, Y3)), variable(("at_rock_sample", Y3)), value(variable(("at_rock_sample", Y3)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_precondition(action(("sample_rock", X1, X2, X3)), variable(("equipped_for_rock_analysis", X1)), value(variable(("equipped_for_rock_analysis", X1)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_precondition(action(("sample_rock", Y1, Y2, Y3)), variable(("equipped_for_rock_analysis", Y1)), value(variable(("equipped_for_rock_analysis", Y1)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_precondition(action(("sample_rock", X1, X2, X3)), variable(("store_of", X2, X1)), value(variable(("store_of", X2, X1)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_precondition(action(("sample_rock", Y1, Y2, Y3)), variable(("store_of", Y2, Y1)), value(variable(("store_of", Y2, Y1)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_precondition(action(("sample_rock", X1, X2, X3)), variable(("empty", X2)), value(variable(("empty", X2)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_precondition(action(("sample_rock", Y1, Y2, Y3)), variable(("empty", Y2)), value(variable(("empty", Y2)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_postcondition(action(("sample_rock", X1, X2, X3)), effect(unconditional), variable(("empty", X2)), value(variable(("empty", X2)), false)) :- action(action(("sample_rock", X1, X2, X3))),
	new_postcondition(action(("sample_rock", Y1, Y2, Y3)), effect(unconditional), variable(("empty", Y2)), value(variable(("empty", Y2)), false)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_postcondition(action(("sample_rock", X1, X2, X3)), effect(unconditional), variable(("full", X2)), value(variable(("full", X2)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_postcondition(action(("sample_rock", Y1, Y2, Y3)), effect(unconditional), variable(("full", Y2)), value(variable(("full", Y2)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_postcondition(action(("sample_rock", X1, X2, X3)), effect(unconditional), variable(("have_rock_analysis", X1, X3)), value(variable(("have_rock_analysis", X1, X3)), true)) :- action(action(("sample_rock", X1, X2, X3))),
	new_postcondition(action(("sample_rock", Y1, Y2, Y3)), effect(unconditional), variable(("have_rock_analysis", Y1, Y3)), value(variable(("have_rock_analysis", Y1, Y3)), true)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_postcondition(action(("sample_rock", X1, X2, X3)), effect(unconditional), variable(("at_rock_sample", X3)), value(variable(("at_rock_sample", X3)), false)) :- action(action(("sample_rock", X1, X2, X3))),
	new_postcondition(action(("sample_rock", Y1, Y2, Y3)), effect(unconditional), variable(("at_rock_sample", Y3)), value(variable(("at_rock_sample", Y3)), false)) , action(action(("sample_rock", Y1, Y2, Y3))).

new_precondition(action(("drop", X1, X2)), variable(("store_of", X2, X1)), value(variable(("store_of", X2, X1)), true)) :- action(action(("drop", X1, X2))),
	new_precondition(action(("drop", Y1, Y2)), variable(("store_of", Y2, Y1)), value(variable(("store_of", Y2, Y1)), true)) , action(action(("drop", Y1, Y2))).

new_precondition(action(("drop", X1, X2)), variable(("full", X2)), value(variable(("full", X2)), true)) :- action(action(("drop", X1, X2))),
	new_precondition(action(("drop", Y1, Y2)), variable(("full", Y2)), value(variable(("full", Y2)), true)) , action(action(("drop", Y1, Y2))).

new_postcondition(action(("drop", X1, X2)), effect(unconditional), variable(("full", X2)), value(variable(("full", X2)), false)) :- action(action(("drop", X1, X2))),
	new_postcondition(action(("drop", Y1, Y2)), effect(unconditional), variable(("full", Y2)), value(variable(("full", Y2)), false)) , action(action(("drop", Y1, Y2))).

new_postcondition(action(("drop", X1, X2)), effect(unconditional), variable(("empty", X2)), value(variable(("empty", X2)), true)) :- action(action(("drop", X1, X2))),
	new_postcondition(action(("drop", Y1, Y2)), effect(unconditional), variable(("empty", Y2)), value(variable(("empty", Y2)), true)) , action(action(("drop", Y1, Y2))).

new_precondition(action(("calibrate", X1, X2, X3, X4)), variable(("equipped_for_imaging", X1)), value(variable(("equipped_for_imaging", X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_precondition(action(("calibrate", Y1, Y2, Y3, Y4)), variable(("equipped_for_imaging", Y1)), value(variable(("equipped_for_imaging", Y1)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).

new_precondition(action(("calibrate", X1, X2, X3, X4)), variable(("calibration_target", X2, X3)), value(variable(("calibration_target", X2, X3)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_precondition(action(("calibrate", Y1, Y2, Y3, Y4)), variable(("calibration_target", Y2, Y3)), value(variable(("calibration_target", Y2, Y3)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).

new_precondition(action(("calibrate", X1, X2, X3, X4)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_precondition(action(("calibrate", Y1, Y2, Y3, Y4)), variable(("at", Y1, Y4)), value(variable(("at", Y1, Y4)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).

new_precondition(action(("calibrate", X1, X2, X3, X4)), variable(("visible_from", X3, X4)), value(variable(("visible_from", X3, X4)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_precondition(action(("calibrate", Y1, Y2, Y3, Y4)), variable(("visible_from", Y3, Y4)), value(variable(("visible_from", Y3, Y4)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).

new_precondition(action(("calibrate", X1, X2, X3, X4)), variable(("on_board", X2, X1)), value(variable(("on_board", X2, X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_precondition(action(("calibrate", Y1, Y2, Y3, Y4)), variable(("on_board", Y2, Y1)), value(variable(("on_board", Y2, Y1)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).

new_postcondition(action(("calibrate", X1, X2, X3, X4)), effect(unconditional), variable(("calibrated", X2, X1)), value(variable(("calibrated", X2, X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))),
	new_postcondition(action(("calibrate", Y1, Y2, Y3, Y4)), effect(unconditional), variable(("calibrated", Y2, Y1)), value(variable(("calibrated", Y2, Y1)), true)) , action(action(("calibrate", Y1, Y2, Y3, Y4))).


new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("calibrated", X4, X1)), value(variable(("calibrated", X4, X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("calibrated", Y4, Y1)), value(variable(("calibrated", Y4, Y1)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("on_board", X4, X1)), value(variable(("on_board", X4, X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("on_board", Y4, Y1)), value(variable(("on_board", Y4, Y1)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("equipped_for_imaging", X1)), value(variable(("equipped_for_imaging", X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("equipped_for_imaging", Y1)), value(variable(("equipped_for_imaging", Y1)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("supports", X4, X5)), value(variable(("supports", X4, X5)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("supports", Y4, Y5)), value(variable(("supports", Y4, Y5)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("visible_from", X3, X2)), value(variable(("visible_from", X3, X2)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("visible_from", Y3, Y2)), value(variable(("visible_from", Y3, Y2)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_precondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), variable(("at", Y1, Y2)), value(variable(("at", Y1, Y2)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("take_image", X1, X2, X3, X4, X5)), effect(unconditional), variable(("have_image", X1, X3, X5)), value(variable(("have_image", X1, X3, X5)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_postcondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("have_image", Y1, Y3, Y5)), value(variable(("have_image", Y1, Y3, Y5)), true)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("take_image", X1, X2, X3, X4, X5)), effect(unconditional), variable(("calibrated", X4, X1)), value(variable(("calibrated", X4, X1)), false)) :- action(action(("take_image", X1, X2, X3, X4, X5))),
	new_postcondition(action(("take_image", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("calibrated", Y4, Y1)), value(variable(("calibrated", Y4, Y1)), false)) , action(action(("take_image", Y1, Y2, Y3, Y4, Y5))).


new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("at", Y1, Y4)), value(variable(("at", Y1, Y4)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("at_lander", X2, X5)), value(variable(("at_lander", X2, X5)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("at_lander", Y2, Y5)), value(variable(("at_lander", Y2, Y5)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("have_soil_analysis", X1, X3)), value(variable(("have_soil_analysis", X1, X3)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("have_soil_analysis", Y1, Y3)), value(variable(("have_soil_analysis", Y1, Y3)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("visible", X4, X5)), value(variable(("visible", X4, X5)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("visible", Y4, Y5)), value(variable(("visible", Y4, Y5)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), false)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), false)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), false)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("communicated_soil_data", X3)), value(variable(("communicated_soil_data", X3)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("communicated_soil_data", Y3)), value(variable(("communicated_soil_data", Y3)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_soil_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("at", Y1, Y4)), value(variable(("at", Y1, Y4)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("at_lander", X2, X5)), value(variable(("at_lander", X2, X5)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("at_lander", Y2, Y5)), value(variable(("at_lander", Y2, Y5)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("have_rock_analysis", X1, X3)), value(variable(("have_rock_analysis", X1, X3)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("have_rock_analysis", Y1, Y3)), value(variable(("have_rock_analysis", Y1, Y3)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("visible", X4, X5)), value(variable(("visible", X4, X5)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("visible", Y4, Y5)), value(variable(("visible", Y4, Y5)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_precondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), false)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), false)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), false)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))),
	new_postcondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).

new_postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("communicated_rock_data", X3)), value(variable(("communicated_rock_data", X3)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))), new_postcondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("communicated_rock_data", Y3)), value(variable(("communicated_rock_data", Y3)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).
 
new_postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))), 	
	new_postcondition(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_rock_data", Y1, Y2, Y3, Y4, Y5))).


new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("at", X1, X5)), value(variable(("at", X1, X5)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("at", Y1, Y5)), value(variable(("at", Y1, Y5)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("at_lander", X2, X6)), value(variable(("at_lander", X2, X6)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("at_lander", Y2, Y6)), value(variable(("at_lander", Y2, Y6)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("have_image", X1, X3, X4)), value(variable(("have_image", X1, X3, X4)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("have_image", Y1, Y3, Y4)), value(variable(("have_image", Y1, Y3, Y4)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("visible", X5, X6)), value(variable(("visible", X5, X6)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("visible", Y5, Y6)), value(variable(("visible", Y5, Y6)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_precondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_postcondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), false)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), false)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_postcondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), false)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_postcondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), effect(unconditional), variable(("channel_free", Y2)), value(variable(("channel_free", Y2)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("communicated_image_data", X3, X4)), value(variable(("communicated_image_data", X3, X4)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_postcondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), effect(unconditional), variable(("communicated_image_data", Y3, Y4)), value(variable(("communicated_image_data", Y3, Y4)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).

new_postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))),
	new_postcondition(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6)), effect(unconditional), variable(("available", Y1)), value(variable(("available", Y1)), true)) , action(action(("communicate_image_data", Y1, Y2, Y3, Y4, Y5, Y6))).
 