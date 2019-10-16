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
path.me <- "/p/projects/" # main directory
# path.me <- "Z://"
path.geodata <- paste0(path.me, "biodiversity/validation_data/") # directory with data
path.lpj.fun <- paste0(path.me, "biodiversity/drueke/LPJmLmdi/LPJmLmdi/") # LPJmL-MDI package
path.lpj.input <- paste0("/p/projects/lpjml/input/GLDAS/INPUT/") # LPJmL input data
path.lpj <- paste0(path.me, "biodiversity/drueke/internal_lpjml/") # LPJmL installation
path.tmp <- "/p/tmp/drueke/LPJmLmdi/" # temporay model outputs
dir.create(path.tmp, recursive=TRUE)
path.out <- paste0("/p/projects/biodiversity/drueke/LPJmLmdi_optim/opt_Example/")
dir.create(path.out, recursive=TRUE)


# load packages and functions
#----------------------------

# load packages
library(LPJmLmdi)
#library(raster)
library(plyr)
library(rgenoud)
library(snow)
#library(doSNOW)
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
name <- "presc_landcover2" 	# name of the optimization experiment: base name for all output files
calcnew <- TRUE 		# extract LPJmL forcing data for the selected grid cells or take previously extracted data?
CostMDS <- CostMDS.SSE 	# cost function for multiple data sets
restart <- 0 			# restart from previous optimization experiment? 
						# 	0 = no restart
						#	1 = continue with optimization
						#	2 = do only post-processing of optimization results
path.rescue <- NULL 	# directory with rescue files to restart from previous optimization (restart > 0)

# settings for genetic optimization
nodes <- 1 				# number of cluster nodes for parallel computing within genoud()
pop.size <- 50 			# population size: 10 for testing, production run should have 800-1000
max.generations <- 10 	# maximum number of generations: 10 for testing, production run 20-60
wait.generations <- 14	# minimum number of gnereations to wait before optimum parameter set is returned
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

grid.name <- "SA_1cell" # name of the new grid
#grid <- cbind(lon=c(-44.75,64.75,29.75,132.75,112.25), lat=c(-12.75,45.75,10.75,-12.75,54.25))
grid <- cbind(lon=c(-38.75,-46.75,-55.75,-65.25,-54.75), lat=c(-7.75,-9.75,-10.25,-6.75,-20.75))


# define LPJmL input data
#------------------------

files.clm <- c(
	# monthly CRU and ERI data:
	TMP_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Tair_f_inst.clm", sep="/"),
	PRE_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Prec.clm", sep="/"),
	SWDOWN_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.SWdown_f_tavg.clm", sep="/"),
	LWNET_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Lwnet_tavg.clm", sep="/"),
		
	# extra data:
	WINDSPEED_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Wind_f_inst.clm", sep="/"),
	#DTR_FILE = paste(path.lpj.input, "cru3-2/cru_ts3.20.1901.2011.dtr.dat.clm", sep="/"),
	#BURNTAREA_FILE = paste(path.lpj.input, "burntarea/GFED_CNFDB_ALFDB_Extrap2.BA.360.720.1901.2012.30days.clm", sep="/"),
	#DRAINCLASS_FILE = paste(path.lpj.input, "drainclass.bin", sep="/"),
	SOILCODE_FILE = paste(path.lpj.input, "soil_GLDAS.bin", sep="/"),
	#WET_FILE = paste("/p/projects/lpjml/input/historical/CRUDATA_TS3_23/gpcc_v7_cruts3_23_wet_1901_2013.clm", sep="/"),
	TMIN_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Tair_min.clm", sep="/"),
	TMAX_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Tair_max.clm", sep="/"),
	HUMID_FILE = paste(path.lpj.input, "GLDAS_NOAH05_daily_1948-2017.Qair_f_inst.clm", sep="/"),
	LIGHTNING_FILE = paste(path.lpj.input, "dlightning.clm", sep="/"),
	POPDENS_FILE = paste(path.lpj.input, "popdens_GLDAS.clm", sep="/"),
	HUMANIGN_FILE = paste(path.lpj.input, "human_ignition_GLDAS.clm", sep="/"),
	LANDUSE_FILE = paste(path.lpj.input, "landuse_GLDAS.clm", sep="/"),
	COUNTRY_FILE = paste(path.lpj.input, "country_GLDAS.clm", sep="/"),
	LANDCOVER_FILE = paste(path.lpj.input, "landcover_gldas.clm", sep="/")

)

input.df <- RegridLPJinput(files.clm, "/p/projects/lpjml/input/GLDAS/INPUT/grid_GLDAS.clm", grid, "/p/tmp/drueke/LPJmLmdi_input")


#------------------------------------------
# 3. Define LPJmL directories and templates 
#------------------------------------------


# LPJmL directories and configuration template files
dir.create(path.tmp)
lpjfiles <- LPJfiles(path.lpj = path.lpj, path.tmp = path.tmp, path.out = path.out, 
	sim.start.year = 1948, sim.end.year = 2011,											# starting year of transient simulation
	lpj.conf = paste0(path.lpj.fun, "inst_gldas/lpjml_template.js"), 	# template file for LPJmL configuration 
	param.conf = paste0(path.lpj.fun, "inst_gldas/param_template.js"), 	# template file	for parameter configuration 
	pft.par = paste0(path.lpj.fun, "inst_gldas/pft_template.js"), 		# template file for PFT-specific parameters 
	param.par = paste0(path.lpj.fun, "inst_gldas/lpjparam_template.js"), 	# template file for global parameters 
	input.conf = paste0(path.lpj.fun, "inst_gldas/input_template.js"), 	# template file for input data 
	input=input.df) 	
	


#------------------------------------
# 4. Define and read integration data
#------------------------------------

# define all integration data sets

mburnt_area.gimms <- IntegrationDataset(name="BA_nocrop", unit="ha",
        data.val.file = paste0(path.geodata, "test.nc"),
        data.unc.file = 0.1,
        data.time = seq(as.Date("1997-12-31"), as.Date("2011-12-31"), by="year"),
        model.val.file = "aburnt_area.bin",
        xy = grid, AggFun = NULL, data.factor=NULL, cost=TRUE, CostFunction=SSE, weight=1)



	
ndaymonth <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31) # convert gC m-2 day-1 -> gC m-2 month-1
vegc.mte <- IntegrationDataset(name="cVeg", unit="gC m-2", 
	data.val.file = paste0(path.geodata, "Carvalhais.cVeg.200.720.1.nc"),
	data.unc.file = 1,
	data.time = seq(as.Date("2005-01-01"), as.Date("2010-12-31"), by="year"),
	model.val.file = "vegc.bin",
	xy = grid, AggFun = AggNULLMean, data.factor=NULL, cost=FALSE, CostFunction=SSE, weight=1)
	
	
# make list of IntegrationData
integrationdata <- IntegrationData(mburnt_area.gimms, vegc.mte)
#pdf("out.pdf")
#plot(integrationdata, 1)
#plot(integrationdata, 2)
#dev.off()
	
#--------------------------------------------------
# 5. Define LPJmL prior parameter values and ranges
#--------------------------------------------------

# Depending on your application, you might need to define additional parameters in param_template.par and pft_template.par


# read parameter priors and ranges from *.txt file
#-------------------------------------------------

# It is helpful to save all parameter names, prior values and prior ranges in a Excel table or *.csv file

setwd(path.lpj.fun)
par.df <- read.table("inst_gldas/LPJmL_parameter-table.csv", header=TRUE, sep=",")

# make LPJpar object
lpjpar <- LPJpar(par.prior=par.df$par.prior, par.lower=par.df$par.lower, par.upper=par.df$par.upper, par.pftspecif=par.df$par.pftspecif, par.names=par.df$par.names, correct=TRUE)
pdf("plot.pdf")
plot(lpjpar, "ALPHAA")
plot(lpjpar, "ALBEDO_LEAF")
#plot(lpjpar) #doesnt work yet
dev.off()

#setwd(paste0(path.lpj, "par/"))
#WriteLPJpar(lpjpar, file="LPJmLmdi_test", pft.par=paste0(path.lpj.fun, "inst_gldas/pft_template.js"), param.par=paste0(path.lpj.fun, "inst_gldas/lpjparam_template.js")) 


# select parameters for optimization
#-----------------------------------

# Which parameters should be included in optimization?
par.optim <- c("ALPHA_FUELP_TrBE", "ALPHA_FUELP_TrBR", "ALPHA_FUELP_TrH", "CROWN_MORT_RCK_TrBE", "CROWN_MORT_RCK_TrBR", "SCORCHHEIGHT_F_TrBR", "SCORCHHEIGHT_F_TrBE")

# For which PFTs?
#pft.sel <- c("BoNS", "PoH")
#par.optim <- paste(rep(par.optim, each=length(pft.sel)), pft.sel, sep="_")
#par.optim


#------------------------
# 6. Perform optimization
#------------------------


# do optimization
OptimizeLPJgenoud(xy = grid, 				# matrix of grid cell coordinates to run LPJ
	name = name, 							# name of the experiment (basic file name for all outputs)
	lpjpar = lpjpar,						# see LPJpar
	par.optim = par.optim,			        # names of the parameters in LPJpar that should be optimized
	lpjfiles = lpjfiles,					# see LPJfiles
	copy.input = FALSE, 						# Should LPJmL input data be copied to the directory for temporary output? 
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
 #setwd("/p/projects/biodiversity/drueke/internal_lpjml/out_optim/opt_Example/Opt_test4/Opt_test4_rescue") # directory with rescue files
 #files <- list.files(pattern=".RData") 
 #rescue <- CombineRescueFiles(files, remove=FALSE)
 #pdf("progress.pdf")
 #plot(rescue)
 #dev.off()
