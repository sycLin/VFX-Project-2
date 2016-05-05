function plotMatches(image1, image2, matches)
    heightImage1 = size(image1,1); 
    widthImage1 = size(image1,2); 
    
    heightImage2 = size(image2,1); 
    widthImage2 = size(image2,2); 
    
    totFrameWidth = widthImage1 + widthImage2; 
    if(heightImage1>heightImage2)
        totFrameHeight = heightImage1; 
    else
        totFrameHeight = heightImage2; 
    end
    
    combinedImage = ones(totFrameHeight, totFrameWidth,3);
    
    
    combinedImage(1:heightImage1, 1:widthImage1,:) = image1;
    
    combinedImage(1:heightImage2,(widthImage1+1):(widthImage2+widthImage1),:) = image2; 
    
    imagesc(double(combinedImage)/double(255));
    
    hold on; 
    for match = 1:size(matches,1)
        
        if matches(match).distance > 0.4
            continue;
        end
        
        desc1 = matches(match).Imgdescriptor1; 
        desc2 = matches(match).Imgdescriptor2; 
        

        xPos1 = desc1.kpX; 
        yPos1 = desc1.kpY; 
        

        xPos2 = desc2.kpX; 
        yPos2 = desc2.kpY; 
        

        
        xPos2 = widthImage1 + xPos2;

        plot([xPos1,xPos2],[yPos1,yPos2]);

    end 
    hold off;
end