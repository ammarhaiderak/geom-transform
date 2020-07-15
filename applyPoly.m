function I=applyPoly(origPts,destPts,origImg,destImg)
    %disp(origPts);
    
    destX=destPts(:,1);
    
    rows=size(origPts,1);
    
    xsquared=origPts(:,1).*origPts(:,1);
    ysquared=origPts(:,2).*origPts(:,2);
    xy=origPts(:,1).*origPts(:,2);
    x=origPts(:,1);
    y=origPts(:,2);
    
    tmp1=[xsquared ysquared xy x y ones(rows,1)];
    
    
    %tmp1=[origPts ones(rows,1)];
    
    
    
    
    
    %tmp1=[origPts ones(rows,1)];
    
    
    
    
    tmp2=transpose(tmp1)*tmp1;
    tmp3=transpose(tmp1)*destX;
    params1=inv(tmp2)*tmp3;
    
    destY=destPts(:,2);
    
    tmp3=transpose(tmp1)*destY;
    params2=inv(tmp2)*tmp3;
    
    I=zeros(size(origImg,1),size(origImg,2));
    for r=1:size(origImg,1)
        for c=1:size(origImg,2)
            X=[r*r c*c r*c r c 1]*params1;
            Y=[r*r c*c r*c r c 1]*params2;
            
            
            
        
            X=round(X);
            Y=round(Y);
            if X<1
                X=1;
            end
            if Y<1
                Y=1;
            end
            if X>size(destImg,1)
                X=size(destImg,1);
            end
            
            if Y>size(destImg,2)
                Y=size(destImg,2);
            end
                
            I(r,c)=destImg(X,Y);
        end
    end
    
    I=uint8(I);
    
            
end



 
