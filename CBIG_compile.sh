cat > build.m <<END
addpath(genpath('/fileserver/caladan_ssd/repos/CBIG_compiled'))
addpath(genpath('/home/ch226001/MCRInstaller9.10'))

mcc -m CBIG_preproc_plot_mcflirt_par.m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/ \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_DVARS_FDRMS_Correlation

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_motion_outliers

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities \
-d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering CBIG_bandpass_vol

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering \
-d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering CBIG_bpss_by_regression

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats \
-d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats CBIG_glm_regress_matrix

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/ \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_create_mc_regressors

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_create_ROI_regressors

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities \
-d stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities CBIG_preproc_aCompCor_multipleruns

mcc -m -R -nodisplay -a /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats \
-d /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats CBIG_glm_regress_vol

exit
END
matlab -nodisplay -nosplash -r build

cd 
cd /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/
ln -s /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering/CBIG_bandpass_vol \
/fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_bandpass_vol
ln -s /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/filtering/CBIG_bpss_by_regression \
/fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_bpss_by_regression
ln -s /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats/CBIG_glm_regress_matrix \
/fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_glm_regress_matrix
ln -s /fileserver/caladan_ssd/repos/CBIG_compiled/utilities/matlab/stats/CBIG_glm_regress_vol \
/fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities/CBIG_glm_regress_vol

echo "Done compiling!"
