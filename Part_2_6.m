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

%[X,Y] = ginput(4);
% Results from previous ginput(4)
X = [308,258,5,144]';
Y = [47,217,160,28]';

% Here Y is the vertical and X the horizontal value.
s = 1;
threshold = [X(4),Y(4)];
des =  [210,0 ;
            210,297;
            0,297;
            0,0];
% Adding a threshold and scaling 
% des = repmat(threshold,4,1) + s .* des;

v = [des(:,1);des(:,2)]
A = [X,Y, ones(4,1), zeros(4,3); zeros(4,3), X,Y, ones(4,1)];

hT = zeros(8,2);
for i = 1:4
    hT(i,:) = v(i) * des(i,:);
    hT(i+4,:) = v(i+4) * des(i,:);
end

A = [A,-hT];

%%
% <latex>
% Now we we want to compute the variable $u = A^{-1} v$. To do that, we
% use the \backslash operator


u = A\v

% Brining it back into the original 3 times 3 matrix
U = reshape([u;1], 3, 3)';

%Testing
w = U*[X'; Y'; ones(1,4)];
w = w ./ (ones(3,1) * w(3,:));

T = maketform('projective', U');
P1 = imtransform(P, T, 'XData', [0 210], 'YData', [0 297]);
figure;
imshow(P1);