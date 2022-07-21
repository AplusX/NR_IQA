function compute_risqueefeatures(databasepath)


load refnames_all.mat

class(1:227)     = 1;
class(228:460)   = 2;
class(461:634)   = 3;
class(635:808)   = 4;
class(809:982)   = 5;

class_label      = {'jp2k','jpeg','wn','gblur','fastfading'};
imnumber         = [0 227 233 174 174];
imnumber         = cumsum(imnumber);

scalenum         = 2;

param =[];
for itr = 1:982

 tic
itr
imdist = double(rgb2gray(imread(sprintf('%s/%s/img%d.bmp',databasepath,class_label{class(itr)},...
         itr-imnumber(class(itr))))));   

blocksizerow     = round(64);
blocksizecol     = round(64);
blockrowoverlap  = 8;
blockcoloverlap  = 8;

feat   = [];


featnum =18;

for itr_scale = 1:scalenum


window        = fspecial('gaussian',7*itr_scale,(7*itr_scale)/6);
window        = window/sum(sum(window));

mu            = filter2(window, imdist, 'same');
mu_sq         = mu.*mu;
sigma         = sqrt(abs(filter2(window, imdist.*imdist, 'same') - mu_sq));
structdis     = (imdist-mu)./(sigma+1);

[row col]     = size(structdis);
block_rownum  = floor(row/blocksizerow);
block_colnum  = floor(col/blocksizecol);

structdis     = structdis(1:block_rownum*blocksizerow,1:block_colnum*blocksizecol);
J             = blkproc(structdis,[blocksizerow blocksizecol], [blockrowoverlap blockcoloverlap],@computefeatures);
J             = reshape(J,[featnum size(J,1)*size(J,2)/featnum]);

feat          = [feat; J];

end

inf_ind    = isinf(feat);
[inf_r inf_c] = find(inf_ind==1);
feat(:,inf_c)= [];

feat         = feat';
save(sprintf('temp/features_local%d.mat',itr),'feat');
           
toc
end








