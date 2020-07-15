function [transformed]=simpleTransformInv(I,origPts,option)
%I=imread('cam.bmp');
if size(I,3)>1
    I=rgb2gray(I);
end


%helpdlg('You are required to click at 4 different positions Row wise order!');





destPts=[1 1;size(I,2) 1;1 size(I,1);size(I,2) size(I,1)];






% tmp=I;
% tmp2=D;
% 
% figure(2);imshow(tmp);
% hold('on');
% plot(origPts(:,1),origPts(:,2),'*');
% hold('off');
% 
% 
% figure(3);imshow(tmp2);
% hold('on');
% plot(destPts(:,1),destPts(:,2),'*','color','red');
% hold('off');

%I=sub1;
%D=subd1;
transformed=zeros(size(I));
transformed=rubbersheet2(origPts,destPts,I,option);
%figure(4);imshow(transformed);
imwrite(transformed,'restored_simple.bmp');


% restored=zeros(size(I));
% restored=rubbersheet2(destPts,origPts,distorted);
% figure(5);imshow(restored);
% imwrite(restored,'restored.bmp');

end