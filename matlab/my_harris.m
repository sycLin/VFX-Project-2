function keypoints = my_harris(img)

k = 0.04;
Threshold = 50000;


% img = imread('prtn00.jpg');
imgGray = rgb2gray(img);
row = size(img, 1);
col = size(img, 2);
fx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
fy = [-1, -1, -1; 0, 0, 0; 1, 1, 1];

Ix = filter2(fx, imgGray);
Iy = filter2(fy, imgGray);
h = fspecial('gaussian', [5, 5], 1.5);

Ix2 = filter2(h,Ix.*Ix);
Iy2 = filter2(h,Iy.*Iy);
Ixy = filter2(h,Ix.*Iy);

% imshow(Ix2);

process = zeros(row, col);

for r=1:row
    for c=1:col
        M = [Ix2(r,c),Ixy(r,c);Ixy(r,c),Iy2(r,c)];
        R = det(M) - k * (trace(M) ^ 2);
        if (R > Threshold)
            process(r,c) = R;
        end
    end
end
dilation_kernel = [1,1,1;1,0,1;1,1,1];
output = process > imdilate(process, dilation_kernel);
keypoints = output;
% imshow(output)
% descriptors = descriptor(output, imgGray);
% imshow(img);

end