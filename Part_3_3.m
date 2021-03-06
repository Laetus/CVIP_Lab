%%
% <latex>
% We load the images and call the \texttt{disp\_map} method. The
% \texttt{tic, ..., toc,} command can be used to find out, how long the
% statement between takes. 
% </latex>
clear all
close all

PL = imread('images\corridorl.jpg');
PR = imread('images\corridorr.jpg');
PD = imread('images\corridor_disp.jpg');

tic,
disp_map = disp_map(PL,PR,11,11); toc,
%%
% <latex>
% The result is visualized with the given commands. 
% </latex>

imshow(-disp_map,[-15 15]);
title('Solution 1:');

figure; 
imshow(PD);
title('Should be:');

figure;
imshow(PL);
%%
% <latex>
% The differences between my result and the given solution are small, it is basically the same
% picture. One problem is, that the maximum is in general not unique. So
% changing the search direction from \texttt{15:-1:0} to \texttt{0:15}
% produces a different image. The function \texttt{disparity} is an exact copy of \texttt{disp\_map} but the search direction in line 116 is changed to  \texttt{ for t = 0:15}. The result is similar but not the same.
% </latex>
tic,
disp_map2 = disparity(PL,PR,11,11);
toc,
figure
imshow(-disp_map,[-15 15]);
title('Solution 2:');

%%
% <latex>
% This task has also high computational costs. This disparity function takes up to $30$ seconds on a 4 year old dual-core computer, but also a modern processor will need more than $10$ seconds to finish this task. Why can can Playstation and Xbox solve this task in real time games? The expensive part is finding the corresponding pixel. The controllers of the actual generation of Playstations are wireless, so they emit several rays to transport information to the device. I think it could be infrared. If the 2 cameras are able to record this infrared signal, we can easily find the corresponding point. If the game is controlled without a controller only by hand, we can apply image recognition as preprocessing to reduce the image size.  
% </latex>
