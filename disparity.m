function [ disp_map ] = disp_map2( PL, PR, ny,nx )
%DISP_MAP 
    
    PL = double(rgb2gray(PL));
    PR = double(rgb2gray(PR));

    [sizey sizex] = size(PL);
    disp_map = ones(sizey,sizex) * 1337;
    
   %Enlarge the left picture, such that, every pixel has a n times
   %neighbourhood
   
   enlPL = [ zeros(floor(ny/2),sizex) ; PL ; zeros(floor(ny/2),sizex) ];
   enlPL = [ zeros(sizey  + ny - 1 , floor(nx/2)), enlPL, zeros(sizey + ny -1, floor(nx/2))];
   PRsquare = PR.^2;
    for y = 1:sizey
        for x = 1:sizex
            %i) extract template
            %template = enlPL(y - ceil(ny/2):y + floor(ny/2), x - ceil(nx/2)): x + floor(nx/2);
            template = enlPL(y:ny+y-1,x:nx+x-1);
            %ii) Compute SSD, note that convolution is correlation with
            %template rotated by pi
            
            %We are only interested in the y'th line of PR, therefore we
            %can reduce it
%             ly = max(1,y- ny - 1);
%             uy = min(sizey, y + ny +1);
%             lx = max(1, x- 16);
%             ux = min(sizex, x +16);
           
            % Compute SSD matrix  
            SSD = 2 * conv2(PR, rot90(rot90(template)),'same') - conv2(PRsquare, ones(ny,nx),'same') ;
            
            
            %Find position of maximum in same line, and closer as 15 to x
            
           
            %Extract the line associated with y
            line = SSD(y,:);
            
            %Find the position with the maximum = argmax
            argmax = -Inf;
            x_hat = 42;
            for t = 1:length(line)
                if line(t) > argmax
                    argmax = line(t);
                    x_hat = t;
                end
            end
            
            %Shift x_hat back
            
            
            disp_map(y,x) = max(min(x - x_hat,15),-15);
            end
    end
    
 end

