function hw2_new(file_path)

% get the paths and focal lendths from file

[paths, focals] = textread(file_path, '%s %f');
total_count = size(paths, 1);

% read the images

images = cell(total_count, 1);
for i = 1:total_count
	images{i} = imread(paths{i});
end

% convert to grayscale

gray_images = cell(total_count, 1);
for i = 1:total_count
	gray_images{i} = rgb2gray(images{i});
end

% compute keypoints
keypoints = cell(total_count, 1);
for i = 1:total_count
	keypoints{i} = my_harris(images{i});
end

% compute descriptors
descriptors = cell(total_count, 1);
for i = 1:total_count
	descriptors{i} = descriptor(keypoints{i}, gray_images{i});
end

% do cylindrical projection
cylin_images = cell(total_count, 1);
cylin_coords = cell(total_count, 1);
for i = 1:total_count
	[cylin_images{i}, cylin_coords{i}] = cylindrical_projection(images{i}, focals(i), focals(i));
end

% combining stage
combined_image = cylin_images{1} % initialize
combined_cylin_coord = cylin_coords{1} % initialize
for i = 2:total_count
	matches_result = matches(descriptors{i-1}, descriptors{i});
	[combined_image, combined_cylin_coord] = combine(images{i}, combined_image, cylin_images{i}, combined_cylin_coord, cylin_coords{i}, matches_result);
end

% write the result
imwrite(combined_image, 'result.jpg');

end
