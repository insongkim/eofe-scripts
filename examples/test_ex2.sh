#!/usr/bin/env bash 
#SBATCH -p sched_mit_hill       # name of runtime queue
#SBATCH --nodes=2               # number of nodes
#SBATCH --ntasks-per-node=5     # number of cores
#SBATCH -t 10:00                # wall-time (hh:mm)
#SBATCH -J test_parallel        # job name
#SBATCH -o ./logs/log.%j        # output

echo '==========' 
cd ${SLURM_SUBMIT_DIR} 
echo ${SLURM_SUBMIT_DIR} 
echo Running on host $(hostname) 
echo Time is $(date) 
echo SLURM_NODES are $(echo ${SLURM_NODELIST}) 
echo '==========' 
echo -e '\n\n' 

mpirun -n 1 R CMD BATCH --no-save --no-restore example2.R
