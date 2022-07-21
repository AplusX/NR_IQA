%-------------------------------------------------
%Parameter Initialization
topicnum    = 3;
visualwords = 400;

% clustering options for code book formation
cluster_options.maxiters = 300;
cluster_options.verbose  = 0;
% Topic model parameters
% Max number of EM iterations
Learn.Max_Iterations  = 300;
% Min. allowable lh change before EM termination
Learn.Min_Likelihood_Change   = 1;
%Control level of printed and plotted output during learning
Learn.Verbosity = 0;

% train test parameters
num_total = 29; % total images are 29
num_train = 23;

load('refnames_all.mat')
load('dmos.mat')
load('dmos_realigned.mat')
load('train_test_splits_1000')

% Human scores
dmos                 = dmos_new';

% Class 1 - JP2k
% Class 2 - JPEG
% Class 3 - WN
% Class 4 - Blur
% Class 5 - FF
% Class 6 - Pristine
class(1:227)         = 1;
class(228:460)       = 2;
class(461:634)       = 3;
class(635:808)       = 4;
class(809:982)       = 5;
class(find(orgs==1)) = 6;
class                = class';

%------------------------------------
% Compute the brisque features on all images and store them in temp folder
if(~isdir('temp'))
    mkdir('temp')
end
  
strResponse = input('Enter the database path:', 's');
compute_risqueefeatures(strResponse)

%---------------------------------------------------
% Iterate with different spatial content


for itr_trial = 1:1000
    
itr_trial
%%---------------------------------------------
% Find the indices of train and test images so that spatial content doesnt
% overlap
ind_train          = logical(ind_train1000(:,itr_trial));
ind_test           = logical(ind_test1000(:,itr_trial));
ind_train          = find(ind_train==1);
ind_train          = ind_train';
ind_test           = find(ind_test==1);
ind_test           = ind_test';
qual_train         = dmos(ind_train);
class_train        = class(ind_train);
qual_test          = dmos(ind_test);
class_test         = class(ind_test);
%%---------------------------------------------
% Code book formation
trainfeatures = [];
% Extract features from train images
for i = ind_train
    load(sprintf('temp/features_local%d.mat',i))
    feat = feat';
    trainfeatures     = [trainfeatures feat];
end

centers = form_codebook(trainfeatures,visualwords,cluster_options);
save('temp/codebook.mat','centers');
clear trainfeatures
disp('code book generated')

% %--------------------------------------
% Perform vector quantization
perform_vectorquantization
disp('VQ done')
%--------------------------------------

[Pw_z_test Pw_z_train Pd_z_test Pd_z_train Pz_test Pz_train ]= ...
    compute_topics(Learn,topicnum,ind_train,ind_test);

disp('EM training done')

Pzrep_train      = repmat(Pz_train,[length(ind_train) 1]);
Pz_d_train       = Pzrep_train.*Pd_z_train;
Pz_dnorm_train   = Pz_d_train./repmat(sum(Pz_d_train,2),[1 topicnum]);

Pzrep_test       = repmat(Pz_test,[length(ind_test) 1]);
Pz_d_test        = Pzrep_test.*Pd_z_test;
Pz_dnorm_test    = Pz_d_test./repmat(sum(Pz_d_test,2),[1 topicnum]);
objectivescore   = Pz_dnorm_test;

weight         = mean(Pz_dnorm_train(class_train == 6,:));
quality        = sum(objectivescore.*repmat(weight,[size(objectivescore,1) 1]),2);

qual_test(class_test==6)           = [];
quality(class_test==6)             = [];
class_test(class_test==6,:)        = [];


humanscores    = qual_test;
RHO(itr_trial) = corr(quality,humanscores,'type','spearman');
Pearson_RHO(itr_trial) = calculatepearsoncorr(quality,humanscores);

idx                 = (class_test==1);
RHO_jp2k(itr_trial) = corr(quality(idx),humanscores(idx),'type','spearman');
Pearson_RHO_jp2k(itr_trial) = calculatepearsoncorr(quality(idx),humanscores(idx));
idx                 = (class_test==2);
RHO_jpeg(itr_trial) = corr(quality(idx),humanscores(idx),'type','spearman');
Pearson_RHO_jpeg(itr_trial) = calculatepearsoncorr(quality(idx),humanscores(idx));
idx                 = (class_test==3);
RHO_wn(itr_trial)   = corr(quality(idx),humanscores(idx),'type','spearman');
Pearson_RHO_wn(itr_trial) = calculatepearsoncorr(quality(idx),humanscores(idx));
idx                 = (class_test==4);
RHO_gblur(itr_trial)= corr(quality(idx),humanscores(idx),'type','spearman');
Pearson_RHO_gblur(itr_trial) = calculatepearsoncorr(quality(idx),humanscores(idx));
idx                 = (class_test==5);
RHO_ff(itr_trial)   = corr(quality(idx),humanscores(idx),'type','spearman');
Pearson_RHO_ff(itr_trial) = calculatepearsoncorr(quality(idx),humanscores(idx));

end

rmdir('temp')