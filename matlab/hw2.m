function hw2()

img1 = imread('prtn01.jpg');
imgGray1 = rgb2gray(img1);
keypoints1 = my_harris(img1);
descriptors1 = descriptor(keypoints1, imgGray1);
[CylImg1, c_coor1] = cylindrical_projection(img1, 706.286, 706.286);

img2 = imread('prtn00.jpg');
imgGray2 = rgb2gray(img2);
keypoints2 = my_harris(img2);
descriptors2 = descriptor(keypoints2, imgGray2);
[CylImg2, c_coor2] = cylindrical_projection(img2, 704.916, 704.916);


matche_ans = matches(descriptors1, descriptors2);

plotMatches(img1, img2, matche_ans);


[combineImg, c_coor] = combine(img2, CylImg1, CylImg2, c_coor1, c_coor2, matche_ans);

img3 = imread('prtn17.jpg');
imgGray3 = rgb2gray(img3);
keypoints3 = my_harris(img3);
descriptors3 = descriptor(keypoints3, imgGray3);
[CylImg3, c_coor3] = cylindrical_projection(img3, 705.576, 705.576);

matche_ans = matches(descriptors2, descriptors3);

[combineImg, c_coor] = combine(img3, combineImg, CylImg3, c_coor, c_coor3, matche_ans);

img4 = imread('prtn16.jpg');
imgGray4 = rgb2gray(img4);
keypoints4 = my_harris(img4);
descriptors4 = descriptor(keypoints4, imgGray4);
[CylImg4, c_coor4] = cylindrical_projection(img4, 705.102, 705.102);

matche_ans = matches(descriptors3, descriptors4);

[combineImg, c_coor] = combine(img4, combineImg, CylImg4, c_coor, c_coor4, matche_ans);
% img2 = imread('prtn00.jpg');
% [CylImg, corresponding_coor] = cylindrical_projection(img2, 704.916, 704.916);
% imshow(CylImg)


end