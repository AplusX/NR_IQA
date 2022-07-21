function [red_info dim] = extract_red_info(img)
 
% The function computes the reduced reference entropy information using
% which the RRED indices are computed. This function uses all the
% information in a subband. The amount of information can be reduced using
% the ideas indicated at the bottom of this function. 

% 'img' denotes reference/distorted image from which information needs to be
% extracted. Must be in grayscale format.

% Settings
% 'subband ' denotes the subband in which the entropy information is required
subband = 16;
% 'sigma2_w' denotes the variance of the neural noise
sigma2_w = 0.1;
% 'blk' denotes the size of the block used for entropy vectors in a subband
blk = 3;


% Include path for steerable pyramid decompsition routines
path('C:\Documents and Settings\ece-rs6454-la\My Documents\strred\matlabPyrTools\',path);

% Perform wavelet decomposition
[pyr,pind] = buildSpyr(double(img), 4, 'sp5Filters', 'reflect1');
imsband = ind2wtree(pyr,pind);

imsband = imsband{subband};

% crop to exact multiple size
sizeimsband = floor(size(imsband)./blk)*blk;
imsband = imsband(1:sizeimsband(1),1:sizeimsband(2));

% covariance matrix for U
temp=[];
for j=1:blk
    for k=1:blk
        temp=cat(1,temp,reshape(imsband(k:end-(blk-k), j:end-(blk-j)),1,[]));
    end
end

mcu=mean(temp,2);
cu=((temp-repmat(mcu,1,size(temp,2)))*(temp-repmat(mcu,1,size(temp,2)))')./size(temp,2);

% correct possible negative eigenvalues, without changing the overall variance
[Q,L] = eig(cu);
L = diag(diag(L).*(diag(L)>0))*sum(diag(L))/(sum(diag(L).*(diag(L)>0))+(sum(diag(L).*(diag(L)>0))==0));
cu = Q*L*Q';

% Calculate local variance parameters
temp=[];
for j=1:blk
    for k=1:blk
        temp=cat(1,temp,reshape(imsband(k:blk:end, j:blk:end),1,[]));
    end
end

ss=(inv(cu)*temp);
ss=sum(ss.*temp)./(blk*blk);
ss = reshape(ss,sizeimsband/blk);

% Compute eigen values for entropy calculation
[V,alpha]=eig(cu); alpha = alpha(alpha>0);

temp = zeros(size(ss));
% Compute entropy and scale them
for j=1:length(alpha)
    temp = temp+log2(ss*alpha(j)+sigma2_w)+log(2*pi*exp(1));
end
red_info = log2(1+ss).*temp;
dim = numel(imsband);

% Filter and downsample to extract desired amount of information
% win = ones(window);
% winsize = size(win);
% red_info = filter2(win,red_info,'valid');
% red_info = red_info(1:winsize(1):end,1:winsize(2):end);

% Single no. algo
% red_info = sum(sum(red_info));
end
