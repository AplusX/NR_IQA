
 load modelparameters.mat
 
 blocksizerow    = 96;
 blocksizecol    = 96;
 blockrowoverlap = 0;
 blockcoloverlap = 0;

im =imread('../test_img/test.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

im =imread('../test_img/test_1.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

im =imread('../test_img/test_��˹�˲�.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

im =imread('../test_img/test_���˺�.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

im =imread('../test_img/test_˫���˲�.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

im =imread('../test_img/test_�����˲�.jpg');

quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
    mu_prisparam,cov_prisparam)

% im =imread('../test_img/img01_2.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)
% 
% 
% im =imread('../test_img/img01_3.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)
% 
% im =imread('../test_img/img01_4.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)
% 
% im =imread('../test_img/img01_5.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)
% 
% im =imread('../test_img/img01_6.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)
% 
% im =imread('../test_img/img01_7.gif');
% 
% quality = computequality(im,blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap, ...
%     mu_prisparam,cov_prisparam)