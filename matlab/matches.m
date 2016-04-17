function matches = matches(Imgdescriptor1, Imgdescriptor2)
    matches = repmat(struct('Imgdescriptor1',Imgdescriptor1(1),'Imgdescriptor2',Imgdescriptor2(1), 'distance',9999), size(Imgdescriptor1,1),1);
    for kp1=1:size(Imgdescriptor1, 1)
        miniDistance = 99999999;
        miniDisIndex = -1;
        for kp2=1:size(Imgdescriptor2, 1)
            
            distance = sqrt(sum((Imgdescriptor1(kp1).kpDescriptor - Imgdescriptor2(kp2).kpDescriptor).^2));
            if(distance < miniDistance)
                miniDistance = distance;
                miniDisIndex = kp2;
            end
        end
        
        if(miniDisIndex == -1)
            continue
        end
        matche = struct('Imgdescriptor1',Imgdescriptor1(kp1),'Imgdescriptor2',Imgdescriptor2(miniDisIndex),'distance',miniDistance);
        matches(kp1) = matche;
        
    end
end