function [destPts] = getTiePoints (n,o)

    figure(2);imshow(o);
    %helpdlg('Alternately Select corresponding tie points from both images\n select one point from orignal image and then select one point from distorted image and so on.' ,'Instructions!');
    I=o;
    %I2=d;
    set(gcf, 'Position', get(0, 'Screensize'));
    

    %subplot(1,2,1);imshow(I);
   % subplot(1,2,2);imshow(I2);



    i=1

   % origPts=[];
    destPts=[];

    while i < n+1
        %subplot(1,2,1);
%         hold('on');
%         [x,y]=ginput(1);
%         a.x=x;
%         a.y=y;
%         origPts=[origPts;[x y]];
%         

        %printf('Original: (%d,%d)',x,y);
       % plot(x,y,'*','color','red');
      %  hold('off');    

      %  subplot(1,2,2);
        
        hold('on');
        [x,y]=ginput(1);
     
        %destPts(i)=b;
        destPts=[destPts;[x y]];
        
        %destPts(i)=[x,y];
        %printf('Distorted: (%d,%d)',x,y);
        plot(x,y,'*','color','blue');
        

        i=i+1;
    end


    hold('off');
    close(gcf);

end