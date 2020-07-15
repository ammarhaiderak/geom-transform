function I=rubbersheet2(origPts,destPts,origImg,option)
    
    xy=destPts(1:4,1).*destPts(1:4,2);
    x=destPts(1:4,1);
    y=destPts(1:4,2);
    o=ones(4,1);
    z=zeros(4,4);
    
    XYcolVec=[origPts(1:4,1);origPts(1:4,2)];
    
    m=[xy x y o];
    
    fin=[[m z];[z m]];
    
    ifin=inv(fin);
    
    vals=ifin*XYcolVec;
    
    params1=vals(1:4);
    params2=vals(5:8);
    
    I=origImg;
    d2=zeros(size(origImg,1));
    
    for r=1:size(origImg,1)
        for c=1:size(origImg,2)
            X=[r*c c r 1]*params1;
            Y=[r*c c r 1]*params2;
            
            X=round(X);
            Y=round(Y);
                
            if X>=1 && Y>=1 && X<=size(origImg,2) && Y<=size(origImg,1)
                d2(r,c)=getgval(Y,X,origImg,option);
                %origImg(Y,X);
            end
            
        end
    end
    
    I=uint8(d2);
    
end
    


function v=getgval(r,c,origImg,option)

    v=origImg(r,c);
    if option==2            %Averaging
        if r<size(origImg,1) && c<size(origImg,2)
            r1=r+1;
            c1=c+1;

            r2=r+1;
            c2=c;

            r3=r;
            c3=c+1;



            v1=origImg(r1,c1);
            v2=origImg(r2,c2);
            v3=origImg(r3,c3);
            v4=v;

            v=mean([v1 v2 v3 v4]);

            v=round(v);    
        end
    elseif option==3            %Bilinear Interpolation
        if r<size(origImg,1) && c<size(origImg,2)
            r1=r+1;
            c1=c+1;

            r2=r+1;
            c2=c;

            r3=r;
            c3=c+1;



            v1=origImg(r1,c1);
            v2=origImg(r2,c2);
            v3=origImg(r3,c3);
            v4=v;

            
            
            m=[r1*c1 r1 c1 1;r2*c2 r2 c2 1;r3*c3 r3 c3 1;r*c r c 1];
            gvals=[v1;v2;v3;v4];
            
            ks=inv(m)*gvals;
            
            v=[r*c r c 1]*ks;
            
            v=round(v);
            
        end
        
        
    end
    
    
end



% function [X,Y]=getXY(vals,params1,params2)
%     X=vals*params1;
%     Y=vals*params2;
%     
%     X=round(X);
%     Y=round(Y);
% end


    
    
    
    

