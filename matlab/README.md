# VFX-Project-2 matlabe 
===
### 使用說明
* 在合併圖片時將舊的圖片放在左側，要併上的圖片則在右側，照著此步驟完成一張全景圖(有兩個圖片參數時,左變那個參數為左側圖片)
* 在做cylindrical_projection的時候建議將focal length 和 radius設為相同的值

my_harris
---
This function implement the harris coner detection, k=0.04 threshold=50000, and use 5x5 gaussion function to weight each detection window. we take the local maxima form the previous result in 4x4 area as the final result and retrun the binary image.

		param 	rgbimg			input rgb image to extract harris feature point

		return  keypoints		binary matrix, piexl with value 1 is keypoint


descriptor
---
This function take the image key points as input and use SIFT feature descriptor to descript each key point with 128 dimension.
For each key point we use gaussion wieghted 16x16 window in 8 orient to descript it and accumulate 4x4 window size in 16x16 area to one dimension(total result 128 dimension for one key point, 16x8)

		param 	keypoints		binary matrix, piexl with value 1 is keypoint
		param 	grayimg 		gray level image of the keypoints' original image

		return descriptors		the descriptors of these feature points


cylindrical_projection
---
This function warp the origin image to cylindrical surfaces by given focal length and cylindrical radius. The result this the projected image and the coordinate lookup table for original image to processed image.

		param  rgbimg			input rgb image to do cylindrical projection
		param  f 			focal length
		param  radius 			radius of cylindrical

		return [CylImg,c_coor] cylindrical projection image and lookup table for original image to processed image


matches
---
This function take two image descriptors as input and calculate the cosin similarity to match the similar key points. The result return the pair of descriptors and its cosin similarity value.

		param 	descriptors1 	descriptors to be matched
		param 	descriptors2	descriptors to be matched

		return  matche_ans 	structure containing all matched pairs and its cosine similarity of two image


plotMatches
---
The function can draw detected pairs for two image to demonstrate the match function's result.


combine
---
This function take two cylindrical image as input and return the combined image. We calculate the shifting of two image's matched key points and use voting to choose the highest(will resize the height of result image according to the y coordinate shifting), then using blending(a weighted function for overlap piexls according to distance to two image) to combine two cylindrical images.

		param 	rgbimgR 		the rgb image to be combined(on the right side)
		param 	CylImg1			cylindrical projection image(on the left side)
		param 	CylImg2 		cylindrical projection image(on the right side)
		param 	c_coor1 		lookup table for left side cylindrical projection image
		param 	c_coor2			lookup table for right side cylindrical projection image
		param 	matche_ans 		structure containing all matched pairs and its cosine similarity of two image
 
		return [combineImg,c_coor] 	combined image(regard as cylindrical projection image) and new lookup table for right side image to result image



