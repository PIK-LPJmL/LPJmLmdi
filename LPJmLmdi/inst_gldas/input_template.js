/**************************************************************************************/
/**                                                                                \n**/
/**       i  n  p  u  t  _  c  r  u  m  o  n  t  h  l  y  .  j  s                  \n**/
/**                                                                                \n**/
/** Configuration file for input dataset for LPJ C Version 4.0.001                 \n**/
/**                                                                                \n**/
/** (C) Potsdam Institute for Climate Impact Research (PIK), see COPYRIGHT file    \n**/
/** authors, and contributors see AUTHORS file                                     \n**/
/** This file is part of LPJmL and licensed under GNU AGPL Version 3               \n**/
/** or later. See LICENSE file or go to http://www.gnu.org/licenses/               \n**/
/** Contact: https://gitlab.pik-potsdam.de/lpjml                                   \n**/
/**                                                                                \n**/
/**************************************************************************************/

#include "include/conf.h" /* include constant definitions */

"input" :
{
  "soil" :         { "fmt" : RAW,  "name" : "SOILCODE_FILE"},
  "coord" :        { "fmt" : CLM,  "name" : "GRID_FILE"},
  "countrycode" :  { "fmt" : CLM,  "name" : "COUNTRY_FILE"},
  "landuse" :      { "fmt" : CLM,  "name" : "LANDUSE_FILE"},
  /* insert prescribed sdate file name here */
  "grassland_fixed_pft" : { "fmt" : RAW, "name" : "/home/rolinski/LPJ/Newinput/scenario_MO0.bin"},
  "lakes" :        { "fmt" : META, "name" : "/p/projects/lpjml/input/historical/input_VERSION2/glwd_lakes_and_rivers.descr"},
  "drainage" :     { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/drainagestn.bin"},
  "neighb_irrig" : { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/neighb_irrig_stn.bin"},
  "elevation" :    { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/elevation.bin"},
  "reservoir" :    { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/reservoir_info_grand5.bin"},
  "temp" :         { "fmt" : CLM,  "name" : "TMP_FILE"},
  "prec" :         { "fmt" : CLM,  "name" : "PRE_FILE"},
  "lwnet" :        { "fmt" : CLM,  "name" : "LWNET_FILE"},
  "swdown" :       { "fmt" : CLM,  "name" : "SWDOWN_FILE"},
  "cloud":         { "fmt" : CLM2,  "name" : "/p/projects/lpjml/input/historical/CRUDATA_TS3_23/cru_ts3.23.1901.2014.cld.dat.clm"},
  "wind":          { "fmt" : CLM,  "name" : "WINDSPEED_FILE"},
  "tamp":          { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/CRUDATA_TS3_23/cru_ts3.23.1901.2014.dtr.dat.clm"}, /* diurnal temp. range */
  "tmin":          { "fmt" : CLM,  "name" : "TMIN_FILE"},
  "tmax":          { "fmt" : CLM,  "name" : "TMAX_FILE"},
  "humid":         { "fmt" : CLM,  "name" : "HUMID_FILE"},
  "lightning":     { "fmt" : CLM,  "name" : "LIGHTNING_FILE"},
  "human_ignition": { "fmt" : CLM, "name" : "HUMANIGN_FILE"},
  "popdens" :      { "fmt" : CLM,  "name" : "POPDENS_FILE"},
  "burntarea" :    { "fmt" : CLM,  "name" : "/p/projects/biodiversity/drueke/mburntarea.clm"},
  "landcover":     { "fmt" : CLM,  "name" : "/data/biosx/mforkel/input_new/landcover_synmap_koeppen_vcf_newPFT_forLPJ_20130910.clm"},/*synmap_koeppen_vcf_NewPFT_adjustedByLanduse_SpinupTransitionPrescribed_forLPJ.clm*/
  "co2" :          { "fmt" : TXT,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/co2_1841-2017.dat"},
  "wetdays" :      { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/CRUDATA_TS3_23/gpcc_v7_cruts3_23_wet_1901_2013.clm"},
  "wateruse" :     { "fmt" : CLM,  "name" : "/p/projects/lpjml/input/historical/input_VERSION2/wateruse_1900_2000.bin" } /* water consumption for industry,household and livestock */
},
