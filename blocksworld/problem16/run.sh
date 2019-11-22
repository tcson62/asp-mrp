print () {
  echo "$(tput setaf 7)$(tput setab 2)$1$(tput sgr 0)"
}

PREFIX=$1

clingo ../../../../test/defh.lp human.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h.lp
#
clingo ../../../../test/defr.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > r.lp
#
clingo ../../../../test/hr.lp h.lp r.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h-r.lp

# * define r_def - the place holder for pre/post conditions from the robot.lp file

# 1. run
clingo ../../../../test/plan.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t0.lp
# to get the plan and the length of the shortest plan

clingo ../../../../test/getoccurs.lp robot.lp t0.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t1.lp

robot_plan_length=$(clingo ../../../../test/length.lp t1.lp --outf=0 -V0 --quiet=1,2,2 | head -n1)

echo ${robot_plan_length}

echo "********************** ROBOT PLAN LENGTH ******************"

d1="$(date)"
# 2. run
clingo ../../../../test/explain.lp human.lp t1.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t2.lp
# to compute the minimal explanation

HUMAN_HAS_PLAN=$(head -n 1 "t2.lp")
if [ "$HUMAN_HAS_PLAN" == "UNSATISFIABLE" ];
then
  echo "Human has no plan"
fi

echo "**********************DONE EXPLANATION ******************"



# 3. run
clingo ../../../../test/noh_plan.lp human.lp t2.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t3.lp

# if this is unsatisfiable then we are done
HUMAN_HAS_PLAN=$(head -n 1 "t3.lp")
if [ "$HUMAN_HAS_PLAN" == "UNSATISFIABLE" ];
then
  echo "Human has no plan"
fi

echo "**********************DONE COMPUTING DIFF ******************"


cp /dev/null explanation.lp
if [ "$HUMAN_HAS_PLAN" != "UNSATISFIABLE" ];
then

  echo "********************** COMPUTE FIRST HUMAN's SHORTER PLAN  ******************"

  # 4. if step 3 returns some answer set then we need to do something: compute the answer sets of length < n. Then remove the pre/post that are not in human/robot
  # Run
  clingo ../../../../test/hg_plan.lp human.lp t3.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t4.lp
  # to get a shortest possible plan from human

  echo "********************** DONE WITH FIRST HUMAN's SHORTER PLAN  ******************"

  human_plan_length=$(clingo ../../../../test/length.lp t4.lp --outf=0 -V0 --quiet=1,2,2 | head -n1)
  
  echo "HUMAN PLAN LENGTH $human_plan_length"

  while [ ${human_plan_length} -lt ${robot_plan_length} ];
  do
    print "    Human plan length: ${human_plan_length}"
    echo "LOOP ... $human_plan_length"
    # then the loop
    clingo ../../../../test/noexplain.lp human.lp t4.lp h-r.lp r_def.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t5.lp
    cat t5.lp" >> explanation.lp"
    clingo ../../../../test/hg_plan.lp human.lp t5.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t4.lp
    human_plan_length=$(clingo ../../../../test/length.lp t4.lp --outf=0 -V0 --quiet=1,2,2 | head -n1)
  done
  # until we get a plan of human of the length of robot
fi

print "${d1}"
print "$(date)"

