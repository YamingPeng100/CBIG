
addpath(genpath('/fileserver/caladan_ssd/repos/CBIG_compiled'))

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_plot_mcflirt_par.m

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_DVARS_FDRMS_Correlation

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_motion_outliers

mcc -m -R -nodisplay -d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering CBIG_bandpass_vol

mcc -m -R -nodisplay -d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering CBIG_bpss_by_regression

mcc -m -R -nodisplay -d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats CBIG_glm_regress_matrix

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_create_mc_regressors

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_create_ROI_regressors

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_aCompCor_multipleruns

mcc -m -R -nodisplay -d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats CBIG_glm_regress_vol

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_censor_wrapper

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_censor

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_CensorQC

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_CensorCorrAndFracDiff

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_QC_greyplot      

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_fsaverage_medialwall_fillin               

mcc -m -R -nodisplay -d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_set_medialwall_NaN

exit
