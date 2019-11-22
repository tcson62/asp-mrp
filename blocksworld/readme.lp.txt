0. Preparation

clingo ../../../../test/defh.lp human.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h.lp 

clingo ../../../../test/defr.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > r.lp 

clingo ../../../../test/hr.lp h.lp r.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h-r.lp 

* define r_def - the place holder for pre/post conditions from the robot.lp file 

1. run 
      clingo ../../../../test/plan.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t0.lp 
to get the plan and the length of the shortest plan 


      clingo ../../../../test/getoccurs.lp robot.lp t0.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t1.lp 

or 

      clingo ../../../../test/plan.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 | clingo - ../../../../test/getoccurs.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t1.lp

2. run 
      clingo ../../../../test/explain.lp human.lp t1.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t2.lp  
to compute the minimal explanation  

3. run 
      clingo ../../../../test/noh_plan.lp human.lp t2.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t3.lp
if this is unsatisfiable then we are done 

4. if step 3 returns some answer set then we need to do something: compute the answer sets of length < n. Then remove the pre/post that are not in human/robot

Run 

      clingo ../../../../test/hg_plan.lp human.lp t3.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t4.lp
to get a shortest possible plan from human 

then the loop 

      clingo ../../../../test/noexplain.lp human.lp t4.lp h-r.lp r_def.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t5.lp
      clingo ../../../../test/hg_plan.lp human.lp t5.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t4.lp

until we get a plan of human of the length of robot   