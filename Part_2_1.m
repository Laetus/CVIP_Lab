%%
% <latex>
% All images are stored in a separate folder called 'images'. This leads to
% a tidy workspace. But we have to add the name of the folder to the image name.
% </latex>

Pc = imread('images/mrttrainbland.jpg');
%%
% <latex>
% The command \texttt{whos} gives a short summary of the matrix properties.
% </latex>

whos Pc
%%
% <latex>
% We see, that the matrix has RGB values. We see this because the third dimension is 3. To convert it to a matrix with
% grey-scale values, we use the method \texttt{rgb2gray}
% </latex>

P =rgb2gray(Pc);
whos P
%%
% <latex>
% The command \texttt{imshow} shows the picture in a new figure.
% </latex>

imshow(P)
%%
% <latex>
% We find the minimum $\min_P$ and maximum $\max_P$ intensities with the following:
% </latex>

min_P = min(P(:)),max_P = max(P(:))

%%
% <latex>
% We want a picture $P_1$, such that $\min_{P_1} = 0 $ and $\max_{P_1}
% = 255$. To reach this, we subtract at first $min_P$ from every value and
% multiply the result with $\frac{max_{P_1}}{\max_P - \min_P}$
% </latex>

P1 =  imsubtract(P,13);
P1 = immultiply(P1, (255/(204-13)));
%%
% <latex>
% Note that this works only if $\max_P \not = \min_P$. We see, that the
% minimum and maximum intensity values are correct and that the picture was enhanced.
% </latex>

min_P1 = min(P1(:)), max_P1 = max(P1(:))
imshow(P1)
%%
% <latex>
% Using the method \texttt{imshow(P,[])} does the contrast stretching
% automatically. So we should see now the same picture as above.
% </latex>

imshow(P,[])