function [origPts,distPts]=getMapPoints(distBuffx,distBuffy,origBuffx,origBuffy,i,j)
    
        ptx=origBuffx(i,j);
        pty=origBuffy(i,j);
        
        pt2x=origBuffx(i,j+1);
        pt2y=origBuffy(i,j+1);
        
        pt3x=origBuffx(i+1,j);
        pt3y=origBuffy(i+1,j);
        
        pt4x=origBuffx(i+1,j+1);
        pt4y=origBuffy(i+1,j+1);

        
        dptx=distBuffx(i,j);
        dpty=distBuffy(i,j);
        
        dpt2x=distBuffx(i,j+1);
        dpt2y=distBuffy(i,j+1);
        
        dpt3x=distBuffx(i+1,j);
        dpt3y=distBuffy(i+1,j);
        
        dpt4x=distBuffx(i+1,j+1);
        dpt4y=distBuffy(i+1,j+1);


        origPts=[ptx pty;pt2x pt2y; pt3x pt3y;pt4x pt4y];
        distPts=[dptx dpty;dpt2x dpt2y; dpt3x dpt3y;dpt4x dpt4y];

end