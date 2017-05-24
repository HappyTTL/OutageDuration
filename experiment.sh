#PBS -l nodes=1:ppn=1,mem=2GB,walltime=05:00:00
#PBS -o output/
#PBS -e output/

if ! type matlab > /dev/null 2>&1; then
    # Running on laptop
    MATLAB="/Applications/MATLAB_R2015a.app/bin/matlab"
fi
if [[ ! -z "$PBS_JOBID" ]]; then 
    # Running on cluster
    module load r/intel/3.2.2
    module load matlab/2015b
    MATLAB="matlab"
fi

# Go to the right directory
cd $SCRATCH/OutageDuration

# Create 'dat' directory if it does not exist
mkdir -p dat20
mkdir -p output
mkdir -p dat20/MaxSINR
mkdir -p dat20/MaxSIR
mkdir -p dat20/NBSINR
mkdir -p dat20/NBSIR
mkdir -p dat20/ShadowField
mkdir -p dat20/traces

# Run code
# $TMPDIR=/scratch/tl984/tmp
R --no-save --no-restore CMD BATCH exampleR.R "output/exampleR-$PBS_ARRAYID.Rout"
$MATLAB -nodisplay -r "master, exit"
#$MATLAB -nodisplay -r "GridVSRandomOutageProb,exit"
