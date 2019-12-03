#program robot. 

maxTime(21). time(1). time(2). time(3). time(4). time(5). time(6). time(7). time(8). time(9). time(10). time(11). time(12). time(13). time(14). time(15). time(16). time(17). time(18). time(19). time(20). time(21). 
robot(occurs(("unstack",constant("e"),constant("g")),1)). 
robot(occurs(("putdown",constant("e")),2)). 
robot(occurs(("unstack",constant("g"),constant("b")),3)). robot(occurs(("putdown",constant("g")),4)). robot(occurs(("unstack",constant("b"),constant("a")),5)). robot(occurs(("putdown",constant("b")),6)). robot(occurs(("unstack",constant("a"),constant("f")),7)). robot(occurs(("putdown",constant("a")),8)). robot(occurs(("unstack",constant("f"),constant("c")),9)). robot(occurs(("stack",constant("f"),constant("e")),10)). robot(occurs(("unstack",constant("c"),constant("d")),11)). robot(occurs(("stack",constant("c"),constant("f")),12)). robot(occurs(("pickup",constant("b")),13)). robot(occurs(("stack",constant("b"),constant("c")),14)). robot(occurs(("pickup",constant("d")),15)). robot(occurs(("stack",constant("d"),constant("b")),16)). robot(occurs(("pickup",constant("g")),17)). robot(occurs(("stack",constant("g"),constant("d")),18)). robot(occurs(("pickup",constant("a")),19)). robot(occurs(("stack",constant("a"),constant("g")),20)). 

considered(Act) :- robot(occurs(A, T)), name(A, Act). 

#show considered/1. 