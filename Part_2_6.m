%% 
% <latex>
% First we download the picture and display it. 
% </latex>
close all;
clear;
P = imread('images/book.jpg');
imshow(P);

%% 
% <latex>
% We use now \texttt{ginput} to find the coordinates of the 4 corners. We
% start in the upper right corner und continue clockwise. We also try to
% find the 4 corners of the book's title page. A DIN A4 paper has the
% dimensions $ 210$ mm $\times 297$ mm. The ratio is $ 1 : \sqrt{2}$. We
% fix the upper left corner to $(0,0)$ and we add a scale factor $s$.
% </latex>

%Applying ginput
[X_input,Y_input] = ginput(4);
% But we use these points, obtained from ginput, to get always the best
% result
points = [47,308;
        215,256;
        159,4;
        29,143];

des =  [0,210 ;
        297,210;
        297,0;
        0,0];

% Here Y is the vertical and X the horizontal value.
   
X = points(:,1);
Y = points(:,2);
    
    
    A = [X,Y, ones(4,1), zeros(4,3); zeros(4,3), X,Y, ones(4,1)];

A_end = zeros(8,2);
for i =1:4
    A_end(i,: ) = des(i,1) * points(i,:);
    A_end(i+4,:) = des(i,2) * points(i,:);
end

A = [A,-A_end];
v = [des(:,1);des(:,2)];

%%
% <latex>
% Now we we want to Acompute the variable $u = A^{-1} v$. To do that, we
% use the \texttt{\backslash} operator

u = A\v;

% Bringing it back into the original 3 times 3 matrix
U = reshape([u;1], 3, 3)';

%Testing
w = U*[X'; Y'; ones(1,4)];
w = w ./ (ones(3,1) * w(3,:));

if sum(abs(w(1:2,:) -des')) < 1e-12
    T = maketform('projective', U');
    P1 = imtransform(P, T, 'XData', [0 210], 'YData', [0 297]);
    figure;
    imshow(P1);
else
    error('Projection did not work, use other points')
end    