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

1. To run a single instance,

```
./vrun.sh folder
```

folder contains human.lp and robot.lp
  
Example:

```
./vrun.sh test/Exp1
```

The explanation will be in the two sets: extraAction and changes_set in file hexplain.py (printed in console). extraAction contains the first set of explanations. The first set of explanations in combination with the human KB can be used to compute human plan. Verifying that the human plan's length is equal robot's plan results in an additional set of explanations (changes_set). After having the 2 sets of explanation, the program will run another time with optimal module to find the minimal explanation set. 

2. To run all experimental instances,

```
./run_all.sh
```

The result will be printed in `result` file in the instance folder.
Run time.py to show runtimes.

<!-- # for whom is a student
3. If you want to understand the computation process, a good starting point is run.sh. The core steps of the computation are clear. Personally, as a student, I was also given unfamilier code repositories with little documentation, and asked to edit them. I believe to understand how the computation works, reading the code and getting your hands dirty are the musts. Then you can ask the ones who wrote the code if you are still unable to figure out how things work.
-->
