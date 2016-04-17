function kpDescriptors = descriptor(keypoints, grayImg)
    [kyrow kycol] = find(keypoints == 1);
    [Gmag,Gdir] = imgradient(grayImg);
    
    DESC_WIN_SIZE = 16;
%     figure; imshowpair(Gmag, Gdir, 'montage');
%     title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')
%     axis off;
    kpDescriptors = repmat(struct('kpDescriptor',zeros(128,1),'kpX',0,'kpY',0),size([kyrow kycol], 1), 1);
    
    GaussWeights = fspecial('Gaussian', [DESC_WIN_SIZE DESC_WIN_SIZE], DESC_WIN_SIZE/2);
    GaussWeights = GaussWeights.*(1/max(max(GaussWeights))); 
    
    for kp=1:size([kyrow kycol], 1)
        
        kpDescriptor = zeros(128,1);
        currRow = kyrow(kp);
        currCol = kycol(kp);
        
        for x=0:DESC_WIN_SIZE-1
            for y=0:DESC_WIN_SIZE-1
                
                cellX = floor(x/4);
                cellY = floor(y/4);
                
                coorX = round(currCol + x - DESC_WIN_SIZE/2);
                coorY = round(currRow + y - DESC_WIN_SIZE/2);
                if(coorX>0 && coorY>0 && coorX<=size(grayImg, 2) && coorY<=size(grayImg, 1))
                    mag = Gmag(coorY, coorX) * GaussWeights(y+1, x+1);
                    orient = ceil((Gdir(coorY, coorX)+180)/45);
                    if orient == 0
                        orient = 1;
                    end
                    kpDescriptor((cellY*4+cellX)*8 + orient) = kpDescriptor((cellY*4+cellX)*8 + orient) + mag;
                end
               
            end
        end
        
        %normalize all descriptor
        sqKpDescriptor = kpDescriptor.^2; 
        sumSqKpDescriptor = sum(sqKpDescriptor);
        dem = sqrt(sumSqKpDescriptor); 
        kpDescriptor = kpDescriptor./dem;
        
        kpDescriptors(kp) = struct('kpDescriptor',kpDescriptor,'kpX',kycol(kp),'kpY',kyrow(kp));
        
        
    end
end