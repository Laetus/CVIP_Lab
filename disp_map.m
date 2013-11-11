function [ disp_map ] = disp_map( PL, PR, ny,nx )
 
%%
% <latex>
% At first, we convert calculate the image intensities. To do that we use
% the \texttt{rgb2gray} command and apply the \texttt{double} method
% afterwards. We initialize the parameter \texttt{disp\_map} which will
% contain the disparity information.
% </latex>

    PL = double(rgb2gray(PL));
    PR = double(rgb2gray(PR));
    [sizey, sizex] = size(PL);
    disp_map = ones(sizey,sizex) * 1337;
%%
% <latex>
% Not every pixel in \texttt{PL} has a $n_y \times n_x$ neighbourhood. So
% we enlarge \texttt{PL} with zeros, such that the pixels close to the
% frame get a bigger neighbourhood
% </latex>

   enlPL = [ zeros(floor(ny/2),sizex) ; PL ; zeros(floor(ny/2),sizex) ];
   enlPL = [ zeros(sizey  + ny - 1 , floor(nx/2)), enlPL, zeros(sizey ...
            + ny -1, floor(nx/2))];
   PRsquare = PR.^2;
%% 
% <latex>
% We have to calculate the disparity for every pixel. To do that, two loops
% are used.
% </latex>

   for y = 1:sizey
        for x = 1:sizex
            %%
            % <latex>
%             Due to the preprocessing, the template is now easy to adress.
%             The center of the template is the pixel y,x in \texttt{PL}
            % </latex>
            
            template = enlPL(y:ny+y-1,x:nx+x-1);        
            %%
            % <latex>
%             We are supposed to find the corresponding point in the same
%             scanline. That means, that the y coordinates must be the
%             same.  An other restriction is, that only disparities smaller
%             than $15$ are considered. to save time, we calculate the SSD
%             only for a small part of the image. The lower and upper
%             bounds are calculated as follows. The image part has to be as big
%             as the template, otherwise, we the SSD results are wrong. As
%             we the corresponding point in \texttt{PR} must be less than 15 away, we have
%             to find the maximum position in $31 = \underbrace{15}_{\text{left of} \ (y,x) } + \underbrace{15}_{\text{right of} \ (y,x) } + \underbrace{1}_{ the pixel (x,y)}$ pixels.
%             </latex>
            
            ly = max(1,y - floor(ny/2));
            uy = min(sizey, y + floor(ny/2));
            lx = max(1, x - 15 - floor(nx/2));
            ux = min(sizex, x + 15 + floor(nx/2));
            %%
            % <latex>
%             The SSD is defined as the following \begin{align*} S(x,y) & =
%             \sum \limits_{j=0}^{M} \sum
%             \limits_{k=0}^{N} \left ( I(x+j,y+k)  - T(j,k) \right)^2  \\ & = \sum \limits_{j=0}^{M} \sum
%             \limits_{k=0}^{N} I^2 (x+j, y+k) *1 + \underbrace{\sum \limits_{j=0}^{M} \sum
%             \limits_{k=0}^{N} T^2(j,k)}_{= \ \text{constant}} - 2 \sum \limits_{j=0}^{M} \sum
%             \limits_{k=0}^{N} I(x+j,y +k )T(j,k) \end{align*} 
%             If the first and third term had $(x-j,y-k)$ instead of
%             $(x+j,y+k)$ we could write this as: \\ $$ I \oplus 2 - 2*
%             I \oplus T $$, where $\oplus $ denotes convolution. But
%             as we learned also correlation, here denoted with
%             $\otimes $, and this is applied here. As the minimum must
%             be found, the constant term can be omitted. So we get $$ I^2
%             \otimes \mathds{1} - 2 (I \otimes T)$$ . \texttt{MATLAB}
%             only provides the convolution method \texttt{conv2}. $\mathds{1}$ represents a matrix, which has the same size as $T$ and every entry is $1$.  But in
%             the lecture was shown, that $$A \otimes B =  A \oplus
%             rot180(B) $$. Multiplication with $-1$ turns the problem from
%             a minimization to a maximization problem and we get: \\ $$ 2
%             * (I \oplus
%             \underbrace{\mathrm{rot}90(\mathrm{rot}90(T)}_{90+90 = 180} -
%             I^2 \oplus \underbrace{\mathds{1}}_{\mathrm{rot}180(\mathds{1} ) = \mathds{1}} $$
            % </latex>
            
            SSD =2*conv2(PR(ly:uy,lx:ux),rot90(rot90(template)),'same')...
                - conv2(PRsquare(ly:uy,lx:ux), ones(ny,nx),'same') ;
            %%
            % <latex>
%             As we cropped the image, we have to find the scanline and the
%             position of x.
            % </latex>
            
            %In which line in SSD is line y now?
            if ly ~= 1
                line = SSD(floor(ny/2) + 1,:);
            else
                line = SSD(end - floor(ny/2),:);
            end
            
            %Which entry of line is associated with x?
            if lx ~= 1
                xposition = floor(nx/2) + 15 +1;
            else
                xposition = length(line) - floor(nx/2) - 15 ;
            end
            %% 
            % <latex>
%             We turned the original minimization problem into a
%             maximization problem. Here we look for the disparity, which
%             has the maximum SSD value and is smaller or equal to $15$. 
            % </latex>
            
            argmax = -Inf;
            disparity = -16;
                    
            for t = 15:-1:0
                plus = xposition + t;
                minus = xposition - t;
                if  minus > 0 && line(minus) > argmax
                    argmax = line(minus);
                    disparity = -t;
                end
                if  plus <= length(line) && line(plus) > argmax
                    argmax = line(plus);
                    disparity = t;
                end
            end
            %%
            % <latex>
%             Finally we found the disparity for (y,x) and we add this
%             value to the disparity matrix \texttt{disp\_map}. This function returns this parameter.  
            % </latex>
            
            disp_map(y,x) = disparity;
        end
    end
 end

