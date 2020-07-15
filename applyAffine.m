function I=applyAffine(origPts,destPts,origImg,destImg)
    #disp(origPts);
    
    destX=destPts(:,1);
    
    rows=size(origPts,1);
    
    tmp1=[origPts ones(rows,1)];
    tmp2=transpose(tmp1)*tmp1;
    tmp3=transpose(tmp1)*destX;
    params1=inv(tmp2)*tmp3;
    
    destY=destPts(:,2);
    
    tmp3=transpose(tmp1)*destY;
    params2=inv(tmp2)*tmp3;
    
    I=zeros(size(origImg,1),size(origImg,2));
    for r=1:size(origImg,1)
        for c=1:size(origImg,2)
            X=[r c 1]*params1;
            Y=[r c 1]*params2;
        
            X=round(X);
            Y=round(Y);
        
            
            
            if X<1
                X=1;
            endif
            if Y<1
                Y=1;
            endif
            if X>size(destImg,1)
                X=size(destImg,1);
            endif
            
            if Y>size(destImg,2)
                Y=size(destImg,2);
            endif
                
            gval=destImg(X,Y);
            
            
            #if X<size(destImg,1) && Y<size(destImg,2)
            #    X1=X+1;
            #    Y1=Y+1;
            
            #    X2=X;
            #    Y2=Y+1;
            
            #    X3=X+1;
            #    Y3=Y;
            
            #    v1=destImg(X1,Y1);
            #    v2=destImg(X2,Y2);
            #    v3=destImg(X3,Y3);
            #    v4=destImg(X,Y);
                
            #    avgv=(v1+v2+v3+v4)/4;
                
            #    gval=round(avgv);
                
            #endif
                
            I(r,c)=gval;
            
        endfor
    endfor
    
    I=uint8(I);
    
endfunction



