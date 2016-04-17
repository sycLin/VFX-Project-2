function [combineImg, corresponding_coor] = combine(img2, CylImg1, CylImg2, c_coor1, c_coor2, matches)
%     [img1Row, img1Col] = size(img1(:,:,1));
    [img2Row, img2Col] = size(img2(:,:,1));
    [CylImg1Row, CylImg1Col] = size(CylImg1(:,:,1));
    [CylImg2Row, CylImg2Col] = size(CylImg2(:,:,1));
    corresponding_coor = repmat(struct('CylY',0,'CylX',0), img2Row, img2Col);
    for match=1:size(matches, 1)
        if matches(match).distance > 0.3
            continue;
        else
            desc1 = matches(match).Imgdescriptor1; 
            desc2 = matches(match).Imgdescriptor2;
            
            xPos1 = desc1.kpX; 
            yPos1 = desc1.kpY;
            CylX1 = c_coor1(yPos1, xPos1).CylX;
            CylY1 = c_coor1(yPos1, xPos1).CylY;
            
            xPos2 = desc2.kpX; 
            yPos2 = desc2.kpY;
            CylX2 = c_coor2(yPos2, xPos2).CylX;
            CylY2 = c_coor2(yPos2, xPos2).CylY;
        end
    end
    Xalignment = ((CylImg1Col - CylX1 + 1) + (CylX2));
    Yalignment = CylY1 - CylY2
    combineImg = zeros(CylImg1Row + abs(Yalignment) , CylImg1Col + CylImg2Col - Xalignment, 3, 'uint8');
    if Yalignment < 0
        combineImg(1:CylImg1Row, 1:CylImg1Col,:) = CylImg1(:,:,:);
    else
        combineImg(abs(Yalignment)+1:size(combineImg(:,:,1),1), 1:CylImg1Col, :) = CylImg1(:,:,:);
    end
    
    weighted = [1:img2Row];
    weighted = weighted./max(weighted);
    
    originX = CylX1 - CylX2;
    originY = CylY1 - CylY2;
    if Yalignment > 0
        originY = originY + abs(Yalignment);
    end
    
    for row=1:img2Row
        for col=1:img2Col
            c_x = c_coor2(row,col).CylX;
            c_y = c_coor2(row,col).CylY;
            combineImg(originY + c_y, originX + c_x, :) = CylImg2(c_y, c_x,:);
            corresponding_coor(row, col) = struct('CylY', originY + c_y,'CylX', originX + c_x);
        end
    end
    
    imshow(combineImg)
    
end