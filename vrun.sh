#
# The following script could be used:     
# This assumes that all programs are in a folder ../../../ relative to the   
# folder containing robot.lp and human.lp 
#

prefix=$1

print () {
  echo "$(tput setaf 7)$(tput setab 2)$1$(tput sgr 0)"
}

d1="$(date)"

echo 'Preparation .... ******************* '

clingo defh.lp "$prefix"/human.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > "$prefix"/h.lp 
clingo defr.lp "$prefix"/robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > "$prefix"/r.lp

echo 'Computing minimal plan for robot ....*********** '

clingo plan.lp "$prefix"/robot.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > "$prefix"/t1.lp 

echo 'Finding the first set of explanations .... ************ '

clingo explain.lp "$prefix"/human.lp "$prefix"/t1.lp "$prefix"/h.lp "$prefix"/r.lp --outf=0 -V0 --out-atomf=%s. --quiet=1,2,2 | head -n1 > "$prefix"/t2.lp 
    
echo '#program robot.' | cat - "$prefix"/t2.lp > "$prefix"/tmp.lp
mv "$prefix"/tmp.lp "$prefix"/t2.lp
echo '#program base.' | cat - "$prefix"/h.lp > "$prefix"/tmp.lp
mv "$prefix"/tmp.lp "$prefix"/h.lp
echo '#program actions.' | cat - "$prefix"/r.lp > "$prefix"/tmp.lp
mv "$prefix"/tmp.lp "$prefix"/r.lp

echo 'Computing minimal explanation for human plan .... *********** '

clingo hexplain.py "$prefix"/human.lp "$prefix"/r.lp "$prefix"/h.lp "$prefix"/t2.lp verify_v2.lp

print "${d1}"
print "$(date)"
