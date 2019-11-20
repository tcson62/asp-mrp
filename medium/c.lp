n1(N) :- N = #count{1,(A,B,C) : rh_precondition(A,B,C)}.

n2(N) :- N = #count{1,(A,B,C) : new_precondition(A,B,C)}.


#show n1/1.
#show n2/1.
#show not_taken(A,B,C) : rh_precondition(A,B,C), not new_precondition(A,B,C). 
