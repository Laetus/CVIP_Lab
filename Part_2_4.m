%%
% <latex>
% The first step is to load the picture. To optimize the result, I used also contrast
% stretching.
% </latex>

P = imread('images/ntugn.jpg');
imshow(P,[]);
%%
% <latex>
% Now we apply the already implemented median filter with the
% \texttt{medfilt2} method and two neighbourhood sizes.
% </latex>

P3 = medfilt2(P); % as 3x3 is default
P5 = medfilt2(P, [5 5]);
imshow(P3,[]);
figure;
imshow(P5,[]);
%%
% <latex>
% We see that the result gets worse, if neighbourhood size increases. Now we apply median filtering to 'ntusp,jpg'.
% </latex>

Q = imread('images/ntusp.jpg');
imshow(Q,[]);
figure;
% Apply filters
Q3 = medfilt2(Q); % as 3x3 is default
Q5 = medfilt2(Q, [5 5]);
imshow(Q3,[]);
figure;
imshow(Q5,[]);
%% 
% <latex>
% If the neighbourhood is too big, we lose again some details. So in this case,
% the $3\times3$ filter has the best result. This is because the noise
% points are always single pixels. Therefore it is possible to cancel them with the smaller filter.
% </latex>