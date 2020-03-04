import glob
import os
import re

ftr = [3600,60,1]

mylist = [f for f in glob.glob("*/*/*/result")]

for f in mylist:
  print(f)
  cf = f.replace(" ", "\ ")
  out = os.popen("grep MST " + cf).read()
  time = re.findall("\d+\:\d+\:\d+", out)
  start = sum([a*b for a,b in zip(ftr, map(int,time[0].split(':')))])
  end = sum([a*b for a,b in zip(ftr, map(int,time[1].split(':')))])
  print( end - start )
