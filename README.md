<!-- # explanations
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

    * echo '#program robot.' | cat - t2.lp > tmp.lp
      mv tmp.lp t2.lp
      echo '#program base.' | cat - h.lp > tmp.lp
      mv tmp.lp h.lp
      echo '#program actions.' | cat - r.lp > tmp.lp
      mv tmp.lp r.lp

3. Computing the explanation
    * clingo hexplain.py human.lp r.lp h.lp t2.lp verify.lp

A script is given in run.sh  -->

./vrun.sh folder

folder contains human.lp and robot.lp
  
Example:
./vrun.sh test/Exp1

The explanation will be in the two sets: extraAction and changes_set in file hexplain.py
