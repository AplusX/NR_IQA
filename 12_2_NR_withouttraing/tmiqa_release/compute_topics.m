function [Pw_z_test Pw_z_train Pd_z_test Pd_z_train Pz_test Pz_train ]= ...
    compute_topics(Learn,topicnum,ind_train,ind_test)


  

  
 %EM from training images
%--------------------------------------------------------
%load up all interest_point files which should have the histogram
%variable already computed (performed by do_vq routine).
count = 0;
for a = ind_train
    count =count+1;
    load(sprintf('temp/histogram_%d.mat',a));
    %store histogram
    X(:,count) = histogram';    
end  


%How many topics in pLSA model
Learn.Num_Topics = topicnum;


%--------------------------------------------------------
pathcurrent = pwd;
addpath(sprintf('%s/bag_words_demo/common',pathcurrent));
NrEMCalls = 20;
currentMaxLi = -Inf;
current_Pw_z_train = [];
current_Pd_z_train = [];
current_Pz_train = [];
currentLi = [];
  %% Call actual EM routine....
for nn = 1 : NrEMCalls
   % disp(strcat('EM CALL: ', num2str(nn)));
    [Pw_z_train,Pd_z_train,Pz_train,Li] = pLSA_EM(X,[],Learn.Num_Topics,Learn);
    if (max(Li) > currentMaxLi)
        currentMaxLi = max(Li);
        currentLi = Li;
        current_Pw_z_train = Pw_z_train;
        current_Pd_z_train = Pd_z_train;
        current_Pz_train = Pz_train;
    end
end

Li = currentLi;
Pw_z_train = current_Pw_z_train;
Pd_z_train = current_Pd_z_train;
Pz_train = current_Pz_train;

clear Li X

 %EM from testing images
%--------------------------------------------------------
%load up all interest_point files which should have the histogram
%variable already computed (performed by do_vq routine).
count = 0;
for a = ind_test
    count =count+1;
    load(sprintf('temp/histogram_%d.mat',a));
    %store histogram
    X(:,count) = histogram';    
end  


%--------------------------------------------------------
pathcurrent = pwd;
addpath(sprintf('%s\\bag_words_demo\\common',pathcurrent));
  %% Call actual EM routine....
[Pw_z_test,Pd_z_test,Pz_test,Li] = pLSA_EM(X,Pw_z_train,Learn.Num_Topics,Learn);








