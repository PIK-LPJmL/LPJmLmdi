/**************************************************************************************/
/**                                                                                \n**/
/**              p  f  t  .  j  s                                                  \n**/
/**                                                                                \n**/
/**  PFT and CFT parameter file for LPJmL version 4.0.001                          \n**/
/**  CFTs parameters must be put after PFTs                                        \n**/
/**                                                                                \n**/
/** (C) Potsdam Institute for Climate Impact Research (PIK), see COPYRIGHT file    \n**/
/** authors, and contributors see AUTHORS file                                     \n**/
/** This file is part of LPJmL and licensed under GNU AGPL Version 3               \n**/
/** or later. See LICENSE file or go to http://www.gnu.org/licenses/               \n**/
/** Contact: https://github.com/PIK-LPJmL/LPJmL                                    \n**/
/**                                                                                \n**/
/**************************************************************************************/

#include "../include/pftpar.h" /* include constant definitions */

#define CTON_LEAF 30.
#define CTON_ROOT 30.
#define CTON_POOL 100.
#define CTON_SO 100.
#define CTON_SAP 330.
#ifdef WITH_SPITFIRE
#define FLAM_TREE 0.3
#define FLAM_GRASS 0.3
#else
#define FLAM_TREE 0.3
#define FLAM_GRASS 0.3
#endif
#define KLITTER10 0.97       /* now only used for crops and value a middle value of C4 grasses; need to be updated with TRY-database*/

#define APREC_MIN 100.0
#define ALLOM1 100.0
#define ALLOM2 40.0
#define ALLOM3 0.67     /*0.5*/
#define ALLOM4 0.3
#define APHEN_MAX 245
#define APHEN_MIN 60    /* minimum aphen for cold-induced senescence */
#define ALPHA_FUELP_TROP 0.0000334
#define ALPHA_FUELP_EXTRATROP 0.0000667
#define HEIGHT_MAX 100.  /* maximum height of trees */
#define REPROD_COST 0.1 /* reproduction cost */
#define K_EST 0.12 /* maximum overall sapling establishment rate (indiv/m2) */
#ifdef WITH_SPITFIRE
#define MORT_MAX 0.03
#else
#define MORT_MAX 0.03
#endif

"pftpar" :
[
  /* first pft */
  {
    "id" : TROPICAL_BROADLEAVED_EVERGREEN_TREE,
    "name" : "tropical broadleaved evergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_TrBE,    /* beta_root */
    "minwscal" : 0.0,       /* minwscal 3*/
    "gmin"  : GMIN_TrBE,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TrBE,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.12,        /* resist 8*/
    "longevity" : LONGEVITY_TrBE,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TrBE,        /* gdd5min 30*/
    "twmax" : TWMAX_TrBE,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TrBE,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TrBE, /* min_temprange 34*/
    "emax": EMAX_TrBE,             /* emax 35*/
    "intc" : INTC_TrBE,          /* intc 36*/
    "alphaa" : ALPHAA_TrBE,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TrBE,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TrBE,    /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TrBE,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TrBE, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TrBE,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TrBE,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TrBE,         /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TrBE           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TrBE,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TrBE,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TrBE           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TrBE,      /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TrBE,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TrBE          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TrBE,       /* new phenology: slope of water limiting function */
      "base": WSCAL_BASE_TrBE,        /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TrBE          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TrBE,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : EVERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TrBE, "high" : TEMP_CO2_HIGH_TrBE }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TrBE, "high" : TEMP_PHOTOS_HIGH_TrBE },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TrBE, "high" : TEMP_HIGH_TrBE }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.38009,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TrBE, /* scaling factor fire danger index */
    "fuelbulkdensity" : 25.0, /* 25 fuel bulk density */
    "emission_factor" : { "co2" : 1580.0, "co" :  103.0, "ch4" : 6.80, "voc" : 8.10, "tpm" : 8.50, "nox" : 1.999}, /* emission factors */
    "aprec_min" : APREC_MIN,  /* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,  /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TrBE, "wood" : K_LITTER10_WOOD_TrBE }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 2.75, /* Q10_wood */
    "windspeed_dampening" : 0.4, /* windspeed dampening */
    "roughness_length" : 2.0,  /* roughness length */
    "leaftype" : BROADLEAVED,  /* leaftype */
    "turnover" : {"leaf" : 2.0, "sapwood" : TURNOVER_SAPWOOD_TrBE, "root" : 2.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_TrBE, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST_TrBE,  /* reproduction cost */
    "allom1" : ALLOM1_TrBE,      /* allometry */
    "allom2" : ALLOM2_TrBE,
    "allom3" : ALLOM3_TrBE,
    "allom4" : ALLOM4_TrBE,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_TrBE, /* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0301, /* bark thickness par1 */
    "barkthick_par2" : 0.0281, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_TrBE, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_TrBE,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 2. pft */
  {
    "id" : TROPICAL_BROADLEAVED_RAINGREEN_TREE,
    "name" : "tropical broadleaved raingreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_TrBR,    /* beta_root */
    "minwscal" : 0.35,      /* minwscal 3*/
    "gmin"  : GMIN_TrBR,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TrBR,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : LONGEVITY_TrBR,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TrBR,        /* gdd5min 30*/
    "twmax" : TWMAX_TrBR,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TrBR,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TrBR, /* min_temprange 34*/
    "emax": EMAX_TrBR,            /* emax 35*/
    "intc" : INTC_TrBE,          /* intc 36*/
    "alphaa" : ALPHAA_TrBR,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TrBR,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TrBR,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TrBR, /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TrBR, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TrBR,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TrBR,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TrBR,        /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TrBR           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TrBR,      /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TrBR,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TrBR           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TrBR,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TrBR,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TrBR           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TrBR,       /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TrBR,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TrBR        /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TrBR,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : RAINGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TrBR, "high" : TEMP_CO2_HIGH_TrBR }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TrBR, "high" : TEMP_PHOTOS_HIGH_TrBR },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TrBR, "high" : TEMP_HIGH_TrBR }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.51395,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TrBR, /* scaling factor fire danger index */
    "fuelbulkdensity" : 13.0, /* 13 fuel bulk density */
    "emission_factor" : { "co2" : 1664.0, "co" :  63.0, "ch4" : 2.20, "voc" : 3.40, "tpm" : 8.50, "nox" : 2.540}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TrBR, "wood" : K_LITTER10_WOOD_TrBR }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 2.75, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 2.0,  /* roughness length */
    "leaftype" : BROADLEAVED,  /* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : TURNOVER_SAPWOOD_TrBR, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_TrBR, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST_TrBR, /* reproduction cost */
    "allom1" : ALLOM1_TrBR,      /* allometry */
    "allom2" : ALLOM2_TrBR,
    "allom3" : ALLOM3_TrBR,
    "allom4" : ALLOM4_TrBR,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_TrBR, /* scorch height (F) */
    "crownlength" : 0.10, /* crown length (CL) */
    "barkthick_par1" : 0.1085, /* bark thickness par1 */
    "barkthick_par2" : 0.2120, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_TrBR, /* 0.05 crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_TrBR,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*---------------------------------------------------------------------------------------------*/
/* 3. pft */
  {
    "id" : TEMPERATE_NEEDLELEAVED_EVERGREEN_TREE,
    "name": "temperate needleleaved evergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_TeNE,    /* beta_root 1 */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_TeNE,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TeNE,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.12,        /* resist 8*/
    "longevity" : LONGEVITY_TeNE,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TeNE,      /* gdd5min 30*/
    "twmax" : TWMAX_TeNE,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TeNE,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TeNE, /* min_temprange 34*/
    "emax": EMAX_TeNE,            /* emax 35*/
    "intc" : INTC_TeNE,          /* intc 36*/
    "alphaa" : ALPHAA_TeNE,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TeNE,  /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TeNE,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TeNE,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TeNE, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TeNE,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TeNE,     /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TeNE,      /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TeNE           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TeNE,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TeNE,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TeNE           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TeNE,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TeNE,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TeNE           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TeNE,          /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TeNE,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TeNE           /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TeNE,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : EVERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TeNE, "high" : TEMP_CO2_HIGH_TeNE }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TeNE, "high" : TEMP_PHOTOS_HIGH_TeNE },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TeNE, "high" : TEMP_HIGH_TeNE }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.32198,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TeNE, /* scaling factor fire danger index */
    "fuelbulkdensity" : 25.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TeNE, "wood" : K_LITTER10_WOOD_TeNE }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.97, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0,     /* roughness length */
    "leaftype" : NEEDLELEAVED,/* leaftype */
    "turnover" : {"leaf" : 4.0, "sapwood" : TURNOVER_SAPWOOD_TeNE, "root" : 4.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_TeNE, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST_TeNE, /* reproduction cost */
    "allom1" : ALLOM1_TeNE,      /* allometry */
    "allom2" : ALLOM2_TeNE,
    "allom3" : ALLOM3_TeNE,
    "allom4" : ALLOM4_TeNE,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_TeNE,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0367, /* bark thickness par1 */
    "barkthick_par2" : 0.0592, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_TeNE, /* crown damage (rCK) */
    "crown_mort_p" : 3.75,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_TeNE,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 4. pft */
  {
    "id" : TEMPERATE_BROADLEAVED_EVERGREEN_TREE,
    "name" : "temperate broadleaved evergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_TeBE,    /* beta_root 1 */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_TeBE,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TeBE,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : LONGEVITY_TeBE,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TeBE,     /* gdd5min 30*/
    "twmax" : TWMAX_TeBE,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TeBE,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TeBE, /* min_temprange 34*/
    "emax": EMAX_TeBE,            /* emax 35*/
    "intc" : INTC_TeBE,          /* intc 36*/
    "alphaa" : ALPHAA_TeBE,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TeBE,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TeBE,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TeBE,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TeBE, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TeBE,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TeBE,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TeBE,     /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TeBE           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TeBE,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TeBE,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TeBE           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TeBE,      /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TeBE,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TeBE           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TeBE,          /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TeBE,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TeBE          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TeBE,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : EVERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TeBE, "high" : TEMP_CO2_HIGH_TeBE }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TeBE, "high" : TEMP_PHOTOS_HIGH_TeBE },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TeBE, "high" : TEMP_HIGH_TeBE }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.43740,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TeBE, /* scaling factor fire danger index */
    "fuelbulkdensity" : 22.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TeBE, "wood" : K_LITTER10_WOOD_TeBE }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.37, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0, /* roughness length */
    "leaftype" : BROADLEAVED,/* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : TURNOVER_SAPWOOD_TeBE, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_TeBE, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST_TeBE, /* reproduction cost */
    "allom1" : ALLOM1_TeBE,      /* allometry */
    "allom2" : ALLOM2_TeBE,
    "allom3" : ALLOM3_TeBE,
    "allom4" : ALLOM4_TeBE,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_TeBE,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0451, /* bark thickness par1 */
    "barkthick_par2" : 0.1412, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_TeBE, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_TeBE,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 5. pft */
  {
    "id" : TEMPERATE_BROADLEAVED_SUMMERGREEN_TREE,
    "name" : "temperate broadleaved summergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_TeBS,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_TeBS,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TeBS,      /* respcoeff 5*/
    "nmax" : 120.,          /* nmax 7*/
    "resist" : 0.3,         /* resist 8*/
    "longevity" : LONGEVITY_TeBS,     /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 300.,          /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TeBS,     /* gdd5min 30*/
    "twmax" : TWMAX_TeBS,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TeBS,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TeBS, /* min_temprange 34*/
    "emax": EMAX_TeBS,            /* emax 35*/
    "intc" : INTC_TeBS,          /* intc 36*/
    "alphaa" : ALPHAA_TeBS,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TeBS,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TeBS,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TeBS,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TeBS, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TeBS,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TeBS,     /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TeBS,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TeBS           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TeBS,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TeBS,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TeBS           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TeBS,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TeBS,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TeBS           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TeBS,       /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TeBS,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TeBS           /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TeBS,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : SUMMERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TeBS, "high" : TEMP_CO2_HIGH_TeBS }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TeBS, "high" : TEMP_PHOTOS_HIGH_TeBS },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TeBS, "high" : TEMP_HIGH_TeBS }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.28880,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TeBS, /* scaling factor fire danger index */
    "fuelbulkdensity" : 22.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TeBS, "wood" : K_LITTER10_WOOD_TeBS }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.37, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0, /* roughness length */
    "leaftype" : BROADLEAVED,/* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : TURNOVER_SAPWOOD_TeBS, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_TeBS, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "aphen_min" : APHEN_MIN,
    "aphen_max" : APHEN_MAX,
    "reprod_cost" : REPROD_COST_TeBS, /* reproduction cost */
    "allom1" : ALLOM1_TeBS,      /* allometry */
    "allom2" : ALLOM2_TeBS,
    "allom3" : ALLOM3_TeBS,
    "allom4" : ALLOM4_TeBS,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_TeBS,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0347, /* bark thickness par1 */
    "barkthick_par2" : 0.1086, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_TeBS, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_TeBS,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 6. pft */
  {
    "id" : BOREAL_NEEDLELEAVED_EVERGREEN_TREE,
    "name" : "boreal needleleaved evergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_BoNE,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_BoNE,          /* gmin 4*/
    "respcoeff" : 1.2,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.12,        /* resist 8*/
    "longevity" : LONGEVITY_BoNE,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_BoNE,      /* gdd5min 30*/
    "twmax" : TWMAX_BoNE,          /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_BoNE,    /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_BoNE, /* min_temprange 34*/
    "emax": EMAX_BoNE,            /* emax 35*/
    "intc" : INTC_BoNE,          /* intc 36*/
    "alphaa" : ALPHAA_BoNE,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_BoNE,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_BoNE,    /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_BoNE,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_BoNE, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_BoNE,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_BoNE,     /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_BoNE,      /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_BoNE           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_BoNE,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_BoNE,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_BoNE           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_BoNE,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_BoNE,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_BoNE           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_BoNE,          /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_BoNE,    /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_BoNE           /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_BoNE,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : EVERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_BoNE, "high" : TEMP_CO2_HIGH_BoNE }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_BoNE, "high" : TEMP_PHOTOS_HIGH_BoNE },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_BoNE, "high" : TEMP_HIGH_BoNE }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.28670,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_BoNE, /* scaling factor fire danger index */
    "fuelbulkdensity" : 25.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_BoNE, "wood" : K_LITTER10_WOOD_BoNE }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.97, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0, /* roughness length */
    "leaftype" : NEEDLELEAVED,/* leaftype */
    "turnover" : {"leaf" : 4.0, "sapwood" : TURNOVER_SAPWOOD_BoNE, "root" : 4.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_BoNE, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST_BoNE, /* reproduction cost */
    "allom1" : ALLOM1_BoNE,      /* allometry */
    "allom2" : ALLOM2_BoNE,
    "allom3" : ALLOM3_BoNE,
    "allom4" : ALLOM4_BoNE,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_BoNE,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0292, /* bark thickness par1 */
    "barkthick_par2" : 0.2632, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_BoNE, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_BoNE,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 7. pft */
  {
    "id" : BOREAL_BROADLEAVED_SUMMERGREEN_TREE,
    "name" : "boreal broadleaved summergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_BoBS,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_BoBS,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_BoBS,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.3,         /* resist 8*/
    "longevity" : LONGEVITY_BoBS,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 200.,          /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_BoBS,      /* gdd5min 30*/
    "twmax" : TWMAX_BoBS,          /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_BoBS,    /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_BoBS, /* min_temprange 34*/
    "emax": EMAX_BoBS,            /* emax 35*/
    "intc" : INTC_BoBS,          /* intc 36*/
    "alphaa" : ALPHAA_BoBS,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_BoBS,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_BoBS,    /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_BoBS,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_BoBS,/* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_BoBS,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_BoBS,     /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_BoBS,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_BoBS           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_BoBS,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_BoBS,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_BoBS           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_BoBS,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_BoBS,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_BoBS           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_BoBS,       /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_BoBS,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_BoBS           /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_BoBS,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : SUMMERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_BoBS, "high" : TEMP_CO2_HIGH_BoBS }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_BoBS, "high" : TEMP_PHOTOS_HIGH_BoBS },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_BoBS, "high" : TEMP_HIGH_BoBS }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.28670,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_BoBS, /* scaling factor fire danger index */
    "fuelbulkdensity" : 22.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_BoBS, "wood" : K_LITTER10_WOOD_BoBS }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.37, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0,     /* roughness length */
    "leaftype" : BROADLEAVED,/* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : TURNOVER_SAPWOOD_BoBS, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_BoBS, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "aphen_min" : APHEN_MIN,
    "aphen_max" : APHEN_MAX,
    "reprod_cost" : REPROD_COST_BoBS, /* reproduction cost */
    "allom1" : ALLOM1_BoBS,      /* allometry */
    "allom2" : ALLOM2_BoBS,
    "allom3" : ALLOM3_BoBS,
    "allom4" : ALLOM4_BoBS,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_BoBS,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0347, /* bark thickness par1 */
    "barkthick_par2" : 0.1086, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_BoBS, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_BoBS,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 8. pft */
  {
    "id" : BOREAL_NEEDLELEAVED_SUMMERGREEN_TREE,
    "name" : "boreal needleleaved summergreen tree",
    "type" : TREE,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : BETA_ROOT_BoNS,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : GMIN_BoNS,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_BoNS,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.12,        /* resist 8*/
    "longevity" : LONGEVITY_BoNS,     /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 200.,          /* ramp 19*/
    "lai_sapl" : 1.500,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_BoNS,      /* gdd5min 30*/
    "twmax" : TWMAX_BoNS,          /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_BoNS,    /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_BoNS,  /* min_temprange 34*/
    "emax": EMAX_BoNS,            /* emax 35*/
    "intc" : INTC_BoNS,          /* intc 36*/
    "alphaa" : ALPHAA_BoNS,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_BoNS,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_BoNS,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_BoNS, /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_BoNS,/* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_BoNS,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_BoNS,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_BoNS,      /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_BoNS           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_BoNS,        /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_BoNS,         /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_BoNS            /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_BoNS,          /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_BoNS,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_BoNS            /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_BoNS,           /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_BoNS,        /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_BoNS            /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_BoNS,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : SUMMERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_BoNS, "high" : TEMP_CO2_HIGH_BoNS }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_BoNS, "high" : TEMP_PHOTOS_HIGH_BoNS },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_BoNS, "high" : TEMP_HIGH_BoNS }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.28670,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_BoNS, /* scaling factor fire danger index */
    "fuelbulkdensity" : 22.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : 0.76, "wood" : 0.041 }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.97, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0,     /* roughness length */
    "leaftype" : NEEDLELEAVED,/* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : TURNOVER_SAPWOOD_BoNS, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : CROWNAREA_MAX_BoNS, /* crownarea_max 20*/
    "wood_sapl" : 1.2,      /* sapwood sapling 22*/
    "aphen_min" : 10,
    "aphen_max" : 200,
    "reprod_cost" : REPROD_COST_BoNS, /* reproduction cost */
    "allom1" : ALLOM1_BoNS,      /* allometry */
    "allom2" : ALLOM2_BoNS,
    "allom3" : ALLOM3_BoNS,
    "allom4" : ALLOM4_BoNS,
    "height_max" : HEIGHT_MAX, /* maximum height of tree */
    "scorchheight_f_param" : SCORCHHEIGHT_F_BoNS,/* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0347, /* bark thickness par1 */
    "barkthick_par2" : 0.1086, /* bark thickness par2 */
    "crown_mort_rck" : CROWN_MORT_RCK_BoNS, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est": K_EST_BoNS,         /* k_est */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 9. pft */
  {
    "id" : TROPICAL_HERBACEOUS,
    "name" : "Tropical C4 grass",
    "type" : GRASS,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [39., 61., 74., 80.], /* curve number */
    "beta_root" : BETA_ROOT_TrH,    /* beta_root */
    "minwscal" : 0.20,      /* minwscal 3*/
    "gmin"  : GMIN_TrH,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TrH,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.01,        /* resist 8*/
    "longevity" : LONGEVITY_TrH,      /* leaf longevity 10*/
    "lmro_ratio" : 0.6,     /* lmro_ratio 18*/
    "ramp" : 100.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TrH,        /* gdd5min 30*/
    "twmax" : TWMAX_TrH,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TrH,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TrH,/* min_temprange 34*/
    "emax": EMAX_TrH,            /* emax 35*/
    "intc" : INTC_TrH,          /* intc 36*/
    "alphaa" : ALPHAA_TrH,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TrH,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TrH,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TrH,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TrH, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TrH,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TrH,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TrH,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TrH           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TrH,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TrH,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TrH           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TrH,      /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TrH,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TrH           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TrH,        /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TrH,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TrH          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TrH,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : ANY,      /* phenology */
    "path" : C4,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TrH, "high" : TEMP_CO2_HIGH_TrH }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TrH, "high" : TEMP_PHOTOS_HIGH_TrH },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TrH, "high" : TEMP_HIGH_TrH }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.46513,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TrH, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1664.0, "co" :  63.0, "ch4" : 2.20, "voc" : 3.40, "tpm" : 8.50, "nox" : 2.540}, /* emission factors */
    "aprec_min" : 100,                        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TrH, "wood" : K_LITTER10_WOOD_TrH }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1., /* Q10_wood */
    "windspeed_dampening" : 0.6,/* windspeed dampening */
    "roughness_length" : 0.03,  /* roughness length */
    "turnover" : {"leaf" : 1.0, "root" : 2.0}, /* turnover leaf  root 9 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, and root 13,15*/
    "reprod_cost" : REPROD_COST_TrH /* reproduction cost */
  },
/*--------------------------------------------------------------------------*/
/* 10. pft */
  {
    "id" : TEMPERATE_HERBACEOUS,
    "name" : "Temperate C3 grass",
    "type" : GRASS,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [39., 61., 74., 80.], /* curve number */
    "beta_root" : BETA_ROOT_TeH,    /* beta_root */
    "minwscal" : 0.20,      /* minwscal 3*/
    "gmin"  : GMIN_TeH,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_TeH,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.01,        /* resist 8*/
    "longevity" : LONGEVITY_TeH,     /* leaf longevity 10*/
    "lmro_ratio" : 0.6,     /* lmro_ratio 18*/
    "ramp" : 100.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_TeH,        /* gdd5min 30*/
    "twmax" : TWMAX_TeH,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_TeH,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_TeH,/* min_temprange 34*/
    "emax": EMAX_TeH,            /* emax 35*/
    "intc" : INTC_TeH,          /* intc 36*/
    "alphaa" : ALPHAA_TeH,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_TeH,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_TeH,   /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_TeH,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_TeH, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_TeH,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_TeH,     /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_TeH,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_TeH       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_TeH,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_TeH,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_TeH           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_TeH,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_TeH,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_TeH         /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_TeH,     /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_TeH,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_TeH       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_TeH,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : ANY,      /* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_TeH, "high" : TEMP_CO2_HIGH_TeH }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_TeH, "high" : TEMP_PHOTOS_HIGH_TeH },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_TeH, "high" : TEMP_HIGH_TeH }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.38184,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TeH, /* scaling factor fire danger index */
    "fuelbulkdensity" : 4.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 100,       /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_TrH, "wood" : K_LITTER10_WOOD_TrH }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1., /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "turnover" : {"leaf" : 1.0, "root" : 2.0}, /* turnover leaf  root 9 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, and root 13,15*/
    "reprod_cost" : REPROD_COST_TrH /* reproduction cost */
  },
/*--------------------------------------------------------------------------*/
/* 11. pft */
  {
    "id" : POLAR_HERBACEOUS,
    "name" : "Polar C3 grass",
    "type" : GRASS,
    "cultivation_type" : NONE, /* cultivation_type */
    "cn" : [39., 61., 74., 80.], /* curve number */
    "beta_root" : BETA_ROOT_PoH,    /* beta_root */
    "minwscal" : 0.20,      /* minwscal 3*/
    "gmin"  : GMIN_PoH,          /* gmin 4*/
    "respcoeff" : RESPCOEFF_PoH,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.01,        /* resist 8*/
    "longevity" : LONGEVITY_PoH,     /* leaf longevity 10*/
    "lmro_ratio" : 0.6,     /* lmro_ratio 18*/
    "ramp" : 100.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : GDD5MIN_PoH,       /* gdd5min 30*/
    "twmax" : TWMAX_PoH,        /* twmax 31*/
    "twmax_daily" : TWMAX_DAILY_PoH,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : MIN_TEMPRANGE_PoH,  /* min_temprange 34*/
    "emax": EMAX_PoH,            /* emax 35*/
    "intc" : INTC_PoH,          /* intc 36*/
    "alphaa" : ALPHAA_PoH,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : ALBEDO_LEAF_PoH,   /* albedo of green leaves */
    "albedo_stem" : ALBEDO_STEM_PoH,    /* albedo of stems */
    "albedo_litter" : ALBEDO_LITTER_PoH,  /* albedo of litter */
    "snowcanopyfrac" : SNOWCANOPYFRAC_PoH, /* maximum snow coverage in green canopy */
    "lightextcoeff" : LIGHTEXTCOEFF_PoH,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : TMIN_SLOPE_PoH,       /* new phenology: slope of cold-temperature limiting function */
      "base" : TMIN_BASE_PoH,        /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : TMIN_TAU_PoH           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : TMAX_SLOPE_PoH,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : TMAX_BASE_PoH,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : TMAX_TAU_PoH           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : LIGHT_SLOPE_PoH,         /* new phenology: slope of light limiting function */
      "base" : LIGHT_BASE_PoH,          /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : LIGHT_TAU_PoH          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : WSCAL_SLOPE_PoH,       /* new phenology: slope of water limiting function */
      "base" : WSCAL_BASE_PoH,           /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : WSCAL_TAU_PoH          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX_PoH,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : ANY,      /* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : TEMP_CO2_LOW_PoH, "high" : TEMP_CO2_HIGH_PoH }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : TEMP_PHOTOS_LOW_PoH, "high" : TEMP_PHOTOS_HIGH_PoH },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : TEMP_LOW_PoH, "high" : TEMP_HIGH_PoH }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.38184,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_PoH, /* scaling factor fire danger index */
    "fuelbulkdensity" : 4.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,     /* flam */
    "k_litter10" : { "leaf" : K_LITTER10_LEAF_PoH, "wood" : K_LITTER10_WOOD_PoH }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1., /* Q10_wood */
    "windspeed_dampening" : 0.6,  /* windspeed dampening */
    "roughness_length" : 0.03,    /* roughness length */
    "turnover" : {"leaf" : 1.0, "root" : 2.0}, /* turnover leaf  root 9 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, and root 13,15*/
    "reprod_cost" : REPROD_COST_PoH /* reproduction cost */
  },
/*----------------------------------------------------------------------------------------*/
/* 1. bft */
  {
    "id" : BIOENERGY_TROPICAL_TREE,
    "name" : "bioenergy tropical tree",
    "type" : TREE,
    "cultivation_type" : BIOMASS,/* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : 0.975,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : 0.2,          /* gmin 4*/
    "respcoeff" : 0.2,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 1.0,         /* resist 8*/
    "longevity" : 2.0,      /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 1000.,         /* ramp 19*/
    "lai_sapl" : 1.6,       /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 7.0,            /* emax 35*/
    "intc" : 0.02,          /* intc 36*/
    "alphaa" : 0.8,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.13,   /* albedo of green leaves */
    "albedo_stem" : 0.04,   /* albedo of stems */
    "albedo_litter" : 0.1,  /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.6,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 1.01,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 8.3,         /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.86,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 38.64,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 77.17,      /* new phenology: slope of light limiting function */
      "base" : 55.53,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.52          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 5.14,       /* new phenology: slope of water limiting function */
      "base" : 4.997,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.44          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : 0.005,     /* asymptotic maximum mortality rate (1/year) */
    "phenology" : EVERGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 2.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 25., "high" : 38. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : 7.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.38009,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 13.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1664.0, "co" :  63.0, "ch4" : 2.20, "voc" : 3.40, "tpm" : 8.50, "nox" : 2.540}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : 0.93, "wood" : 0.039 }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 2.75, /* Q10_wood */
    "windspeed_dampening" : 0.4, /* windspeed dampening */
    "roughness_length" : 1.0,/* roughness length */
    "leaftype" : BROADLEAVED,/* leaftype */
    "turnover" : {"leaf" : 2.0, "sapwood" : 10.0, "root" : 2.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : 2.0,  /* crownarea_max 20*/
    "wood_sapl" : 2.2,      /* sapwood sapling 22*/
    "reprod_cost" : REPROD_COST, /* reproduction cost */
    "allom1" : 110,         /* allometry */
    "allom2" : 35,
    "allom3" : 0.75,
    "allom4" : ALLOM4,
    "height_max" : 8,       /* maximum height of tree */
    "scorchheight_f_param" : 0.061,/* scorch height (F) */
    "crownlength" : 0.10 , /* crown length (CL) */
    "barkthick_par1" : 0.1085, /* bark thickness par1 */
    "barkthick_par2" : 0.2120, /* bark thickness par2 */
    "crown_mort_rck" : 0.05, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est" : 0.5,          /* k_est,  Giardina, 2002 */
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 2. bft */
  {
    "id" : BIOENERGY_TEMPERATE_TREE,
    "name" : "bioenergy temperate tree",
    "type" : TREE,
    "cultivation_type" : BIOMASS,/* cultivation_type */
    "cn" : [30., 55., 70., 77.], /* curve number */
    "beta_root" : 0.966,    /* beta_root */
    "minwscal" : 0.00,      /* minwscal 3*/
    "gmin"  : 0.2,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 120.,          /* nmax 7*/
    "resist" : 0.95,        /* resist 8*/
    "longevity" : 0.45,     /* leaf longevity 10*/
    "lmro_ratio" : 1.0,     /* lmro_ratio 18*/
    "ramp" : 300.,          /* ramp 19*/
    "lai_sapl" : 1.6,       /* lai_sapl 2.1, larger sapling used for plantations, original value 1.5  */
    "gdd5min" : 300.0,      /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 5.0,            /* emax 35*/
    "intc" : 0.02,          /* intc 36*/
    "alphaa" : 0.8,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.14,   /* albedo of green leaves */
    "albedo_stem" : 0.04,   /* albedo of stems */
    "albedo_litter" : 0.1,  /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.6,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.2153,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 5,           /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.74,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 41.51,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 58,         /* new phenology: slope of light limiting function */
      "base" : 59.78,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 5.24,       /* new phenology: slope of water limiting function */
      "base" : 20.96,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.8           /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : 0.005,     /* asymptotic maximum mortality rate (1/year) */
    "phenology" : SUMMERGREEN, /* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : -4.0, "high" : 38.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 15., "high" : 30. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -30.0, "high" : 8 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.28880,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_EXTRATROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 22.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_TREE,     /* flam */
    "k_litter10" : { "leaf" : 0.95, "wood" : 0.104 }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1.37, /* Q10_wood */
    "windspeed_dampening" : 0.4,  /* windspeed dampening */
    "roughness_length" : 1.0,     /* roughness length */
    "leaftype" : BROADLEAVED,/* leaftype */
    "turnover" : {"leaf" : 1.0, "sapwood" : 10.0, "root" : 1.0}, /* turnover leaf  sapwood root 9 11 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "sapwood" :  CTON_SAP, "root" : CTON_ROOT}, /* C:N mass ratio for leaf, sapwood, and root 13,14,15*/
    "crownarea_max" : 1.5,  /* crownarea_max 20*/
    "wood_sapl" : 2.5,      /* sapwood sapling 22*/
    "aphen_min" : APHEN_MIN,
    "aphen_max" : APHEN_MAX,
    "reprod_cost" : REPROD_COST, /* reproduction cost */
    "allom1" : 110,         /* allometry */
    "allom2" : 35,
    "allom3" : 0.75,
    "allom4" : ALLOM4,
    "height_max" : 8,       /* maximum height of tree */
    "scorchheight_f_param" : 0.0940, /* scorch height (F) */
    "crownlength" : 0.3334, /* crown length (CL) */
    "barkthick_par1" : 0.0347, /* bark thickness par1 */
    "barkthick_par2" : 0.1086, /* bark thickness par2 */
    "crown_mort_rck" : 1.0, /* crown damage (rCK) */
    "crown_mort_p" : 3.00,  /* crown damage (p)     */
    "fuelfraction" : [0.045,0.075,0.21,0.67], /* fuel fraction */
    "k_est" : 0.8,          /* k_est TIM 1.5*/
    "rotation" : 8,         /* rotation */
    "max_rotation_length" : 40 /* max_rotation_length */
  },
/*--------------------------------------------------------------------------*/
/* 3. bft ONLY FOR BIOENERGY*/
  {
    "id" : BIOENERGY_C4_GRASS,
    "name" : "bioenergy C4 grass",
    "type" : GRASS,
    "cultivation_type" : BIOMASS, /* cultivation_type */
    "cn" : [39., 61., 74., 80.], /* curve number */
    "beta_root" : 0.972,    /* beta_root */
    "minwscal" : 0.20,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 0.2,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 1.0,         /* resist 8*/
    "longevity" : 0.25,     /* leaf longevity 10*/
    "lmro_ratio" : 0.75,   /* lmro_ratio 18*/
    "ramp" : 100.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 5.0,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 7.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 0.8,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.21,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.1,  /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.6,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : ANY,      /* phenology */
    "path" : C4,            /* pathway */
    "temp_co2" : { "low" : 4.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 15., "high" : 45. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -40.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.46513,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_EXTRATROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1664.0, "co" :  63.0, "ch4" : 2.20, "voc" : 3.40, "tpm" : 8.50, "nox" : 2.540}, /* emission factors */
    "aprec_min" : APREC_MIN,/* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,     /* flam */
    "k_litter10" : { "leaf" : 0.97, "wood" : 0.97 }, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1., /* Q10_wood */
    "windspeed_dampening" : 0.6,/* windspeed dampening */
    "roughness_length" : 0.03,  /* roughness length */
    "turnover" : {"leaf" : 1.0, "root" : 2.0}, /* turnover leaf  root 9 12*/
    "cn_ratio" : {"leaf" : CTON_LEAF, "root" : CTON_ROOT}, /* C:N mass ratio for leaf and root 13,15*/
    "reprod_cost" : REPROD_COST /* reproduction cost */
  },
/*--------------------------------------------------------------------------*/
/* 1. cft */
  {
    "id" : TEMPERATE_CEREALS,
    "name" : "temperate cereals",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.0001,    /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 0.0,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22,         /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 0.0, "high" : 40.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 12., "high" : 17. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03, /* roughness length */
    "calcmethod_sdate" : TEMP_WTYP_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 258, "sdatesh" : 90, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 330,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 12, "temp_spring" :  5, "temp_vern" : 12, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 3, "high" : 10 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 8,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 20,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 1700.0,  "high" : 2876.9}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1000.0,  "high" : 2648.4}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 0.0, "high" :  0.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.05,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.45,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.7,        /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 2.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.50,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.20,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 2. cft */
  {
    "id" : RICE,
    "name" : "rice",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.33,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 10.,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 6.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 20., "high" : 45. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 100, "sdatesh" : 180, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 180,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  18, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 24,              /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 0,               /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1600.0,  "high" : 1800.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 10.0, "high" :  10.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.10,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.80,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.50,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.25,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 3. cft */
  {
    "id" : MAIZE,
    "name" : "maize",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.33,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 6.,         /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C4,            /* pathway */
    "temp_co2" : { "low" : 8.0, "high" : 42.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 21., "high" : 26. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6,  /* windspeed dampening */
    "roughness_length" : 0.03,    /* roughness length */
    "calcmethod_sdate" : TEMP_PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 1, "sdatesh" : 181, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 240,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  14, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1600.0,  "high" : 1600.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 5.0, "high" :  15.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.10,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.75,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 4.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.50,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.30,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 4. cft */
  {
    "id" : TROPICAL_CEREALS,
    "name" : "tropical cereals",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 10.,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C4,            /* pathway */
    "temp_co2" : { "low" : 6.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 20., "high" : 45. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 80, "sdatesh" : 260, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 240,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  12, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1500.0,  "high" : 1500.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 10.0, "high" :  10.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.85,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.25,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.10,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 5. cft */
  {
    "id" : PULSES,          /* re-parameterized as field peas, swatusermanual2000.pdf, CM 4.2.2009 */
    "name" : "pulses",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 1.,         /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : -4.0, "high" : 45.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 10., "high" : 30. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : TEMP_PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 1, "sdatesh" : 181, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 300,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  10, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 2000.0,  "high" : 2000.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 1.0, "high" :  1.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.90,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 4.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 4.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.45,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.10,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 6. cft */
  {
    "id" : TEMPERATE_ROOTS,
    "name": "temperate roots",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 3.,         /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : -4.0, "high" : 45.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 10., "high" : 30. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6,   /* windspeed dampening */
    "roughness_length" : 0.03,     /* roughness length */
    "calcmethod_sdate" : TEMP_STYP_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 90, "sdatesh" : 270, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 260,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  8, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 2700.0,  "high" : 2700.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 3.0, "high" :  3.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.75,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.75, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 3.5,          /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 1.25,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 0.5, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 7. cft */
  {
    "id" : TROPICAL_ROOTS,
    "name" : "tropical roots", /* re-parameterized as Cassava, 14.12.2009 KW */
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 15.,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 6.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 20., "high" : 45. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 80, "sdatesh" :  180, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 330,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  22, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 2000.0,  "high" : 2000.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 15.0, "high" :  15.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.75,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.75, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 2.0,          /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 1.10,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 0.5, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 8. cft */
  {
    "id" : OIL_CROPS_SUNFLOWER,
    "name" : "oil crops sunflower",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.3,       /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.33,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 6.,         /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" : 
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 8.0, "high" : 42.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 25., "high" : 32. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : TEMP_STYP_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 1, "sdatesh" :  181, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 240,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  13, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1000.0,  "high" : 1600.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 2460,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 6.0, "high" :  6.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.70,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.40,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.20,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 9. cft */
  {
    "id" : OIL_CROPS_SOYBEAN,
    "name" : "oil crops soybean",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.66,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 10.,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 5.0, "high" : 45.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 28., "high" : 32. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 140, "sdatesh" :  320, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 240,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  13, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1000.0,  "high" : 1000.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 10.0, "high" :  10.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.05,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.70,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.40,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.10,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 0.5, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 10. cft */
  {
    "id" : OIL_CROPS_GROUNDNUT,
    "name": "oil crops groundnut",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.5,      /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 14.,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 6.0, "high" : 55.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 20., "high" : 45. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 100, "sdatesh" :  280, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 240,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 30,     /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  15, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1500.0,  "high" : 1500.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 14.0, "high" :  14.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.15,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.75,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 5.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 5.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.40,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.30,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 0.5, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 11. cft */
  {
    "id" : OIL_CROPS_RAPESEED,
    "name" : "oil crops rapeseed",
    "type" : CROP,
    "cultivation_type" : ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 1.0,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.41,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 0.,         /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.3111,     /* new phenology: slope of cold-temperature limiting function */
      "base" : 4.979,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.01011       /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 0.24,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 32.04,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 23,         /* new phenology: slope of light limiting function */
      "base" : 75.94,       /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.22          /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.5222,     /* new phenology: slope of water limiting function */
      "base" : 53.07,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.01001       /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C3,            /* pathway */
    "temp_co2" : { "low" : 0.0, "high" : 40.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 12., "high" : 17. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : TEMP_WTYP_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 241, "sdatesh" :  61, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 210,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 0,      /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 17, "temp_spring" :  5, "temp_vern" : 12, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 3, "high" : 10 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 8,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 20,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 2100.0,  "high" : 3279.7}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 1000.0,  "high" : 2648.4}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,        /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 0.0, "high" :  0.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.05,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.50,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.85,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.00, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 7.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 7.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.30,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.15,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  },
/*--------------------------------------------------------------------------*/
/* 12. cft */
  {
    "id" : SUGARCANE,
    "name" : "sugarcane",
    "type" : CROP,
    "cultivation_type": ANNUAL_CROP, /* cultivation_type */
    "cn" : [60., 72., 80., 84.], /* curve number */
    "beta_root" : 0.969,    /* beta_root */
    "minwscal" : 0.30,      /* minwscal 3*/
    "gmin"  : 0.5,          /* gmin 4*/
    "respcoeff" : 0.2,      /* respcoeff 5*/
    "nmax" : 100.,          /* nmax 7*/
    "resist" : 0.5,         /* resist 8*/
    "longevity" : 0.66,     /* leaf longevity 10*/
    "lmro_ratio" : 1.5,     /* lmro_ratio 18*/
    "ramp" : 500.,          /* ramp 19*/
    "lai_sapl" : 0.001,     /* lai_sapl 21*/
    "gdd5min" : 0.0,        /* gdd5min 30*/
    "twmax" : 1000.,        /* twmax 31*/
    "twmax_daily" : 1000.,  /* twmax_daily 31*/
    "gddbase" : 6.0,        /* gddbase (deg C) 33*/
    "min_temprange" : -1000.,/* min_temprange 34*/
    "emax": 8.0,            /* emax 35*/
    "intc" : 0.01,          /* intc 36*/
    "alphaa" : 1.0,         /* alphaa, fraction of PAR assimilated at ecosystem level, relative to leaf level */
    "albedo_leaf" : 0.18,   /* albedo of green leaves */
    "albedo_stem" : 0.15,   /* albedo of stems */
    "albedo_litter" : 0.06, /* albedo of litter */
    "snowcanopyfrac" : 0.4, /* maximum snow coverage in green canopy */
    "lightextcoeff" : 0.5,  /* lightextcoeff, light extinction coeffcient in Lambert-Beer equation */
    "tmin" :
    {
      "slope" : 0.91,       /* new phenology: slope of cold-temperature limiting function */
      "base" : 6.418,       /* new phenology: inflection point of cold-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day cold-temperature limiting fct */
    },
    "tmax" :
    {
      "slope" : 1.47,       /* new phenology: slope of warm-temperature limiting function tmax_sl */
      "base" : 29.16,       /* new phenology: inflection point of warm-temperature limiting function (deg C) */
      "tau" : 0.2           /* new phenology: change rate of actual to previous day warm-temperature limiting fct */
    },
    "light" :
    {
      "slope" : 64.23,      /* new phenology: slope of light limiting function */
      "base" : 69.9,        /* new phenology: inflection point of light limiting function (Wm-2) */
      "tau" : 0.4           /* new phenology: change rate of actual to previous day light limiting function */
    },
    "wscal" :
    {
      "slope" : 0.1,        /* new phenology: slope of water limiting function */
      "base" : 41.72,       /* new phenology: inflection point of water limiting function (% water availability)  */
      "tau" : 0.17          /* new phenology: change rate of actual to previous day water limiting function */
    },
    "mort_max" : MORT_MAX,  /* asymptotic maximum mortality rate (1/year) */
    "phenology" : CROPGREEN,/* phenology */
    "path" : C4,            /* pathway */
    "temp_co2" : { "low" : 8.0, "high" : 42.0 }, /* lower and upper temperature limit for co2 (deg C) 24 27*/
    "temp_photos" : { "low" : 18., "high" : 30. },/* lower and upper limit of temperature optimum for photosynthesis(deg C) 25 26*/
    "temp" : { "low" : -1000.0, "high" : 1000 }, /* lower and upper coldest monthly mean temperature(deg C) 28 29*/
    "soc_k" : 0.40428,     /* shape factor for soil organic matter vertical distribution*/
    "alpha_fuelp" : ALPHA_FUELP_TROP, /* scaling factor fire danger index */
    "fuelbulkdensity" : 2.0, /* fuel bulk density */
    "emission_factor" : { "co2" : 1568.0, "co" :  106.0, "ch4" : 4.80, "voc" : 5.70, "tpm" : 17.60, "nox" : 3.240}, /* emission factors */
    "aprec_min" : 0,        /* minimum annual precipitation to establish */
    "flam" : FLAM_GRASS,    /* flam */
    "k_litter10" : { "leaf" : KLITTER10, "wood" : KLITTER10}, /* K_LITTER10 turnover rate after Brovkin etal 2012*/
    "k_litter10_q10_wood" : 1, /* Q10_wood */
    "windspeed_dampening" : 0.6, /* windspeed dampening */
    "roughness_length" : 0.03,   /* roughness length */
    "calcmethod_sdate" : TEMP_PREC_CALC_SDATE, /* calc_sdate: method to calculate the sowing date*/
    "sdatenh" : 120, "sdatesh" : 300, /* sdatenh,sdatesh: init sowing date for northern and southern hemisphere (julian day) */
    "hlimit" : 360,         /* hlimit: max length of crop cycle  */
    "fallow_days" : 0,      /* fallow_days: wait after harvest until next sowing */
    "temp_fall" : 1000, "temp_spring" :  14, "temp_vern" : 1000, /* temp_fall, temp_spring, temp_vernalization: thresholds for sowing date f(T)*/
    "trg" : { "low" : 1000, "high" : 1000 }, /* min & max trg: temperature under which vernalization is possible (deg C)*/
    "pvd" : 0,              /* pvd: number of vernalising days required*/
    "psens": 1.0,           /* psens: sensitivity to the photoperiod effect [0-1](1 means no sensitivity)*/
    "pb" : 0,               /* pb: basal photoperiod (h)(pb<ps for longer days plants)*/
    "ps" : 24,              /* ps: saturating photoperiod (h) (ps<pb for shorter days plants)*/
    "phuw" : { "low" : 0.0,  "high" : 0.0}, /* min & max phu: potential heat units required for plant maturity winter(deg C)*/
    "phus" : { "low" : 2000.0,  "high" : 4000.0}, /* min & max phu: potential heat units required for plant maturity summer(deg C)*/
    "phu_par" : 9999,       /* phu parameter for determining the variability of phu */
    "basetemp": { "low" : 11.0, "high" :  15.0}, /* min & max basetemp: base temperature */
    "fphuc" : 0.01,         /* fphuc: fraction of growing season 1 [0-1]*/
    "flaimaxc" : 0.01,      /* flaimaxc: fraction of plant maximal LAI 1 [0-1]*/
    "fphuk" : 0.40,         /* fphuk: fraction of growing season 2 [0-1]*/
    "flaimaxk" : 0.95,      /* flaimaxk: fraction of plant maximal LAI 2 [0-1]*/
    "fphusen" : 0.95,       /* fphusen: fraction of growing period at which LAI starts decreasing [0-1]*/
    "flaimaxharvest" : 0.50, /* flaimaxharvest: fraction of plant maximal LAI still present at harvest [0-1]*/
    "laimax" : 6.0,         /* laimax: plant maximal LAI (m2leaf/m2)*/
    "laimin" : 2.0,         /* laimin: plant maximal LAI (m2leaf/m2) in 1950*/
    "hiopt" : 0.80,         /* hiopt: optimum harvest index HI reached at harvest*/
    "himin" : 0.80,         /* himin: minimum harvest index HI reached at harvest*/
    "shapesenescencenorm" : 2.0, /* shapesenescencenorm */
    "cn_ratio" : { "root" : CTON_ROOT, "so" : CTON_SO, "pool" : CTON_POOL} /* C:N mass ratio for root, storage organ, and pool */
  }
],
/*--------------------------------------------------------------------------*/
