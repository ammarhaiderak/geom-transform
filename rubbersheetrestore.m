function I=rubbersheetrestore(origPts,destPts,origImg,destImg,startr,lastr,startc,lastc,target)

    
    xy=origPts(1:4,1).*origPts(1:4,2);
    x=origPts(1:4,1);
    y=origPts(1:4,2);
    o=ones(4,1);
    z=zeros(4,4);
    
    XYcolVec=[destPts(1:4,1);destPts(1:4,2)];
    
    m=[xy x y o];
    
    fin=[[m z];[z m]];
    
    ifin=inv(fin);
    
    vals=ifin*XYcolVec;
    
    params1=vals(1:4);
    params2=vals(5:8);
    
    %I=destImg;
    %cpy=zeros(size(origImg));
    %I=cpy;
    %(startr:lastr,startc:lastc);
    %origImg;
    %tdestImg=destImg;
    i=1;
    for r=startr:lastr
        %r=start:size(origImg,1)
        j=1;
        for c=startc:lastc
            
            [X,Y]=getXY([r*c r c 1],params1,params2);
            
   
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
            
            gval=getgval(X,Y,origImg);
            
            target(r,c)=gval;
            %I(i,j)=gval;
            j=j+1;
        end
        i=i+1;
    end
    
    I=target;
    %I=uint8(I);
    %uint8(I);
    
end
    


function v=getgval(X,Y,destImg)
    
    v=destImg(X,Y);
    if X<size(destImg,1) && Y<size(destImg,2)
        X1=X+1;
        Y1=Y+1;
        
        X2=X+1;
        Y2=Y;
        
        X3=X;
        Y3=Y+1;
        
        
        
        v1=destImg(X1,Y1);
        v2=destImg(X2,Y2);
        v3=destImg(X3,Y3);
        v4=v;
        
        v=mean([v1 v2 v3 v4]);
        
        v=round(v);    
    end

end



function [X,Y]=getXY(vals,params1,params2)
    X=vals*params1;
    Y=vals*params2;
    
    X=round(X);
    Y=round(Y);
end


    
    
    
    

