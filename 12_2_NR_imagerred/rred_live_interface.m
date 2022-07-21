clear all; close all; clc;

load refnames_all

inpath = 'E:\databaserelease2\databaserelease2\';
distortion = {'jp2k'; 'jpeg'; 'wn'; 'gblur'; 'fastfading'};
dsize = [227 233 174 174 174];

num=1;
s = size(distortion);

for u =1:1%s(1)
    for v =1:1%dsize(u)

        count = sum(dsize(1:u-1))+v; cnt(num)=count;
        disfolder = distortion(u,1);
        fname = strcat(inpath,disfolder,'\img',num2str(v),'.bmp');
        temp = char(fname);
        imdist = imread(temp);
        imdist = rgb2gray(imdist);

        refname = refnames_all(count);
        fname = strcat(inpath,'refimgs\',refname);
        temp = char(fname);
        imref = imread(temp);
        imref = rgb2gray(imref);



        rred(num) = compute_rred(imref,imdist);

        num=num+1;
        
    end
end

% save rred_live_recap rred 
