/**************************************************************************************/
/**                                                                                \n**/
/**                   l  p  j  m  l  .  j  s                                       \n**/
/**                                                                                \n**/
/** Default configuration file for LPJmL C Version 4.0.001                         \n**/
/**                                                                                \n**/
/** Configuration file is divided into five sections:                              \n**/
/**                                                                                \n**/
/**  I.   Simulation description and type section                                  \n**/
/**  II.  Input parameter section                                                  \n**/
/**  III. Input data section                                                       \n**/
/**  IV.  Output data section                                                      \n**/
/**  V.   Run settings section                                                     \n**/
/**                                                                                \n**/
/** (C) Potsdam Institute for Climate Impact Research (PIK), see COPYRIGHT file    \n**/
/** authors, and contributors see AUTHORS file                                     \n**/
/** This file is part of LPJmL and licensed under GNU AGPL Version 3               \n**/
/** or later. See LICENSE file or go to http://www.gnu.org/licenses/               \n**/
/** Contact: https://gitlab.pik-potsdam.de/lpjml                                   \n**/
/**                                                                                \n**/
/**************************************************************************************/

#include "include/conf.h" /* include constant definitions */

#define BENCHMARK_LAI 5 /* also set value here directly (1 to 7), not in /par/lpjparam.js */
#define OUTPATH CELL_OUTPATH
//#define DAILY_OUTPUT  /* enables daily output */

{   /* LPJmL configuration in JSON format */

/*===================================================================*/
/*  I. Simulation description and type section                       */
/*===================================================================*/

  "sim_name" : "LPJmL Run", /* Simulation description */
  "sim_id"   : LPJML,       /* LPJML Simulation type with managed land use */
  "random_prec" : false,     /* Random weather generator for precipitation enabled */
  "random_seed" : 2,        /* seed for random number generator */
  "radiation" : RADIATION,  /* other options: CLOUDINESS, RADIATION, RADIATION_SWONLY, RADIATION_LWDOWN */
  "fire" : SPITFIRE_TMAX,            /* fire disturbance enabled, other options: NO_FIRE, FIRE, SPITFIRE, SPITFIRE_TMAX (for GLDAS input data) */
  "firewood" : false,
  "new_phenology": true,    /* GSI phenology enabled */
  "river_routing" : false,
  "permafrost" : true,
#ifdef FROM_RESTART
  "population" : true,
  "landuse" : LANDUSE, /* other options: NO_LANDUSE, LANDUSE, CONST_LANDUSE, ALL_CROPS */
  "reservoir" : true,
  "wateruse" : true,
#else
  "population" : false,
  "landuse" : NO_LANDUSE,
  "reservoir" : false,
  "wateruse" : false,
#endif
  "prescribe_burntarea" : false,
  "prescribe_landcover" : NO_LANDCOVER, /* NO_LANDCOVER, LANDCOVERFPC, LANCOVEREST */
  "sowing_date_option" : FIXED_SDATE,   /* NO_FIXED_SDATE, FIXED_SDATE, PRESCRIBED_SDATE */
  "irrigation" : LIM_IRRIGATION,        /* NO_IRRIGATION, LIM_IRRIGATION, POT_IRRIGATION, ALL_IRRIGATION */
  "laimax_interpolate" : LAIMAX_CFT,    /* laimax values from manage parameter file, */
                                        /* other options: LAIMAX_CFT, CONST_LAI_MAX, LAIMAX_INTERPOLATE */
  "grassland_fixed_pft" : false,
  
  "landuse_year_const" : 2000,          /* set landuse year for CONST_LANDUSE case */
  "sdate_fixyear" : 1970,               /* year in which sowing dates shall be fixed */
  "intercrop" : true,                   /* intercrops on setaside */
  "remove_residuals" : false,           /* remove residuals */
  "residues_fire" : false,              /* fire in residuals */
  "laimax" : 5,                         /* maximum LAI for CONST_LAI_MAX */


/*===================================================================*/
/*  II. Input parameter section                                      */
/*===================================================================*/

#include "CELL_PARCONF_FILE"    /* Input parameter file */

/*===================================================================*/
/*  III. Input data section                                          */
/*===================================================================*/

#include "CELL_INPUT_FILE"    /* Input files of CRU dataset */

/*===================================================================*/
/*  IV. Output data section                                          */
/*===================================================================*/

#ifdef WITH_GRIDBASED
  "pft_output_scaled" : GRIDBASED,
#define SUFFIX grid.bin
#else
  "pft_output_scaled" : PFTBASED,
#define SUFFIX pft.bin
#endif

#define mkstr(s) xstr(s) /* putting string in quotation marks */
#define xstr(s) #s

  "crop_index" : TEMPERATE_CEREALS,  /* CFT for daily output */
  "crop_irrigation" : DAILY_RAINFED, /* irrigation flag for daily output */

#ifdef FROM_RESTART

  "output" : 
  [
/*
ID                         Fmt                    filename
-------------------------- ---------------------- ----------------------------- */
    { "id" : GRID,             "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/grid.bin" }},
    { "id" : FPC,              "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/fpc.bin"}},
    { "id" : ABURNTAREA,       "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/aburnt_area.bin"}},
    { "id" : MGPP,             "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/mgpp.bin"}},
    { "id" : FIREC,            "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/firec.bin"}},
    { "id" : VEGC,             "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/vegc.bin"}},
    { "id" : SOILC,            "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/soilc.bin"}},
    { "id" : LITC,             "file" : { "fmt" : RAW, "name" : "CELL_OUTPATHlitc.bin"}},
    { "id" : MBURNTAREA,       "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/mburnt_area.bin"}},
    { "id" : MALBEDO,          "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/malbedo.bin"}},
    { "id" : AGB,              "file" : { "fmt" : RAW, "name" : "CELL_OUTPATH/agb.bin"}},
/*------------------------ ---------------------- ------------------------------- */
  ],

#else

  "output" : [],  /* no output written */

#endif

/*===================================================================*/
/*  V. Run settings section                                          */
/*===================================================================*/

    "startgrid" : CELL_START, /*18714,*/  /*7385,*/ /*7841,*/  /* 27410, 67208 60400 all grid cells */
  "endgrid" : CELL_END, /*18714,*/ /*8765,*/  /*7385,*/ /*7841,*/ 

#ifndef FROM_RESTART

  "nspinup" : 5000,  /* spinup years */
  "nspinyear" : 30,  /* cycle length during spinup (yr) */
  "firstyear": YEAR_START, /* first year of simulation */
  "lastyear" : YEAR_START, /* last year of simulation */
  "restart" : false, /* do not start from restart file */
  "write_restart" : true, /* create restart file: the last year of simulation=restart-year */
  "write_restart_filename" : "CELL_RESTART_FILE", /* filename of restart file */
  "restart_year": YEAR_START /* write restart at year */

#else

  "nspinup" : 100,   /* spinup years */
  "nspinyear" : 30,  /* cycle length during spinup (yr)*/
  "firstyear": YEAR_START, /* first year of simulation */
  "lastyear" : YEAR_END, /* last year of simulation */
  "restart" :  true, /* start from restart file */
  "restart_filename" : "CELL_RESTART_FILE", /* filename of restart file */
  "write_restart" : false, /* create restart file */
  "write_restart_filename" : "restart/restart_1900_crop_stdfire.lpj", /* filename of restart file */
  "restart_year": YEAR_START /* write restart at year */

#endif
}
