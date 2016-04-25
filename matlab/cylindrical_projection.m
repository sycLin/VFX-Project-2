function [CylImg, corresponding_coor] = cylindrical_projection(img, f, radius)
    row = size(img(:,:,1),1);
    col = size(img(:,:,1),2);
    xfrom = floor(-col/2);
    xto = ceil(col/2);
    yfrom = floor(-row/2);
    yto = ceil(row/2);
    
    corresponding_coor = repmat(struct('CylY',0,'CylX',0), row, col);
    
%     width = ceil(radius * 2 * abs(atan(xto/f) - atan(xfrom/f)))
%     height = round(radius*(abs(yfrom/f - yto/f) + 1))
    width = round(atan(xto/f) * radius)*2 + 10;
    height = round(yto/sqrt(f^2) * radius)*2 + 10;

    CylImg = zeros(height, width, 3,'uint8');
    
    CylCenterX = round(width/2);
    CylCenterY = round(height/2);
    
    
    for x=0:col-1
        for y=0:row-1
            
            proX = ceil(x - col/2);
            proY = ceil(y - row/2);
            
            theta = atan(proX/f);
            h = proY/sqrt(proX^2 + f^2) * radius;
%             round(h)
%             round(sin(theta)*radius)
            CylImg(CylCenterY + round(h), CylCenterX + round(theta*radius), :) = img(y+1, x+1, :);
            
            corresponding_coor(y+1, x+1) = struct('CylY', CylCenterY + round(h),'CylX', CylCenterX + round(sin(theta)*radius));
            
        end
    end
end