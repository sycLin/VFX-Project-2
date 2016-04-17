function CylImg = cylindrical_projection(img, f, radius)
    row = size(img(:,:,1),1);
    col = size(img(:,:,1),2);
    xfrom = floor(-col/2);
    xto = ceil(col/2);
    yfrom = floor(-row/2);
    yto = ceil(row/2);
    
%     width = ceil(radius * 2 * abs(atan(xto/f) - atan(xfrom/f)))
%     height = round(radius*(abs(yfrom/f - yto/f) + 1))
    width = round(sin(atan(xto/f)) * radius)*2 + 10;
    height = round(yto/sqrt(f^2) * radius)*2 + 10;

    CylImg = ones(height, width, 3,'uint8');
    
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
            CylImg(CylCenterY + round(h), CylCenterX + round(sin(theta)*radius), :) = img(y+1, x+1, :);
            
        end
    end
end