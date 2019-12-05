#
# The following script could be used:     
# This assumes that all programs are in a folder ../../../ relative to the   
# folder containing robot.lp and human.lp 
#

print () {
  echo "$(tput setaf 7)$(tput setab 2)$1$(tput sgr 0)"
}

d1="$(date)"

echo 'Preparation .... ******************* '

clingo ../../../defh.lp human.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > h.lp 
clingo ../../../defr.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > r.lp

echo 'Computing minimal plan for robot ....*********** '

clingo ../../../plan.lp robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t1.lp 

echo 'Finding the first set of explanations .... ************ '

clingo ../../../explain.lp human.lp t1.lp h.lp r.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > t2.lp 
    
echo '#program robot.' | cat - t2.lp > tmp.lp
mv tmp.lp t2.lp 
echo '#program base.' | cat - h.lp > tmp.lp
mv tmp.lp h.lp
 echo '#program actions.' | cat - r.lp > tmp.lp
 mv tmp.lp r.lp 

echo 'Computing minimal explanation for human plan .... *********** '
        
clingo ../../../hexplain.py human.lp r.lp h.lp t2.lp ../../../verify.lp

print "${d1}"
print "$(date)"    
