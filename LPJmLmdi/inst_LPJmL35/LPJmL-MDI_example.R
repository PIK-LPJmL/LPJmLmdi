#--------------------------------------------------------------------------------
# NAME: 
filename <- "LPJmL-MDI_example.R"
# PROJECT: Example script for the use of LPJmL-MDI
# CREATION DATE: 2015-09-24
# AUTHOR: Matthias Forkel, mforkel@bgc-jena.mpg.de
# UPDATE: 
#--------------------------------------------------------------------------------


#---------------------------------------------------------------------
# 1. Set directories, load packages and define optimization experiment
#---------------------------------------------------------------------


# define directories
#-------------------

rm(list=ls(all=TRUE))
for (i in 1:10) gc()
options(error=traceback)

# paths
path.me <- "/Net/Groups/BGI/people/mforkel/" # main directory
# path.me <- "Z://"
path.geodata <- paste0(path.me, "geodata/") # directory with data
path.lpj.fun <- paste0(path.me, "R_packages/LPJmLmdi/") # LPJmL-MDI package
path.lpj.input <- paste0(path.me, "lpj/input_global/") # LPJmL input data
path.lpj <- paste0(path.me, "lpj/LPJmL_131016/") # LPJmL installation
path.tmp <- "/scratch/mforkel/" # temporay model outputs
path.out <- paste0(path.lpj, "/out_optim/opt_Example/")
dir.create(path.out)


# load packages and functions
#----------------------------

# load packages
library(raster)
library(plyr)
library(rgenoud)
library(snow)
library(doSNOW)
library(RColorBrewer)
library(quantreg)
library(numDeriv)

# load functions of the LPJmL-MDI package
setwd(paste0(path.lpj.fun, "R/"))
files <- list.files(pattern=".R")
for (i in 1:length(files)) source(files[i])

setwd(paste0(path.lpj.fun, "data/"))
load("data110.RData")
 
 
# define optimization experiment
#-------------------------------

# define the optimization experiment
name <- "Opt_Example" 	# name of the optimization experiment: base name for all output files
calcnew <- TRUE 		# extract LPJmL forcing data for the selected grid cells or take previously extracted data?
CostMDS <- CostMDS.SSE 	# cost function for multiple data sets
restart <- 0 			# restart from previous optimization experiment? 
						# 	0 = no restart
						#	1 = continue with optimization
						#	2 = do only post-processing of optimization results
path.rescue <- NULL 	# directory with rescue files to restart from previous optimization (restart > 0)

# settings for genetic optimization
nodes <- 1 				# number of cluster nodes for parallel computing within genoud()
pop.size <- 10 			# population size: 10 for testing, production run should have 800-1000
max.generations <- 10 	# maximum number of generations: 10 for testing, production run 20-60
wait.generations <- 9	# minimum number of gnereations to wait before optimum parameter set is returned
BFGSburnin <- 11		# number of generations before the gradient search algorithm if first used


# remove temporary files at scratch? uncomment if you have two jobs at the same machine
system(paste("rm -rf", path.tmp)) 
system(paste("mkdir", path.tmp)) 


#----------------------------
# 2. Prepare LPJmL input data
#----------------------------

# select grid cells for optimization
#-----------------------------------

# Carefully select grid cells that are representative for the process or PFT that you want to optimize!
# For example, to optimize phenology of the boreal needle-leaved summergreen PFT, we need grid cells where this PFT is growing and has a dominant coverage:

grid.name <- "BoNS_3cells" # name of the new grid
grid <- cbind(lon=c(104.25, 105.25, 105.25), lat=c(61.75, 61.25, 62.25))


# define LPJmL input data
#------------------------

files.clm <- c(
	# monthly CRU and ERI data:
	TMP_FILE = paste(path.lpj.input, "cru3-2/cru_ts_3.20.1901.2011.tmp.clm", sep="/"),
	PRE_FILE = paste(path.lpj.input, "cru3-2/cru_ts3.20.1901.2011.pre.dat.clm", sep="/"),
	SWDOWN_FILE = paste(path.lpj.input, "era/swdown_erainterim_1901-2011.clm", sep="/"),
	LWNET_FILE = paste(path.lpj.input, "era/lwnet_erainterim_1901-2011.clm", sep="/"),
		
	# extra data:
	WINDSPEED_FILE = paste(path.lpj.input, "spitfire/mwindspeed_1860-2100_67420.clm", sep="/"),
	DTR_FILE = paste(path.lpj.input, "cru3-2/cru_ts3.20.1901.2011.dtr.dat.clm", sep="/"),
	BURNTAREA_FILE = paste(path.lpj.input, "burntarea/GFED_CNFDB_ALFDB_Extrap2.BA.360.720.1901.2012.30days.clm", sep="/"),
	DRAINCLASS_FILE = paste(path.lpj.input, "drainclass.bin", sep="/"),
	SOILCODE_FILE = paste(path.lpj.input, "soil_new_67420.bin", sep="/"),
	WET_FILE = paste(path.lpj.input, "cru3-2/cru_ts3.20.1901.2011.wet.dat.clm", sep="/")
)


# subset global input data for the selected grid cells
#-----------------------------------------------------
	
# directory for regional LPJmL inputs
path.lpj.input.reg <- paste0(path.lpj.input, grid.name)
dir.create(path.lpj.input.reg)

# file names for regional LPJmL inputs
files.new <- strsplit(files.clm, "/")
files.new <- unlist(llply(files.new, function(file) {
	file <- paste(path.lpj.input.reg, paste0(grid.name, "_", file[length(file)]), sep="/")
	file <- gsub("//", "/", file)
	return(file)
}))

# read LPJmL input data for actual grid cells and write new *.clm files:
setwd(path.lpj.input.reg)
if (any(!file.exists(files.new)) | calcnew) {
	# read input data and subset for new grid
	lpjinput <- ReadLPJinput(files.clm, grid=grid)

	# write LPJmL input data with new grid
	setwd(path.lpj.input.reg)
	WriteLPJinput(lpjinput, files=files.new)
}


#------------------------------------------
# 3. Define LPJmL directories and templates 
#------------------------------------------

# data.frame with input data
input.df <- data.frame(
	name=c("GRID_FILE", names(files.clm)), 
	file=c(c(paste0(files.new[1], ".grid"), files.new))
)

# LPJmL directories and configuration template files
dir.create(path.tmp)
lpjfiles <- LPJfiles(path.lpj = path.lpj, path.tmp = path.tmp, path.out = path.out, 
	sim.start.year = 1901, 											# starting year of transient simulation
	lpj.conf = paste0(path.lpj.fun, "inst/lpjml_template.conf"), 	# template file for LPJmL configuration 
	param.conf = paste0(path.lpj.fun, "inst/param_template.conf"), 	# template file	for parameter configuration 
	pft.par = paste0(path.lpj.fun, "inst/pft_template.par"), 		# template file for PFT-specific parameters 
	param.par = paste0(path.lpj.fun, "inst/param_template.par"), 	# template file for global parameters 
	input.conf = paste0(path.lpj.fun, "inst/input_template.conf"), 	# template file for input data 
	input=input.df) 	
	


#------------------------------------
# 4. Define and read integration data
#------------------------------------

# define all integration data sets
fapar.gimms <- IntegrationDataset(name="FAPAR", unit="", 
	data.val.file = paste0(path.geodata, "gimms_ndvi_3g/fpar3g/GIMMS3g.FPAR.720.360.1982.2011.30days.nc"),
	data.unc.file = 0.18,
	data.time = seq(as.Date("1982-01-01"), as.Date("2011-12-31"), by="month"),
	model.val.file = "mfapar.bin",
	xy = grid, AggFun = NULL, data.factor=NULL, cost=TRUE, CostFunction=SSE, weight=1)
	
ndaymonth <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31) # convert gC m-2 day-1 -> gC m-2 month-1
gpp.mte <- IntegrationDataset(name="GPP", unit="gC m-2 month-1", 
	data.val.file = paste0(path.geodata, "mte_gpp/GPP.MA.MSC.1982.2011.GPP_MSC.nc"),
	data.unc.file = paste0(path.geodata, "mte_gpp/GPP.MA.MSC.1982.2011.GPP_MSC_unc.nc"),
	data.time = seq(as.Date("1982-01-01"), as.Date("2011-12-31"), by="month"),
	model.val.file = "mgpp.bin",
	xy = grid, AggFun = AggMSC, data.factor=ndaymonth, cost=TRUE, CostFunction=SSE, weight=1)
	
	
# make list of IntegrationData
integrationdata <- IntegrationData(fapar.gimms, gpp.mte)
plot(integrationdata, 1)
plot(integrationdata, 2)

	
#--------------------------------------------------
# 5. Define LPJmL prior parameter values and ranges
#--------------------------------------------------

# Depending on your application, you might need to define additional parameters in param_template.par and pft_template.par


# read parameter priors and ranges from *.txt file
#-------------------------------------------------

# It is helpful to save all parameter names, prior values and prior ranges in a Excel table or *.csv file

setwd(path.lpj.fun)
par.df <- read.table("inst/parameters_prior.txt", header=TRUE, sep="\t")

# make LPJpar object
lpjpar <- LPJpar(par.prior=par.df$par.prior, par.lower=par.df$par.lower, par.upper=par.df$par.upper, par.pftspecif=par.df$par.pftspecif, par.names=par.df$par.names)
plot(lpjpar, "ALPHAA")
plot(lpjpar, "ALBEDO_LEAF")


# select parameters for optimization
#-----------------------------------

# Which parameters should be included in optimization?
par.optim <- c("ALPHAA", "ALBEDO_LEAF", "LIGHTEXTCOEFF", "TMIN_BASE", "WATER_BASE", "LIGHT_BASE", "TPHOTO_LOW", "TPHOTO_HIGH")

# For which PFTs?
pft.sel <- c("BoNS", "PoH")
par.optim <- paste(rep(par.optim, each=length(pft.sel)), pft.sel, sep="_")
par.optim


#------------------------
# 6. Perform optimization
#------------------------


# do optimization
OptimizeLPJgenoud(xy = grid, 				# matrix of grid cell coordinates to run LPJ
	name = name, 							# name of the experiment (basic file name for all outputs)
	lpjpar = lpjpar,						# see LPJpar
	par.optim = par.optim,			        # names of the parameters in LPJpar that should be optimized
	lpjfiles = lpjfiles,					# see LPJfiles
	copy.input = TRUE, 						# Should LPJmL input data be copied to the directory for temporary output? 
	integrationdata = integrationdata,		# see IntegrationData
	plot = TRUE,							# plot results?
	pop.size = pop.size, 					# population size
	max.generations = max.generations, 		# max number of generations
	wait.generations = wait.generations,	# minimum number of generations to wait
	BFGSburnin = BFGSburnin,				# number of generations before the gradient search algorithm if first used
	calc.jacob = FALSE, 					# Compute Hessian and Jacobian (yes = TRUE, no = FALSE)?
	restart = restart, 						# Restart? 0 = at beginning, 1 = continue with genoud, 2 = post-processing
	path.rescue = path.rescue, 				# directory with 'resuce' files from a previous optimization if restart > 0
	restart.jacob = FALSE, 					# Compute Hessian and Jacobian if restart > 0 (yes = TRUE, no = FALSE)? 
	nodes = nodes, 							# How many nodes to use for parallel computing within genoud?
	maxAutoRestart = max.generations-1, 	# maximum number of automatic restarts in case something crashes
	runonly=FALSE,							# make only model run (TRUE) or do full optimization?
	CostMDS=CostMDS)						# Cost function for multiple data stes to use


# # check the progress of the optimization:
# setwd("Z:/lpj/LPJmL_131016/out_optim/opt_Example/Opt_Example_0_2_rescue") # directory with rescue files
# files <- list.files(pattern=".RData") 
# rescue <- CombineRescueFiles(files, remove=FALSE)
# plot(rescue, ylim=c(0, 1.5))

