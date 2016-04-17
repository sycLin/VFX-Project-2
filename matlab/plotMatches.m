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
        
%         octave1 = desc1.octave; 
        xPos1 = desc1.kpX; 
        yPos1 = desc1.kpY; 
        
%         if(octave1==1)
%             xPos1 = round(xPos1/2); 
%             yPos1 = round(yPos1/2); 
%         end
% 
%         if(octave1>2)                        
%             xPos1 = xPos1 * (2^(octave1-2)); 
%             yPos1 = yPos1 * (2^(octave1-2)); 
%         end
        
        
%         octave2 = desc2.octave; 
        xPos2 = desc2.kpX; 
        yPos2 = desc2.kpY; 
        
%         if(octave2==1)
%             xPos2 = round(xPos2/2); 
%             yPos2 = round(yPos2/2); 
%         end
% 
%         if(octave2>2)                        
%             xPos2 = xPos2 * (2^(octave2-2)); 
%             yPos2 = yPos2 * (2^(octave2-2)); 
%         end
        
        xPos2 = widthImage1 + xPos2;

        plot([xPos1,xPos2],[yPos1,yPos2]);

    end 
    hold off;
end