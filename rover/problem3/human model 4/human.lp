%---------------------------------------
% domain
%---------------------------------------

% utils
boolean(true).
boolean(false).

% types
type(type("rover")).
type(type("waypoint")).
type(type("store")).
type(type("camera")).
type(type("mode")).
type(type("lander")).
type(type("objective")).

has(X, type(T2)) :- has(X, type(T1)), inherits(type(T1), type(T2)).

% variables
variable(variable(("at", X1, X2))) :- has(X1, type("rover")), has(X2, type("waypoint")).
variable(variable(("at_lander", X1, X2))) :- has(X1, type("lander")), has(X2, type("waypoint")).
variable(variable(("can_traverse", X1, X2, X3))) :- has(X1, type("rover")), has(X2, type("waypoint")), has(X3, type("waypoint")).
variable(variable(("equipped_for_soil_analysis", X1))) :- has(X1, type("rover")).
variable(variable(("equipped_for_rock_analysis", X1))) :- has(X1, type("rover")).
variable(variable(("equipped_for_imaging", X1))) :- has(X1, type("rover")).
variable(variable(("empty", X1))) :- has(X1, type("store")).
variable(variable(("have_rock_analysis", X1, X2))) :- has(X1, type("rover")), has(X2, type("waypoint")).
variable(variable(("have_soil_analysis", X1, X2))) :- has(X1, type("rover")), has(X2, type("waypoint")).
variable(variable(("full", X1))) :- has(X1, type("store")).
variable(variable(("calibrated", X1, X2))) :- has(X1, type("camera")), has(X2, type("rover")).
variable(variable(("supports", X1, X2))) :- has(X1, type("camera")), has(X2, type("mode")).
variable(variable(("available", X1))) :- has(X1, type("rover")).
variable(variable(("visible", X1, X2))) :- has(X1, type("waypoint")), has(X2, type("waypoint")).
variable(variable(("have_image", X1, X2, X3))) :- has(X1, type("rover")), has(X2, type("objective")), has(X3, type("mode")).
variable(variable(("communicated_soil_data", X1))) :- has(X1, type("waypoint")).
variable(variable(("communicated_rock_data", X1))) :- has(X1, type("waypoint")).
variable(variable(("communicated_image_data", X1, X2))) :- has(X1, type("objective")), has(X2, type("mode")).
variable(variable(("at_soil_sample", X1))) :- has(X1, type("waypoint")).
variable(variable(("at_rock_sample", X1))) :- has(X1, type("waypoint")).
variable(variable(("visible_from", X1, X2))) :- has(X1, type("objective")), has(X2, type("waypoint")).
variable(variable(("store_of", X1, X2))) :- has(X1, type("store")), has(X2, type("rover")).
variable(variable(("calibration_target", X1, X2))) :- has(X1, type("camera")), has(X2, type("objective")).
variable(variable(("on_board", X1, X2))) :- has(X1, type("camera")), has(X2, type("rover")).
variable(variable(("channel_free", X1))) :- has(X1, type("lander")).

contains(X, value(X, B)) :- variable(X), boolean(B).

% actions
action(action(("navigate", X1, X2, X3))) :- has(X1, type("rover")), has(X2, type("waypoint")), has(X3, type("waypoint")).
precondition(action(("navigate", X1, X2, X3)), variable(("can_traverse", X1, X2, X3)), value(variable(("can_traverse", X1, X2, X3)), true)) :- action(action(("navigate", X1, X2, X3))).
precondition(action(("navigate", X1, X2, X3)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("navigate", X1, X2, X3))).
precondition(action(("navigate", X1, X2, X3)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("navigate", X1, X2, X3))).
precondition(action(("navigate", X1, X2, X3)), variable(("visible", X2, X3)), value(variable(("visible", X2, X3)), true)) :- action(action(("navigate", X1, X2, X3))).
postcondition(action(("navigate", X1, X2, X3)), effect(unconditional), variable(("at", X1, X2)), value(variable(("at", X1, X2)), false)) :- action(action(("navigate", X1, X2, X3))).
postcondition(action(("navigate", X1, X2, X3)), effect(unconditional), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("navigate", X1, X2, X3))).

action(action(("sample_soil", X1, X2, X3))) :- has(X1, type("rover")), has(X2, type("store")), has(X3, type("waypoint")).
precondition(action(("sample_soil", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("sample_soil", X1, X2, X3))).
precondition(action(("sample_soil", X1, X2, X3)), variable(("at_soil_sample", X3)), value(variable(("at_soil_sample", X3)), true)) :- action(action(("sample_soil", X1, X2, X3))).
precondition(action(("sample_soil", X1, X2, X3)), variable(("equipped_for_soil_analysis", X1)), value(variable(("equipped_for_soil_analysis", X1)), true)) :- action(action(("sample_soil", X1, X2, X3))).
precondition(action(("sample_soil", X1, X2, X3)), variable(("store_of", X2, X1)), value(variable(("store_of", X2, X1)), true)) :- action(action(("sample_soil", X1, X2, X3))).
precondition(action(("sample_soil", X1, X2, X3)), variable(("empty", X2)), value(variable(("empty", X2)), true)) :- action(action(("sample_soil", X1, X2, X3))).
postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("empty", X2)), value(variable(("empty", X2)), false)) :- action(action(("sample_soil", X1, X2, X3))).
postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("full", X2)), value(variable(("full", X2)), true)) :- action(action(("sample_soil", X1, X2, X3))).
postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("have_soil_analysis", X1, X3)), value(variable(("have_soil_analysis", X1, X3)), true)) :- action(action(("sample_soil", X1, X2, X3))).
postcondition(action(("sample_soil", X1, X2, X3)), effect(unconditional), variable(("at_soil_sample", X3)), value(variable(("at_soil_sample", X3)), false)) :- action(action(("sample_soil", X1, X2, X3))).

action(action(("sample_rock", X1, X2, X3))) :- has(X1, type("rover")), has(X2, type("store")), has(X3, type("waypoint")).
precondition(action(("sample_rock", X1, X2, X3)), variable(("at", X1, X3)), value(variable(("at", X1, X3)), true)) :- action(action(("sample_rock", X1, X2, X3))).
postcondition(action(("sample_rock", X1, X2, X3)), effect(unconditional), variable(("at_rock_sample", X3)), value(variable(("at_rock_sample", X3)), false)) :- action(action(("sample_rock", X1, X2, X3))).

action(action(("drop", X1, X2))) :- has(X1, type("rover")), has(X2, type("store")).
precondition(action(("drop", X1, X2)), variable(("store_of", X2, X1)), value(variable(("store_of", X2, X1)), true)) :- action(action(("drop", X1, X2))).
precondition(action(("drop", X1, X2)), variable(("full", X2)), value(variable(("full", X2)), true)) :- action(action(("drop", X1, X2))).
postcondition(action(("drop", X1, X2)), effect(unconditional), variable(("full", X2)), value(variable(("full", X2)), false)) :- action(action(("drop", X1, X2))).
postcondition(action(("drop", X1, X2)), effect(unconditional), variable(("empty", X2)), value(variable(("empty", X2)), true)) :- action(action(("drop", X1, X2))).

action(action(("calibrate", X1, X2, X3, X4))) :- has(X1, type("rover")), has(X2, type("camera")), has(X3, type("objective")), has(X4, type("waypoint")).
precondition(action(("calibrate", X1, X2, X3, X4)), variable(("equipped_for_imaging", X1)), value(variable(("equipped_for_imaging", X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).
precondition(action(("calibrate", X1, X2, X3, X4)), variable(("calibration_target", X2, X3)), value(variable(("calibration_target", X2, X3)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).
precondition(action(("calibrate", X1, X2, X3, X4)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).
precondition(action(("calibrate", X1, X2, X3, X4)), variable(("visible_from", X3, X4)), value(variable(("visible_from", X3, X4)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).
precondition(action(("calibrate", X1, X2, X3, X4)), variable(("on_board", X2, X1)), value(variable(("on_board", X2, X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).
postcondition(action(("calibrate", X1, X2, X3, X4)), effect(unconditional), variable(("calibrated", X2, X1)), value(variable(("calibrated", X2, X1)), true)) :- action(action(("calibrate", X1, X2, X3, X4))).

action(action(("take_image", X1, X2, X3, X4, X5))) :- has(X1, type("rover")), has(X2, type("waypoint")), has(X3, type("objective")), has(X4, type("camera")), has(X5, type("mode")).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("calibrated", X4, X1)), value(variable(("calibrated", X4, X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("on_board", X4, X1)), value(variable(("on_board", X4, X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("equipped_for_imaging", X1)), value(variable(("equipped_for_imaging", X1)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("supports", X4, X5)), value(variable(("supports", X4, X5)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("visible_from", X3, X2)), value(variable(("visible_from", X3, X2)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
precondition(action(("take_image", X1, X2, X3, X4, X5)), variable(("at", X1, X2)), value(variable(("at", X1, X2)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
postcondition(action(("take_image", X1, X2, X3, X4, X5)), effect(unconditional), variable(("have_image", X1, X3, X5)), value(variable(("have_image", X1, X3, X5)), true)) :- action(action(("take_image", X1, X2, X3, X4, X5))).
postcondition(action(("take_image", X1, X2, X3, X4, X5)), effect(unconditional), variable(("calibrated", X4, X1)), value(variable(("calibrated", X4, X1)), false)) :- action(action(("take_image", X1, X2, X3, X4, X5))).

action(action(("communicate_soil_data", X1, X2, X3, X4, X5))) :- has(X1, type("rover")), has(X2, type("lander")), has(X3, type("waypoint")), has(X4, type("waypoint")), has(X5, type("waypoint")).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("at_lander", X2, X5)), value(variable(("at_lander", X2, X5)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("have_soil_analysis", X1, X3)), value(variable(("have_soil_analysis", X1, X3)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("visible", X4, X5)), value(variable(("visible", X4, X5)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), false)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("communicated_soil_data", X3)), value(variable(("communicated_soil_data", X3)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_soil_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_soil_data", X1, X2, X3, X4, X5))).

action(action(("communicate_rock_data", X1, X2, X3, X4, X5))) :- has(X1, type("rover")), has(X2, type("lander")), has(X3, type("waypoint")), has(X4, type("waypoint")), has(X5, type("waypoint")).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("at", X1, X4)), value(variable(("at", X1, X4)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("at_lander", X2, X5)), value(variable(("at_lander", X2, X5)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("have_rock_analysis", X1, X3)), value(variable(("have_rock_analysis", X1, X3)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("visible", X4, X5)), value(variable(("visible", X4, X5)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
precondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), false)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("communicated_rock_data", X3)), value(variable(("communicated_rock_data", X3)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).
postcondition(action(("communicate_rock_data", X1, X2, X3, X4, X5)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), true)) :- action(action(("communicate_rock_data", X1, X2, X3, X4, X5))).

action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))) :- has(X1, type("rover")), has(X2, type("lander")), has(X3, type("objective")), has(X4, type("mode")), has(X5, type("waypoint")), has(X6, type("waypoint")).
precondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), variable(("channel_free", X2)), value(variable(("channel_free", X2)), true)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))).
postcondition(action(("communicate_image_data", X1, X2, X3, X4, X5, X6)), effect(unconditional), variable(("available", X1)), value(variable(("available", X1)), false)) :- action(action(("communicate_image_data", X1, X2, X3, X4, X5, X6))).

%---------------------------------------
% problem
%---------------------------------------

% objects
constant(constant("general")).
has(constant("general"), type("lander")).

constant(constant("colour")).
has(constant("colour"), type("mode")).

constant(constant("high_res")).
has(constant("high_res"), type("mode")).

constant(constant("low_res")).
has(constant("low_res"), type("mode")).

constant(constant("rover0")).
has(constant("rover0"), type("rover")).

constant(constant("rover1")).
has(constant("rover1"), type("rover")).

constant(constant("rover0store")).
has(constant("rover0store"), type("store")).

constant(constant("rover1store")).
has(constant("rover1store"), type("store")).

constant(constant("waypoint0")).
has(constant("waypoint0"), type("waypoint")).

constant(constant("waypoint1")).
has(constant("waypoint1"), type("waypoint")).

constant(constant("waypoint2")).
has(constant("waypoint2"), type("waypoint")).

constant(constant("waypoint3")).
has(constant("waypoint3"), type("waypoint")).

constant(constant("camera0")).
has(constant("camera0"), type("camera")).

constant(constant("camera1")).
has(constant("camera1"), type("camera")).

constant(constant("objective0")).
has(constant("objective0"), type("objective")).

constant(constant("objective1")).
has(constant("objective1"), type("objective")).

% initial state
initialState(variable(("visible", constant("waypoint0"), constant("waypoint1"))), value(variable(("visible", constant("waypoint0"), constant("waypoint1"))), true)).
initialState(variable(("visible", constant("waypoint1"), constant("waypoint0"))), value(variable(("visible", constant("waypoint1"), constant("waypoint0"))), true)).
initialState(variable(("visible", constant("waypoint0"), constant("waypoint3"))), value(variable(("visible", constant("waypoint0"), constant("waypoint3"))), true)).
initialState(variable(("visible", constant("waypoint3"), constant("waypoint0"))), value(variable(("visible", constant("waypoint3"), constant("waypoint0"))), true)).
initialState(variable(("visible", constant("waypoint1"), constant("waypoint2"))), value(variable(("visible", constant("waypoint1"), constant("waypoint2"))), true)).
initialState(variable(("visible", constant("waypoint2"), constant("waypoint1"))), value(variable(("visible", constant("waypoint2"), constant("waypoint1"))), true)).
initialState(variable(("visible", constant("waypoint1"), constant("waypoint3"))), value(variable(("visible", constant("waypoint1"), constant("waypoint3"))), true)).
initialState(variable(("visible", constant("waypoint3"), constant("waypoint1"))), value(variable(("visible", constant("waypoint3"), constant("waypoint1"))), true)).
initialState(variable(("visible", constant("waypoint2"), constant("waypoint0"))), value(variable(("visible", constant("waypoint2"), constant("waypoint0"))), true)).
initialState(variable(("visible", constant("waypoint0"), constant("waypoint2"))), value(variable(("visible", constant("waypoint0"), constant("waypoint2"))), true)).
initialState(variable(("visible", constant("waypoint3"), constant("waypoint2"))), value(variable(("visible", constant("waypoint3"), constant("waypoint2"))), true)).
initialState(variable(("visible", constant("waypoint2"), constant("waypoint3"))), value(variable(("visible", constant("waypoint2"), constant("waypoint3"))), true)).
initialState(variable(("at_rock_sample", constant("waypoint0"))), value(variable(("at_rock_sample", constant("waypoint0"))), true)).
initialState(variable(("at_rock_sample", constant("waypoint1"))), value(variable(("at_rock_sample", constant("waypoint1"))), true)).
initialState(variable(("at_soil_sample", constant("waypoint2"))), value(variable(("at_soil_sample", constant("waypoint2"))), true)).
initialState(variable(("at_rock_sample", constant("waypoint2"))), value(variable(("at_rock_sample", constant("waypoint2"))), true)).
initialState(variable(("at_lander", constant("general"), constant("waypoint0"))), value(variable(("at_lander", constant("general"), constant("waypoint0"))), true)).
initialState(variable(("channel_free", constant("general"))), value(variable(("channel_free", constant("general"))), true)).
initialState(variable(("at", constant("rover0"), constant("waypoint1"))), value(variable(("at", constant("rover0"), constant("waypoint1"))), true)).
initialState(variable(("available", constant("rover0"))), value(variable(("available", constant("rover0"))), true)).
initialState(variable(("store_of", constant("rover0store"), constant("rover0"))), value(variable(("store_of", constant("rover0store"), constant("rover0"))), true)).
initialState(variable(("empty", constant("rover0store"))), value(variable(("empty", constant("rover0store"))), true)).
initialState(variable(("equipped_for_soil_analysis", constant("rover0"))), value(variable(("equipped_for_soil_analysis", constant("rover0"))), true)).
initialState(variable(("equipped_for_rock_analysis", constant("rover0"))), value(variable(("equipped_for_rock_analysis", constant("rover0"))), true)).
initialState(variable(("equipped_for_imaging", constant("rover0"))), value(variable(("equipped_for_imaging", constant("rover0"))), true)).
initialState(variable(("can_traverse", constant("rover0"), constant("waypoint1"), constant("waypoint0"))), value(variable(("can_traverse", constant("rover0"), constant("waypoint1"), constant("waypoint0"))), true)).
initialState(variable(("can_traverse", constant("rover0"), constant("waypoint0"), constant("waypoint1"))), value(variable(("can_traverse", constant("rover0"), constant("waypoint0"), constant("waypoint1"))), true)).
initialState(variable(("can_traverse", constant("rover0"), constant("waypoint1"), constant("waypoint3"))), value(variable(("can_traverse", constant("rover0"), constant("waypoint1"), constant("waypoint3"))), true)).
initialState(variable(("can_traverse", constant("rover0"), constant("waypoint3"), constant("waypoint1"))), value(variable(("can_traverse", constant("rover0"), constant("waypoint3"), constant("waypoint1"))), true)).
initialState(variable(("at", constant("rover1"), constant("waypoint3"))), value(variable(("at", constant("rover1"), constant("waypoint3"))), true)).
initialState(variable(("available", constant("rover1"))), value(variable(("available", constant("rover1"))), true)).
initialState(variable(("store_of", constant("rover1store"), constant("rover1"))), value(variable(("store_of", constant("rover1store"), constant("rover1"))), true)).
initialState(variable(("empty", constant("rover1store"))), value(variable(("empty", constant("rover1store"))), true)).
initialState(variable(("equipped_for_soil_analysis", constant("rover1"))), value(variable(("equipped_for_soil_analysis", constant("rover1"))), true)).
initialState(variable(("equipped_for_rock_analysis", constant("rover1"))), value(variable(("equipped_for_rock_analysis", constant("rover1"))), true)).
initialState(variable(("equipped_for_imaging", constant("rover1"))), value(variable(("equipped_for_imaging", constant("rover1"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint3"), constant("waypoint0"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint3"), constant("waypoint0"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint0"), constant("waypoint3"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint0"), constant("waypoint3"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint3"), constant("waypoint2"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint3"), constant("waypoint2"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint2"), constant("waypoint3"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint2"), constant("waypoint3"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint0"), constant("waypoint1"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint0"), constant("waypoint1"))), true)).
initialState(variable(("can_traverse", constant("rover1"), constant("waypoint1"), constant("waypoint0"))), value(variable(("can_traverse", constant("rover1"), constant("waypoint1"), constant("waypoint0"))), true)).
initialState(variable(("on_board", constant("camera0"), constant("rover0"))), value(variable(("on_board", constant("camera0"), constant("rover0"))), true)).
initialState(variable(("calibration_target", constant("camera0"), constant("objective1"))), value(variable(("calibration_target", constant("camera0"), constant("objective1"))), true)).
initialState(variable(("supports", constant("camera0"), constant("low_res"))), value(variable(("supports", constant("camera0"), constant("low_res"))), true)).
initialState(variable(("on_board", constant("camera1"), constant("rover1"))), value(variable(("on_board", constant("camera1"), constant("rover1"))), true)).
initialState(variable(("calibration_target", constant("camera1"), constant("objective0"))), value(variable(("calibration_target", constant("camera1"), constant("objective0"))), true)).
initialState(variable(("supports", constant("camera1"), constant("colour"))), value(variable(("supports", constant("camera1"), constant("colour"))), true)).
initialState(variable(("supports", constant("camera1"), constant("high_res"))), value(variable(("supports", constant("camera1"), constant("high_res"))), true)).
initialState(variable(("supports", constant("camera1"), constant("low_res"))), value(variable(("supports", constant("camera1"), constant("low_res"))), true)).
initialState(variable(("visible_from", constant("objective0"), constant("waypoint0"))), value(variable(("visible_from", constant("objective0"), constant("waypoint0"))), true)).
initialState(variable(("visible_from", constant("objective0"), constant("waypoint1"))), value(variable(("visible_from", constant("objective0"), constant("waypoint1"))), true)).
initialState(variable(("visible_from", constant("objective1"), constant("waypoint0"))), value(variable(("visible_from", constant("objective1"), constant("waypoint0"))), true)).
initialState(variable(("visible_from", constant("objective1"), constant("waypoint1"))), value(variable(("visible_from", constant("objective1"), constant("waypoint1"))), true)).

initialState(X, value(X, false)) :- variable(X), not initialState(X, value(X, true)).

% goal
goal(variable(("communicated_soil_data", constant("waypoint2"))), value(variable(("communicated_soil_data", constant("waypoint2"))), true)).
goal(variable(("communicated_rock_data", constant("waypoint0"))), value(variable(("communicated_rock_data", constant("waypoint0"))), true)).
goal(variable(("communicated_image_data", constant("objective0"), constant("colour"))), value(variable(("communicated_image_data", constant("objective0"), constant("colour"))), true)).
