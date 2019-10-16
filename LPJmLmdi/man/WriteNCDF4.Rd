\name{WriteNCDF4}
\alias{WriteNCDF4}
\title{Write NetCDF files}
\description{Writes NetCDF files from rasters and makes sure that meta-information is properly defined.}
\usage{WriteNCDF4(data.l, var.name, var.unit, time = as.Date("2000-01-01"), 
    var.description = var.name, file = NULL, data.name = NA, 
    region.name = NA, file.title = var.name, file.description = var.name, 
    reference = "", provider = "", creator = "", missval = -9999, 
    scale = 1, offset = 0, compression = 9, overwrite = FALSE)}
\arguments{
  \item{data.l}{a single Raster* object or a list of Raster* objects }
  \item{var.name}{vector of variable names}
  \item{var.unit}{vector of variable units}
  \item{time}{vector of time steps for each layer.}
  \item{var.description}{vector of variable descriptions}
  \item{file}{file name. If NULL the file name will be created from the variable name and the dimensions of the data.}
  \item{data.name}{name of the dataset}
  \item{region.name}{name of the region}
  \item{file.title}{title of the file}
  \item{file.description}{description of the file}
  \item{reference}{reference for the dataset}
  \item{provider}{dataset provider}
  \item{creator}{dataset creator}
  \item{missval}{flag for missing/NA values}
  \item{scale}{scaling values for the data}
  \item{offset}{offset value}
  \item{compression}{If set to an integer between 1 (least compression) and 9 (most compression), this enables compression for the variable as it is written to the file. Turning compression on forces the created file to be in netcdf version 4 format, which will not be compatible with older software that only reads netcdf version 3 files.}
  \item{overwrite}{overwrite existing file?}
}



\author{Matthias Forkel <matthias.forkel@geo.tuwien.ac.at> [aut, cre]}





