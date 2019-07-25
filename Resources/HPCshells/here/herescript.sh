#!/bin/bash
for a in {1..99}
do
cat <<- EOF > job${a}
#!/bin/bash
#SBATCH -p cloud
#SBATCH -N ${a}
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#echo $(pwd) >> results.txt
EOF
done
