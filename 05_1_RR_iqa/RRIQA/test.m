clear all;
close all;

% A simple test for the reduced-reference image quality
% assessment algorithm published in
% Z. Wang and E. P. Simoncelli, "Reduced-reference image
% quality assessment using a wavelet-domain natural image
% statistic model," Human Vision and Electronic Imaging X,
% Prof. SPIE, vol. 5666, San Jose, CA, Jan. 2005

% set path
path(path, 'sender_side');
path(path, 'receiver_side');
path(path, 'common_to_both_sides');

% sender side: feature extraction
im_reference = imread('im_original.tif');	% read reference image
features_in_bits = sender_feature_extraction(im_reference)

% receiver side: feature extraction and distortion measurement
im_distorted = imread('im_distorted.tif');	% read distorted image
distortion = receiver_distortion_measure(im_distorted, features_in_bits)