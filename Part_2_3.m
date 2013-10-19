%%
% <latex>
% We use the function \texttt{getH(sigma)} 
% to compute the matrices. The source code after this part.
% for $\sigma_1 = 1$ and $\sigma_2 = 2$.
% </latex>

H1 = getH(1)
H2 = getH(2)
%Normalisation
%Calculate sums
s1 = sum(H1(:))
s2 = sum(H2(:))
%Multiply with the inverse
H1 = 1/s1 * H1;
H2 = 1/s2 * H2;
%Control
s1 = sum(H1(:))
s2 = sum(H2(:))
% Visualisation with mesh
x = -2:2;
[X,Y] = meshgrid(x,x); %create grid
mesh(X,Y,H1);
figure;
mesh(X,Y,H2);
%%
% <latex>
% We see, that both matrices are invariant under $90^{\circ}$ rotations,
% reflection and transposing. In $H_1$, the center has a higher value
% compared to the other points. \\ \\ Now we import the Picture ntugn.jpg
% from our image folder and view it. To get a better result, we also do a
% contrast stretching.
% </latex>

P = imread('images/ntugn.jpg');
imshow(P,[]);
%%
% <latex>
% We see that there is a lot of noise. For example in the sky should
% adjacent neighbours have a similar value. This is not the case here. So
% we apply our Gaussian filters with zero padding.
% </latex>

P1 = conv2(double(P),double(H1),'same');
P2 = conv2(double(P),double(H2),'same');
% Get back to uint8
P1 = uint8(P1);
P2 = uint8(P2);
% Show results, also with contrast stretching
imshow(P1,[]);
figure;
imshow(P2,[]);
%%
% <latex>
% We obtained two pictures with less noise. If $\sigma$ is higher more
% noise is cancelled, but the image is also more blurred. Now we apply the
% same filters to the picture ntu-sp. 
% </latex>

Q = imread('images/ntusp.jpg');
imshow(Q,[]);
%%
% <latex>
% We see, that the noise is different. In this setting the noise is very
% bright. Now we apply our filters
% </latex>

Q1 = conv2(double(Q),double(H1),'same');
Q2 = conv2(double(Q),double(H2),'same');
% Get back to uint8
Q1 = uint8(Q1);
Q2 = uint8(Q2);
% Show results, also with contrast stretching
imshow(Q1,[]);
figure;
imshow(Q2,[]);
%%
% <latex>
% In this case, Gaussian filtering is not the best choice. In the first
% picture the noise value was close to the adjacent pixel values. In this case Gaussian filtering can not work so well, as the
% noise value is generally far away from the values of the adjacent pixels.
% So we see, that the brightness of the noise pixels decrease, but the
% spots get larger, as the noise also affects the adjacent pixels more. In this
% case, median filtering might be better.
% </latex>