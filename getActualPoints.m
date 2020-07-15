function [bufferx,buffery]=getActualPoints(I,n)

    gap=size(I,1)/(n-1);
    gap2=size(I,2)/(n-1);

    i=1;
    k=1;

    bufferx=zeros(n,n);
    buffery=zeros(n,n);



    while i<=size(I,1)+gap
        j=1;
        l=1;
        while j<=size(I,2)+gap2
            ti=i;
            tj=j;
            if i>size(I,1)
                ti=size(I,1);
            end
            if j>size(I,2)
                tj=size(I,2);
            end

            bufferx(k,l)=ti;
            buffery(k,l)=tj;

            j=j+gap;
            l=l+1;
        end
        k=k+1;
        i=i+gap;

    end

    disp(bufferx);
    disp(buffery);


    figure(2);
    imshow(I);
    hold('on');
    for i=1:n
        for j=1:n
            plot(bufferx(i,j),buffery(i,j),'o','color','blue');
        end
    end
    hold('off');
    
    bufferx=transpose(bufferx);
    buffery=transpose(buffery);

end





