#PBS -l nodes=1:ppn=1,mem=2GB,walltime=00:30:00
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
mkdir -p dat
mkdir -p output
mkdir -p dat/MaxSINR
mkdir -p dat/MaxSIR
mkdir -p dat/NBSINR
mkdir -p dat/NBSIR
mkdir -p dat/ShadowField
mkfir -p dat/traces

# Run code
R --no-save --no-restore CMD BATCH exampleR.R "output/exampleR-$PBS_ARRAYID.Rout"
$MATLAB -nodisplay -r "traceGeneration, GridVSRandomOutageProb, exit"
#$MATLAB -nodisplay -r "GridVSRandomOutageProb,exit"
