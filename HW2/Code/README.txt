# EE569 Homework Assignment #2
# Name: Zheng Wen
# ID: 7112807212
# email: zwen1423@usc.edu
#
# Software: MATLAB 2019a


Steps:

1. Open the .m file begin with 'problem' in Problem 1 and Problem 2 folder to change the root of .raw file or .jpg file,
	change the file name to decide which picture is wanted to be processed. 
	These files are solutions to every sub-problem unber problem 1 and problem 2.
	Open CannyGenerate.m to change the root of .jpg file and use the correspoinding threshold. 
	This file is used to calculate the probability map using hundreds of output of edge() function in MATLAB, thus the probability map is obtained.
2. Run these files to get the result of all subproblem besides Problem 1-3 and 1-4
	These files are solutions to every problem.
3. Problem 1-3 and 1-4 are implemented by the toolbox from https://github.com/pdollar/edges and https://github.com/pdollar/toolbox
	To get the result of problem 1-3, just change the codes in the last part of edgesDemo.m with codes offered in the appendix in report,
	change the parameters, and run the code.
	To get the result of problem 1-4, change the code in edgesEvalImg.m with codes in appendix in report, add path of edges-master,
	run CannyGenerate.m to get the probability map of Canny algorithm.
	choose the result of algorithm wanted to be show, de-comment the code and comment out other part, then run P1_4.m.
	As for the correspoinding image of Structure Edge algorithm, the probability map should be save by hand.
/////////////////////////////////////////////////////////////////////////////
Other standard files:

Both in Problem1 folder and Problem2 folder,a folder called basicOperator is contained, some basic matrix operator or some algorithm used in
homework1 is contained to help homework2 out. They are listed below and the repeated ones will be illustrated only once.
	raw23D.m  raw22D.m
		These files are used to rearrange .raw to a image matrix
	matAdd.m  matAddConst.m  matDotMul.m  matSub.m  matSum.m  matTranspose.m constMatSub.m
		These files are used to define operator between mats or mat and number, or operator on mat itself.
	HisCount.m  TotalSum.m
		These files are used to help binarize.m to find threshold in terms of percentage. 
		HisCount.m counts the number of every pixel in the image, 
		1st parameter is the image, 2nd and 3rd parameters are the num of row and column of image.
		TotalSum.m calculate the pre-sum of the output of HisCount.m. So the CDF of pixel could be obtained.
		The input is output of HisCount.m, and the CDF of pixels is returned.
	reflectionPad.m  zeroPad.m
		These files are used to padding image by odd mirror padding or by zero padding.
		1st parameter is the noised image, 
		2nd parameter is the radius of comparision window.

In Problem1 folder, there are following files to implement algorithm.
	RGB2Gray.m
		This file is used to convert the 3-channel RGB image between 0-255 into grayscale image.
		There are three input parameters, R, G, B stands for the matrices stands for channel R, G and B respectively.
		The output is a matrix stands for grayscale image.
	sobel.m
		This file is used to implement sobel filter to a grayscale image.
		The input parameter is a grayscale image, three output stand for x-gradient, y-gradient and gradient map respectively.
	gradNorm.m
		This file is used to normalize gradient map to 0-255.
		The input parameter is unnormalized x-gradient, y-gradient, or gradient map, they are normalized to 0-255 and returned.
	binarize.m
		This file is used to binarize continuous image between 0-255 to a two-value image, either 0 or 255, in terms of percentage.
		1st parameter is a continuous grayscale image, 2nd parameter is threshold in terms of percentage.
		With the help of HisCount.m, TotalSum.m, pixels in the first threshold% in CDF will be set to 1, otherwise set to 0.
	imageInverse.m
		This file is used to invert 0 to 255, and 255 to 0 to show image, only used privately.
	calculatePRF.m
		This file is used to calculate precision, recall and F-measure from the return of edgesEvalImg().
		1st, 2nd, 3rd parameter are cntR, sumR, cntP, sumP from edgesEvalImg() and they are averaged, then precision, recall and F-measure are returned.
	bestPRF.m
		This file is used to find the best precision, recall and F-measure from the return of edgesEvalImg().
		1st, 2nd, 3rd parameter are cntR, sumR, cntP, sumP from edgesEvalImg()
In Problem2 folder, there are following files to implement algorithm.
	bin_01.m 
		This file is used to binarize a continuous grayscale image between 0-1 to a binarized image with 0 and 1. 
		Input parameter is a continuous grayscale image between 0-1, binarized image is returned.
	fixedThresholdDithering.m
		This file is used to implement fixed threshold dithering algorithm.
		1st parameter is a continuous grayscale image between 0-255, 2nd parameter is threshold in terms of value.
		If pixel is larger than the threshold, it will be set to 1, else set to 0. Binarized image is returned.
	randThDithering.m
		This file is used to implement random threshold dithering algorithm.
		Input parameter is a continuous grayscale image between 0-255. For every pixel, an uniformly distributed threshold is generated, then compared with the pixel,
		if it is larger than the threshold, it will be set to 1, else set to 0. Binarized image is returned.
	matrixDithering.m  Ipadd.m  Tgen.m
		These files are used to implement matrix dithering.
		In matrixDithering.m, threshold matirx is compared with pixels in images, and decide which pixels are set to 0 and which set to 1 with the error spreaded by others and fixed thresholding.
		Input parameter is the continuous grayscale image between 0-255, output are binarize images using 2*2, 8*8 and 32*32 dithering matirx respectively.
		In Ipadd.m, dithering matrix is generated by smaller one. The input parameter is dithering matirx, and a larger I matrix is returned.
		For example, if the input parameter is 2*2 dithering matirx, then 4*4 dithering matirx is returned.
		call this function recursively could obtain 8*8 dithering matirx and 32*32 dithering matirx.
		In Tgen.m, correspoinding threshold matrix is generated by dithering matrix.
		Input parameter is dithering matirx, correspoinding threshold matrix is returned.
	errorDiffusion.m
		This file is used to implement error diffusion algorithm.
		1st parameter is a continuous grayscale image betwee 0-1, 2nd and 3rd parameters are error diffusion matrix and mirrored error diffusion matrix by column.
		The image is zero padded im hte begining, then each pixel is decided to be 0 or 1, the error is spreaded to other pixels using serpentine scanning.
		Binarized image is returned.
	RGB2CMY.m
		This function is used to convert RGB images between 0-1 to CMY images and vice versa.
		Input parameter is a RGM or CMY image and the output is correspoinding CMY or RGB image.
	MBVQ.m  decidePix.m  MBVQCube.m  getNearestVertex.m
		These files are used to implement MBVQ algorithm.
		In MBVQ.m, there is only slight difference with errorDiffusion.m, three channels are input into this algorithm and doing error diffusion respectively, but the point is not decided by 
		fixed thresholding, instead, they are decided by decidePix.m.
		1st, 2nd, 3rd parameters are three channels of a continuous RGB image betwee 0-1, 4nd and 5nd parameters are error diffusion matrix and mirrored error diffusion matrix by column.
		The half-toned color image is returned.
		In decidePix.m, the R, G, B value of a single point in 3-channel RGB image is inputed, and the correspoinding tetrahedra is decided by MBVQCube.m, then the correspoinding vertex given 
		RGB value and tetrahedra is decided by getNearestVertex.m
		1st, 2nd, 3rd parameters are values of 3 channels of a continuous RGB image, the RGB value of correspoinding vertex is returned.
		In MBVQCube.m, the correspoinding tetrahedra is decided using RGB value.
		1st, 2nd, 3rd parameters are values of 3 channels of a continuous RGB image, correspoinding tetrahedra is returned.
		getNearestVertex.m is the opensource file given by TA.
/////////////////////////////////////////////////////////////////////////////
