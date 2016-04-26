my_harris
---
		param 	rgbimg			input rgb image to extract harris feature point

		return keypoints		binary matrix, piexl with value 1 is keypoint


descriptor
---
		param 	keypoints		binary matrix, piexl with value 1 is keypoint
		param 	grayimg 		gray level image of the keypoints' original image

		return descriptors		the descriptors of these feature points


cylindrical_projection
---
		param  rgbimg			input rgb image to do cylindrical projection
		param 	f 				focal length
		param  radius 			radius of cylindrical

		return [CylImg,c_coor] cylindrical projection image and lookup table for original image to processed image


matches
---
		param 	descriptors1 	descriptors to be matched
		param 	descriptors2	descriptors to be matched

		return matche_ans 		structure containing all matched pairs and its cosine similarity of two image


plotMatches
---
		draw detected pairs for two image


combine
---
		param 	rgbimgR 		the rgb image to be combined(on the right side)
		param 	CylImg1			cylindrical projection image(on the left side)
		param 	CylImg2 		cylindrical projection image(on the right side)
		param 	c_coor1 		lookup table for left side cylindrical projection image
		param 	c_coor2			lookup table for right side cylindrical projection image
		param 	matche_ans 		structure containing all matched pairs and its cosine similarity of two image
 
		return [combineImg,c_coor] 	combined image(regard as cylindrical projection image) and new lookup table for right side image to result image



