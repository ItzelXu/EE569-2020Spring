# EE569 Homework Assignment #1
# Name: Zheng Wen
# ID: 7112807212
# email: zwen1423@usc.edu
#
# Software: MATLAB 2019a


Steps:

1. Open processing*_*.m to change the root of .raw file.
	These files are solutions to every sub-problem unber problem 1 and problem 2.
2. Open Problem1_main.m to get the result of problem1 and Problem2_main.m to get the result of problem2
	These files are solutions to every problem.
/////////////////////////////////////////////////////////////////////////////
Other standard files:

raw22D.m  raw23D.m
	These files are used to rearrange .raw to a image matrix
PSNRCal.m
	This file is used to calculate PSNR between two images.
matAddConst.m  matDotMul.m  matSub.m  matSum.m  matTranspose.m
	These files are used to define operator between mats or mat and number, or operator on mat itself.
be_m.m
	This file is used to find the responding position of index on the odd mirror padded image. 
	The first parameter is the original index, the second parameter is the max index of the dimension.
Red_Bi.m  Green_Bi.m  Blue_Bi.m
	These files are used to recover the red channel, green channel and blue channel using CFA image and bilinear method, 
	1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image.
Red_MHC.m  Green_MHC.m  Blue_MHC.m
	These files are used to recover the red channel, green channel and blue channel using CFA image and MHC method, 
	1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image.
HisCount.m
	This file is used to count the number of every pixel in the image,
	1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image.
TotalSum.m
	This file is used to calculate the cumulative sum of an array. In this problem, it is used to calculate CDF of original image.
	1st parameter is the frequency of pixels in image.
Hist.m
	This file is used to carry out transfer-function-based histogram equalization method.
	1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image, 4nd parameter is the transfer function
Arrange.m  randomize.m  reconstruct.m
	These files is used to carry out cumulative-probability-based histogram equalization method.
	In Arrange.m, a structure with value of pixel and the coordinate of the point is created and arranged by pixel, from small to large, 
	the points with the same pixel is arranged by coordinate, from small to large.
	1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image,
	In randomize.m, the structure created by Arrange.m is randomized, i.e. the sequence of pixel is retained, but the coordinates is 
	randomized. The function randperm() here is corresponding to the function next_permutation() in C++
	1st parameter is the the structure array, 2nd parameter is the frequency array of pixel, 3rd parameter is the cumulative sum of frequency array.
	In reconstruct.m, the randomlized pixel array is reconstructed to channel matrix.
	1st parameter is the the randomized structure array, 2nd and 3rd parameters are the num of row and column of image to be reconstructed,
noiseDistPlot.m  noiseAvg.m  noiseVar.m
	These files are used to plot distribution of noise and calculate relative attributes of noise . 
	In noiseDistPlot.m, 1st parameter is the raw array of original image, 2nd parameter is the raw array of noised image
	In noiseAvg.m and noiseVar.m, the parameter is the difference array between original raw array and noised raw array.
Basic.m
	This file is the function to implement basic filter
	1st parameter is the noised image, 
	2nd parameter is the radius of window,
	3rd parameter is a switch, 1 -> basic weight, 2 -> Gaussian weight,
	4nd parameter is the standard deviation of Gaussian kernel.
panelNomalize.m
	This file is used to normalize panel to sum = 1, a panel need to be passed in.
Bilaterial.m
	This file is the function to implement bilaterial filter
	1st parameter is the noised image, 
	2nd parameter is the radius of window,
	3rd parameter is sigmaC and 4nd parameter is sigmaS, two spread parameters.
NLmeans.m
	This file is the function to implement NLM filter
	1st parameter is the noised image, 
	2nd parameter is the radius of comparision window,
	3rd parameter is the radius of search window,
	4nd parameter is h, the filtering parameter,
	5nd parameter is a, the standard deviation of the Gaussian kernel.
reflectionPad.m
	This file is used to padding image by odd mirror padding.
	1st parameter is the noised image, 
	2nd parameter is the radius of comparision window.
outlier.m
	This file is used to implement outlier filter
	1st parameter is the noised image, 2nd para. is the threshold.
imnlmfiltTest.m
	This file is used to verify the correction of NLM, the results is not used in report.
	an open source function imnlmfilt() is used here.
/////////////////////////////////////////////////////////////////////////////
