function rred = compute_rred(ref,dis)

% Copyright (c) 2011 The University of Texas at Austin
% All rights reserved.
% 
% Permission to use, copy, or modify this software and its documentation for 
% educational and research purposes only and without fee is hereby granted, 
% provided that this copyright notice and the original authors' names appear on 
% all copies and supporting documentation. This program shall not be used, rewritten,
% or adapted as the basis of a commercial software or hardware product without first 
% obtaining permission of the authors. The authors make no representations about the 
% suitability of this software for any purpose. It is provided "as is" without express
% or implied warranty.

% The following paper is to be cited in the bibliography whenever the software is used
% as:
% R. Soundararajan and A. C. Bovik, "RRED indices: Reduced reference entropic 
% differences for image quality assessment", IEEE Transactions on Image
% Processing, vol. 21, no. 2, pp. 517-526, Feb. 2012

% The code used herein is developed using code already developed for the
% algorithms in the following two papers:
% H. R. Sheikh and A. C. Bovik, “Image information and visual quality,” IEEE Trans. Image Process., vol. 15, no. 2, pp. 430–444, Feb. 2006
% Q. Li and Z. Wang, “Reduced-reference image quality assessment using
% divisive normalization-based image representation,” IEEE Journal of Selected Topics in Signal Processing: Special issue on Visual Media Quality Assessment, vol. 3, pp. 202– 211, 2009.

% 'ref' denotes reference image in grayscale format
% 'dis' denotes distorted image in grayscale format

[red_info_ref dim] = extract_red_info(ref);
[red_info_dis dim] = extract_red_info(dis);
rred = sum(sum(abs(red_info_ref-red_info_dis)))/dim;

end