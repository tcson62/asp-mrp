#show. 
#show hr_postcondition(A,B,C,D) : h_postcondition(A,B,C,D), not r_postcondition(A,B,C,D).
#show hr_precondition(A,B,C) : h_precondition(A,B,C), not r_precondition(A,B,C).
#show rh_postcondition(A,B,C,D) : r_postcondition(A,B,C,D), not h_postcondition(A,B,C,D).
#show rh_precondition(A,B,C) : r_precondition(A,B,C), not h_precondition(A,B,C).
#show rh_action(A) : r_action(A), not h_action(A). 
