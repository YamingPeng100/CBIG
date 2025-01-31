function CBIG_KRR_generate_kernels_LITE(feature_mat, outdir, ker_param, similarity_mat)

% CBIG_KRR_generate_kernels_LITE( feature_mat, sub_fold, outdir, ker_param, similarity_mat )
% 
% This function calculates the inner-loop and training-test kernels for
% kernel ridge regression. 
% 
% This is a lite version of CBIG_KRR_generate_kernels.m. In this version,
% the kernels are not computed and saved separately for each inner-loop
% fold and each outer training-test fold. Instead, the kernel is only
% computed once across all the subjects, and for each fold, the scripts
% will grab the corresponding entries on the fly.
% 
% Inputs:
%   - feature_mat
%     Feature matrix.
%     Generally, "feature_mat" is a #features x #subjects matrix.
%     However if the user input a 3-D matrix, this function will assume
%     that the feature matrix is the connectivity matrix (eg. functional
%     connectivity across ROIs). Specifically, "feature_mat" will be a
%     #ROIs1 x #ROIs2 x #subjects matrix.
% 
%   - sub_fold
%     The data split for cross-validation.
%     It is a num_test_folds x 1 structure with a field "fold_index".
%     sub_fold(i).fold_index is a #subjects x 1 binary vector, where 1
%     refers to the test subjects in the i-th fold; 0 refers to the
%     training subjects in the i-th fold.
%     If the user does not need cross-validation, the length of sub_fold
%     (i.e. the number of folds) will be 1. In this case,
%     sub_fold.fold_index has 3 unique values:
%     0 - training set;
%     1 - test set;
%     2 - validation set.
% 
%   - outdir
%     A string, the full path of output directory.
%     A subfolder [outdir '/FSM'] will be created to store the kernels
%     across all subjects.
% 
%   - ker_param (optional)
%     A K x 1 structure with two fields: type and scale. K denotes the
%     number of kernels.
%     ker_param(k).type is a string of the type of k-th kernel. Choose from
%                       'corr'        - Pearson's correlation;
%                       'Gaussian'    - Gaussian kernel;
%                       'Exponential' - exponential kernel.
%     ker_param(k).scale is a scalar specifying the scaling factor of k-th
%     kernel (only for Gaussian kernel or exponential kernel). 
%     If ker_param(k).type == 'corr', ker_param(k).scale = NaN.
%     
%     If "ker_param" is not passed in, only correlation kernel will be
%     calculated.
% 
%   - similarity_mat (optional)
%     A #subjects x #subjects inter-subject similarity matrix pre-computed
%     by the user. If this argument is passed in, this function will only
%     split this similarity matrix into kernels for different folds without
%     further operations. By passing in this argument, "feature_mat" is not
%     needed (you can pass in an empty matrix for the "feature_mat" input).
% 
% Outputs:
%     Case 1. (cross-validation)
%     For each fold and each kernel hyperparameter, a #TrainingSubjects x
%     #TrainingSubjects matrix will be saved in [outdir '/FSM_innerloop']
%     folder as the inner-loop cross-validation kernel. 
%     Meanwhile, a #AllSubjects x #AllSubjects kernel matrix will be saved
%     in [outdir '/FSM_test'] folder for the training-test
%     cross-validation. (The ordering of subjects follows the original
%     subject list, i.e. the ordering in "feature_mat" or "similarity_mat".)
% 
%     Case 2 (training, validation, and test)
%     In this case, cross-validation is not performed. Instead, the data
%     are split into training, validation and test sets. For each kernel
%     hyperparameter, a (#TrainingSubjects + #ValidationSubjects) x
%     (#TrainingSubject + #ValidationSubjects) kernel matrix will be saved
%     in [outdir '/FSM_innerloop'] folder for the training and validation
%     phase. (Training subjects at first, then followed by validation
%     subjects.)
%     Meanwhile, a (#TrainingSubjects + #TestSubjects) x (#TrainingSubjects
%     + #TestSubjects) kernel matrix will be saved in [outdir '/FSM_test']
%     folder for the test phase. (Training subjects at first, then followed
%     by test subjects.)
% 
% Written by Jingwei Li and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

% If feature_mat is a connectivity matrix, extract the lower triangular
% entries and construct feature_mat as a #features x #subjects matrix.
if(size(feature_mat, 3) > 1)
    tril_ind = find(tril(ones(size(feature_mat,1), size(feature_mat,2)), -1) == 1);
    feature_mat = reshape(feature_mat, size(feature_mat,1)*size(feature_mat,2), size(feature_mat,3));
    feature_mat = feature_mat(tril_ind,:);
end

if(~exist('ker_param', 'var'))
    ker_param.type = 'corr';
    ker_param.scale = NaN;
end
num_ker = length(ker_param);

for k = 1:num_ker
    fprintf('-- Current kernel type is %s, scale %f\n', ker_param(k).type, ker_param(k).scale);
    if(strcmp(ker_param(k).type, 'corr'))
        outstem{k} = '';
    else
        outstem{k} = ['_' num2str(ker_param(k).scale)];
    end
    outname = fullfile(outdir, 'FSM', ['FSM_' ker_param(k).type outstem{k} '.mat']);
    if(~exist(fullfile(outdir, 'FSM')))
        mkdir(fullfile(outdir, 'FSM'));
    end
    
    %% Depending on kernel parameters, compute kernels
    if(~exist(outname, 'file'))
        if(~exist('similarity_mat', 'var') || isempty(similarity_mat))
            if(~strcmp(ker_param(k).type, 'corr'))
                K = size(feature_mat, 1); % number of features
                SD = std(feature_mat, 0, 2);
                mu = mean(feature_mat, 2);
                
                % znormalize feature_mat by SD and mu
                feature_mat = bsxfun(@minus, feature_mat, mu);
                feature_mat = bsxfun(@rdivide, feature_mat, SD);
            end
            
            if(strcmp(ker_param(k).type, 'corr'))
                FSM = CBIG_self_corr(feature_mat);
            elseif(strcmp(ker_param(k).type, 'Exponential'))
                FSM = exp(-1*ker_param(k).scale*squareform(pdist(feature_mat'))/K);
            elseif(strcmp(ker_param(k).type, 'Gaussian'))
                FSM = exp(-1*ker_param(k).scale*squareform(pdist(feature_mat').^2)/K);
            else
                error('Unknown kernel type: %s', ker_param(k).type);
            end
        else
            FSM = similarity_mat;
        end
        save(outname, 'FSM'); clear FSM
    else
        fprintf('Already exist. Skipping ...\n')
    end
end

end

