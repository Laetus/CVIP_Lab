%%
% <latex>
% As we don't have to compute a additional matrix, the first step is to
% load the picture again. To opitimize the result, we use a contrast
% stretching again.
% </latex>

P = imread('images/ntugn.jpg');
imshow(P,[]);


%%
% <latex>
% Now we apply the already implemented median filter with the
% \texttt{medfilt2} method.
% </latex>

P3 = medfilt2(P); % as 3x3 is default
P5 = medfilt2(P, [5 5]);

imshow(P3,[]);
figure;
imshow(P5,[]);

%%
% <latex>
% We seem that the result get worse, if neighbourhood size increases. In
% contrast to that, we see that in the ntusp picture the noise gets
% cancelled completely.
% </latex>

Q = imread('images/ntusp.jpg');
imshow(Q,[]);
figure;

Q3 = medfilt2(Q); % as 3x3 is default
Q5 = medfilt2(Q, [5 5]);

imshow(Q3,[]);
figure;
imshow(Q5,[]);

%% 
% <latex>
% If the
% neighbourhood is too big, we lose again some details. So in this case,
% the $3\times3$ filter has the best result. This is because the noise
% points are always single pixels.
% </latex>
