%%
% <latex>
% We load the images and call the \texttt{disp\_map} method.
% </latex>
clear all
close all

PL = imread('images\corridorl.jpg');
PR = imread('images\corridorr.jpg');
PD = imread('images\corridor_disp.jpg');

disp_map = disp_map(PL,PR,11,11);
%%
% <latex>
% The result is visualized with the given command. The differences between
% my result and the given solution are small, it is basically the same
% picture. One problem is, that the maximum is not always unique. So
% changing the search direction from \texttt{15:-1:0} to \texttt{0:15}
% produces a different image.
% </latex>
figure
imshow(-disp_map,[-15 15]);
title('Is:');

figure; 
imshow(PD);
title('Should be:');

figure;
imshow(PL);