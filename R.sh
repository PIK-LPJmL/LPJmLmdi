module purge
module load R
module load intel/2018.1
module load netcdf
module load netcdf-c/4.2.1.1/serial
module list
module load udunits
module load json-c/0.13
module load intel/2018.1
module load R
unset I_MPI_DAPL_UD_PROVIDER
export R_LIBS_USER=/p/projects/biodiversity/R
R
