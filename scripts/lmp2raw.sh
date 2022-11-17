ntotal=`grep TIMESTEP ../pos.retrain.lammpstrj | wc -l | awk '{print $1}'`

for i in `seq $ntotal`
do
  if (grep -q 'SCF run converged' ../$i/out) && !(grep -q error ../$i/out)
  then
#    natoms=`head -n 1 ../strm.xyz`
    natoms=`grep -A 1 'NUMBER OF ATOMS' ../pos.retrain.lammpstrj | tail -n 1`
    tail -n $natoms ../$i/str.xyz | awk '{printf "%12.7f %12.7f %12.7f", $2, $3, $4}' >> 1coord.raw
    grep 'ABC' ../$i/01.in | awk 'END{printf "%12.7f %12.7f %12.7f %12.7f %12.7f %12.7f %12.7f %12.7f %12.8f", $2,0,0,0,$3,0,0,0,$4}'>> 1box.raw
#    grep -A 3 'total   stress' ../$i/01.out | awk '(NR>1){printf "%14.5e %14.5e %14.5e", $4*1000, $5*1000, $6*1000}' >> virial.raw
    grep -A $((natoms+2)) 'ATOMIC FORCES in' ../$i/out | tail -n $natoms | awk -v"a=$fconv" '{printf "%12.7f %12.7f %12.7f ", $4*a, $5*a, $6*a}' >> 1force.raw
    grep 'Total energy' ../$i/out | tail -1 | awk -v"a=$econv" 'END{printf "%15.7f\n", $3*a}' >> 1energy.raw

    echo "" >> 1coord.raw
    echo "" >> 1box.raw
    echo "" >> 1virial.raw
    echo "" >> 1force.raw
  fi
done
