# explanations
ASP Based Explanations

Code structures

0. Preparation: translation tool plasp 
    * human.pddl => human.lp 
    * robot.pddl    => robot.lp  
    * clingo defh.lp human.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h.lp 
    * clingo defr.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > r.lp

1. Computing plan for robot: plan.lp 
    * clingo plan.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t1.lp 

2. Identify missing elements in human specifications
    * clingo explain.lp human.lp t1.lp h.lp r.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t2.lp 
    
    * Add "#program robot." at the top of t2.lp   
    * Add "#program base." at the top of h.lp   
    * Add "#program actions." at the top of r.lp 
    
    TODO: need to find way to remove these three minor steps. 
    
3. Computing the explanation 
    * clingo hexplain.py human.lp r.lp h.lp t2.lp verify.lp