function perform_vectorquantization
%function perform_vectorquantization(meanVec,stdVec)
%-------------------------------------------------------
%vector quantization on test images

load('temp/codebook.mat');

visualwords = size(centers,2);

testquality =[];

 %%% Loop over all images....
  for i= 1:982
    
%     if (mod(i,10)==0)
%       fprintf('.%d\n',i);
%     end
    
    %%% Load up interest point file
    load(sprintf('temp/features_local%d.mat',i));
    
    %feat = whitenTestingData(feat, meanVec, stdVec);
    feat = feat';
    
    %%% Find number of points per image
    nPoints = size(feat,2);
    
    %%% Set distance matrix to all be large values
    %distance = Inf * ones(nPoints,visualwords);
    
%     %%% Loop over all centers and all points and get L2 norm btw. the two.
%     for p = 1:nPoints
%       for c = 1:visualwords
%         distance(p,c) = norm(centers(:,c) - double(feat(:,p)));
%       end
%     end
    
    distance = sqrt(dist2(feat', centers'));
    
    %%% Now find the closest center for each point
    [tmp,descriptor_vq] = min(distance,[],2);

    %%% Now compute histogram over codebook entries for image
    histogram = zeros(1,visualwords);
    
    for p = 1:nPoints
      histogram(descriptor_vq(p)) = histogram(descriptor_vq(p)) + 1;
    end
    
    % new line of code added post SP letters draft
    histogram = histogram./sum(histogram);
    
    %%% transpose to match other variables
    descriptor_vq = descriptor_vq';
    
    %%% append descriptor_vq variable to file....
    save(sprintf('temp/histogram_%d.mat',i),'histogram','descriptor_vq');
    
  end
  
  
 