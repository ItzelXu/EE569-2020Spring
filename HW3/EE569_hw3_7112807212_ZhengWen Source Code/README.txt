# EE569 Homework Assignment #3
# Name: Zheng Wen
# ID: 7112807212
# email: zwen1423@usc.edu
#
# Software: MATLAB 2019a


Steps:

1. Open the .m file begin with 'Problem' in Problem 1 and Problem 2 folder to change the root of .raw file or .jpg file, add basicOperations folder into path.
	change the file name to decide which picture is wanted to be processed by comment and uncomment the code.
	These files are solutions to every sub-problem unber problem 1 and problem 2.
/////////////////////////////////////////////////////////////////////////////
Other standard files:

The folder called basicOperator contains some basic matrix operator or some algorithm used in previous homework to help homework3 out.
	raw23D.m  raw22D.m  raw2img3.m
		These files are used to rearrange .raw to a image matrix
	matAddConst.m  matDotMul.m  matMulConst.m  matSub.m  matSum.m  matTranspose.m
		These files are used to define operator between mats or mat and number, or operator on mat itself.
		The input is output of HisCount.m, and the CDF of pixels is returned.
	reflectionPad.m  zeroPad.m
		These files are used to padding image by odd mirror padding or by zero padding.
	fixedThresholdDithering.m
		This file is used to binarize a image.
	ImgInverse_1.m
		This file is used to get the reversed image.
	matMeshgrid.m
		This file is used to get the coordinates of an image.

In Problem1 folder, there are following files to implement algorithm.
	warping_from_raw.m  unwarping_from_circle.m
		These files are used to implement forward warping and backward warping respectively,
		the input image is devided into 4 pieces and flipped to the lower right position of the whole image,
		then the projection between square and circle is calculated, then the projection one is obtained,
		they are flipped back then conquer into a whole image.
		The input is a square color image
	warping_EGM_I.m  warping_EGM_I_rev.m
		These files are used to calculate the projection between circle and square coordinates,
		The input is a part of a part of image.
	project2Cir.m  project2Square.m
		These files are used to project square to circle or project circle to square.
		1st parameter is the image waiting to project,
		2nd and 3rd parameters are the coordinates calculate by warping_EGM_I or warping_EGM_I_rev		
	matDivide4.m  matConquer4.m
		These files are used to devide and conquer a image.
	matFlip.m
		This file is used to flip a image.
		ist parameter is the image going to flip, 2nd parameter is the axis along which the image is going to be flipped.
	transform_compute.m
		This file is used to calculate the homographical transformation matrix
		1st parameter is feature point of the image going to be changed, 2md parameter is feature point of the image unchanged.
	in2out_paro.m
		This file is used to combine two image together to a larger output with one image is projected onto another one.
		1st parameter is image going to be changed, 2nd parameter is the homographical transformation matrix, 3rd parameter is 
		the image unchanged, 4nd parameter is a feature point on the changed image, 5nd parameter is a feature point on the unchanged image,
		6nd parameter is to dicide whether to combine left and middle or middle and right.

In Problem2 folder, there are following files to implement algorithm.
	Unconditional_ST.m  Unconditional_K.m
		These files are used to encode unconditional patterns and give the position to delete.
		The input parameter is conditional output given by conditional patterns.
	step_delete.m
		This file is used to decide which pixel is going to be deleted, the input is the image and the output by unconditional patterns.
	img2charof_1.m 
		This file is used to get the binary number decided by the 8-neighborhood surroundings of a point with pixel value 1
		the input parameter is the binarized image.
	countBondforSinglePoint.m
		This file is used to count the bond of a single point in an image,
		1st parameter is the image, 2nd and 3rd image is the row and column the point lies.
	countAlone.m
		This file is used to count the number of alone point in an image,
		the input is the image.
	conditional_S.m  conditional_T.m  conditional_K.m
		These files are used to give the conditional output for different operations.
		1st parameter is the bond matrix of an image and 2nd parameter is the surroundings matrix stored by binary string.
	calBondof_1.m
		This file is used to get the bond of every point in an image.
		The input is the image.
	char2double.m
		This file is used to convert the binary matrix storing the surrounding information of a matrix to decimal matrix.
		The input is the binary matrix storing the surrounding information.
/////////////////////////////////////////////////////////////////////////////
