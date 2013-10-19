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
% start in the upper left corner and continue clockwise. We also try to
% find the 4 corners of the book's title page. A DIN A4 paper has the
% dimensions $210  mm \times 297$ mm. We fix the upper left corner to $(0,0)$.
% </latex>

%Applying ginput
[X_input,Y_input] = ginput(4);
% But we use the coordinates below, obtained from ginput, to get always the best
% result
points = [143,29;
          308,47;
          256,215;
          4,159;
          ];
% The desired coordinates are:
des =  [0,0;
        210,0;
        210,297;
        0,297;
        ];
% Here Y is the vertical and X the horizontal value.
X = points(:,1);
Y = points(:,2);    
% Create the first 6 columns of A
A = [X,Y, ones(4,1), zeros(4,3); zeros(4,3), X,Y, ones(4,1)];
A_end = zeros(8,2);
%Compute the two last  columns
for i =1:4
    A_end(i,: ) = des(i,1) * points(i,:);
    A_end(i+4,:) = des(i,2) * points(i,:);
end
%Put everything together
A = [A,-A_end];
v = [des(:,1);des(:,2)];
%%
% <latex>
% Note that, the rows of $A$ and $v$ are permuted, compared to equation (*). We first consider the rows containing $x_{im}$ and then the
% rows containing $y_{im}$. This trick makes it easier to create the matrix
% in \texttt{MATLAB}. In linear algebra is shown, that this operation does not affect $u$ at all. The differences are shown below:
% </latex>
A
v
%Order rows
order = [1,5,2,6,3,7,4,8];
A_star = A(order,:)
v_star = v(order)
%%
% <latex>
% Now we we want to compute the variable $u = A^{-1} v$. To do that, we
% use the \texttt{$\backslash$} operator
% </latex>

u = A\v
% Bringing it back into the original 3 times 3 matrix
U = reshape([u;1], 3, 3)';
%Testing
w = U*[X'; Y'; ones(1,4)];
w = w ./ (ones(3,1) * w(3,:));
%Is w and des close enough?
if sum(abs(w(1:2,:) -des')) < 1e-12
    T = maketform('projective', U');
    P1 = imtransform(P, T, 'XData', [0 210], 'YData', [0 297]);
    figure;
    imshow(P1);
else
    error('Projection did not work, use other points')
end
%%
% <latex>
% The new image is a little bit blurred, especially in the upper half of the
% picture. In the original picture, we see, that this is the part,
% which is farer away from the camera. A pixel in the back of the original picture
% represents a bigger area than a point in the foreground. Therefore we have
% less information about the background and so the upper half of the new
% picture must have worse quality.
% </latex>