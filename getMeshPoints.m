function [buffx,buffy] = getMeshPoints (o,n)

    figure(1);
    
    set(gcf, 'Position', get(0, 'Screensize'));
   

    i=1;
    c=1;

    
    buffx=zeros(n,n);
    buffy=zeros(n,n);
    imshow(o);
    hold('on');
    
    
    [x,y]=ginput(1);
    buffx(1,1)=x;
    buffy(1,1)=y;
    
    plot(x,y,'o','color','red');
    
  
    for i=1:n
        if i==1
            j=2;
        else
            j=1;
        end
        
        while j<=n
           [x,y]=ginput(1);
           buffx(i,j)=x;
           buffy(i,j)=y;
           plot(x,y,'o','color','red');
           
           if j>1
               prevx1=buffx(i,j-1);
               prevy1=buffy(i,j-1);
               
               plot([x prevx1],[y prevy1],'color','red');
               
           end
           if i>1
               prevx2=buffx(i-1,j);
               prevy2=buffy(i-1,j);
               
               plot([x prevx2],[y prevy2],'color','red');
           end
               
           j=j+1; 
        end
    end

    hold('off');    


end