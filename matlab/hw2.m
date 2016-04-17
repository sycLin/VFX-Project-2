function hw2()
%{
img1 = imread('prtn01.jpg');
imgGray1 = rgb2gray(img1);
keypoints1 = my_harris(img1);
descriptors1 = descriptor(keypoints1, imgGray1);

img2 = imread('prtn00.jpg');
imgGray2 = rgb2gray(img2);
keypoints2 = my_harris(img2);
descriptors2 = descriptor(keypoints2, imgGray2);

matche_ans = matches(descriptors1, descriptors2);

plotMatches(img1, img2, matche_ans);
%}

img2 = imread('prtn00.jpg');
CylImg = cylindrical_projection(img2, 704.916, 704.916);
imshow(CylImg)


end