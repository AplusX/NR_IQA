function do_representation(config_file)
  
%% Top-level function that calls code to compute respresentaion of
%% interest points generated by do_interest_op. Currently only SIFT is
%% implemented, but you can easily add in your own preffered choice. The
%% Descriptor structure holds all the parameters for the descriptor code
%% and should be passed into which ever main subroutine you use.
%%
%% It operates on each file in the interest_points dirrectory, adding to each one the
%% descriptors for all feaures in the image.  

%% PLEASE NOTE: The implementation of SIFT uses a Linux binary from
%% Krystian Mikolajczyk (km@robots.ox.ac.uk), thus will not run under Windows.  
  
%% Before running this, you must have run:
%%    do_random_indices - to generate random_indices.mat file
%%    do_preprocessing - to get the images that the operator will run on  
%%    do_interest_op  - to get extract interest points (x,y,scale) from each image

%% R.Fergus (fergus@csail.mit.edu) 03/10/05.

%% Evaluate global configuration file
eval(config_file);

%% Get list of file name of input images
img_file_names = genFileNames({Global.Image_Dir_Name},[1:Categories.Total_Frames],RUN_DIR,Global.Image_File_Name,Global.Image_Extension,Global.Num_Zeros);
 
%% Get list of interest point file names
ip_file_names =  genFileNames({Global.Interest_Dir_Name},[1:Categories.Total_Frames],RUN_DIR,Global.Interest_File_Name,'.mat',Global.Num_Zeros);
 
%% Find type of descriptor to be used
%% (should be specified in the config_file)
%% and run across interest_xxxx.mat files
tic;

  if strcmp(Descriptor.Type,'SIFT')
    
    %%% Edge Sampling: simple, crude descriptor.
    SIFT(img_file_names,ip_file_names,Descriptor);
    
  elseif strcmp(Descriptor.Type,'Another_Type')
    
    %% Add your favourite descriptor here....
    
  else
    error('Unknown type of descriptor');
  end

total_time=toc;

fprintf('\nFinished running descriptor operator\n');
fprintf('Total number of images: %d, mean time per image: %f secs\n',Categories.Total_Frames,total_time/Categories.Total_Frames);
