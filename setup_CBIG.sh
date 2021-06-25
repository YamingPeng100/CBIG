#!/bin/bash

cd /CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities
rm CBIG_bandpass_vol CBIG_glm_regress_vol CBIG_bpss_by_regression CBIG_glm_regress_matrix \
CBIG_preproc_censor_wrapper CBIG_preproc_censor CBIG_preproc_CensorQC CBIG_preproc_QC_greyplot

ln -s /CBIG_compiled-for-MCR/utilities/matlab/filtering/CBIG_bandpass_vol \
/CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_bandpass_vol

ln -s /CBIG_compiled-for-MCR/utilities/matlab/filtering/CBIG_bpss_by_regression \
/CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_bpss_by_regression

ln -s /CBIG_compiled-for-MCR/utilities/matlab/stats/CBIG_glm_regress_matrix \
/CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_glm_regress_matrix

ln -s /CBIG_compiled-for-MCR/utilities/matlab/stats/CBIG_glm_regress_vol \
/CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_glm_regress_vol

cd
cp /extra_files/{CBIG_preproc_censor_wrapper, CBIG_preproc_censor, CBIG_preproc_CensorQC, CBIG_preproc_QC_greyplot} \
/CBIG_compiled-for-MCR/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities
