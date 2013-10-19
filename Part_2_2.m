%%
% <latex>
% We display the image intensity histogram with 10 and 256 bins using the
% following commands.
% </latex>

%Load P:
P = rgb2gray(imread('images/mrttrainbland.jpg'));
imhist(P,10);
figure
imhist(P,256);

%%
% <latex>
% We see that the histogram with 256 bins has a higher resolution. But the
% first gives also a good summary. In both figures, we see that there are
% more dark than bright pixels. We carry out the histogram equalization, with the following command.
% </latex>

P2 = histeq(P,255);
imshow(P2);
figure;
imhist(P2,256);
%%
% <latex>
% We see in the histogram and in the picture itself, that the number of
% bright pixels increased. So we obtain a brighter picture. If we run the
% equalisation again, nothing happens. To see that we subtract the two
% pictures $P_2$ and $P_3$ and test if the result equals $0$. If that is the case, the
% corresponding values of the pictures are equal and the value in the
% result \texttt{test} is 1. The matrix \texttt{test} is a logical matrix,
% that means that it only contains $1$ or $0$. So it the minimum of
% \texttt{test} is 1, we know that every value must be $1$. Therefore the
% pictures are equal.
% of P
% </latex>

P3 = histeq(P2,255);
imshow(P3);
figure;
imhist(P3,256);
test = (imsubtract(P2,P3) == 0);
min(test(:))