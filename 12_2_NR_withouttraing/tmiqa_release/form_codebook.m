function centers = form_codebook(trainfeatures,visualwords,cluster_options)

%Run k- means to form visual words

pathcurrent = pwd;
 addpath(sprintf('%s\\bag_words_demo\\common',pathcurrent));
%addpath('/Users/gs4784/Research/ProjectWithAnish/AnchorBasedIdea/bag_words_demo/common');
[centers]  = vgg_kmeans(trainfeatures,visualwords,cluster_options);
%Options = statset('Display','iter','MaxIter',300);
%[centers]  = kmeans(trainfeatures',visualwords,'distance','correlation','options',Options,'emptyaction','drop');
%centers = centers';
