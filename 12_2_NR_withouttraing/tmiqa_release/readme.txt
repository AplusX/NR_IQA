Topic models based Image Quality Assessment Software Release 

=======================================================================
-----------COPYRIGHT NOTICE STARTS WITH THIS LINE------------
Copyright (c) 2011 The University of Texas at Austin
All rights reserved.

Permission is hereby granted, without written agreement and without license or royalty fees, to use, copy, 
modify, and distribute this code (the source files) and its documentation for
any purpose, provided that the copyright notice in its entirety appear in all copies of this code, and the 
original source of this code, Laboratory for Image and Video Engineering (LIVE, http://live.ece.utexas.edu)
and Center for Perceptual Systems (CPS, http://www.cps.utexas.edu) at the University of Texas at Austin (UT Austin, 
http://www.utexas.edu), is acknowledged in any publication that reports research using this code. The research
is to be cited in the bibliography as:

1) A.Mittal, G.S.Muralidhar, J.Ghosh and A.C. Bovik, "Topic models based Image Quality Assessment Software Release", 
URL: http://live.ece.utexas.edu/research/quality/tmiqa_release.zip 2012.

2) A.Mittal, G.S.Muralidhar, J.Ghosh and A.C. Bovik, "Blind image quality assessment without human training using latent quality factors",
IEEE Signal Processing Letters, pp 75-78, Vol 19, no 2, February 2012.


IN NO EVENT SHALL THE UNIVERSITY OF TEXAS AT AUSTIN BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF THIS DATABASE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF TEXAS
AT AUSTIN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

THE UNIVERSITY OF TEXAS AT AUSTIN SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE DATABASE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS,
AND THE UNIVERSITY OF TEXAS AT AUSTIN HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

-----------COPYRIGHT NOTICE ENDS WITH THIS LINE------------%

Author  : Anish Mittal and Gautam Muralidhar
Version : 1.0

The authors are with the Laboratory for Image and Video Engineering
(LIVE), Department of Electrical and Computer Engineering, The
University of Texas at Austin, Austin, TX.

Kindly report any suggestions or corrections to mittal.anish@gmail.com

=======================================================================

This is a demonstration of the Naturalness Image Quality Evaluator(NIQE) index. The algorithm is described in:

A.Mittal, G.S.Muralidhar, J.Ghosh and A.C. Bovik, "Blind image quality assessment without human training using latent quality factors 
IEEE Signal Processing Letters", pp 75-78, Vol 19, no 2, February 2012.

You can change this program as you like and use it anywhere, but please
refer to its original source (cite our paper and our web page at
http://live.ece.utexas.edu/research/quality/tmiqa_release.zip

=======================================================================
Running on Matlab 
  
Usage: Run main.m

It asks for the path of LIVE database as input and outputs spearman and pearson correlation performance for each distortion category and all images together
for 1000 train test combinations where the train and test combination as 80-20. It was made sure that the train and test content are disjoint. This demo runs
for 3 topics.

=======================================================================

MATLAB files: (provided with release):
calculatepearsoncorr.m        
compute_risqueefeatures.m     
compute_topics.m              
computefeatures.m             
dist2.m                       
estimateaggdparam.m           
form_codebook.m 
logistic_fun.m                    
main.m  
perform_vectorquantization.m  


Dependencies (provided with release):

1) bag_words_demo developed by Rob Fergus.

2) LIVE database aux files   
dmos.mat                                   
dmos_realigned.mat 
refnames_all.mat 

3) train_test_splits_1000.mat    for 1000 train-test combinations of LIVE IQA database.


Dependencies (not provided with release):

LIVE image database accessed through 
http://live.ece.utexas.edu/research/quality/subjective.htm


=======================================================================