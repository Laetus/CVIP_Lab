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
% The result is visualized with the given command. It took about 19 seconds
% to calculate the disparity map. On a 4 year old dual core CPU. So a state
% of the art processor can do the task a little but quicker.
% </latex>

imshow(-disp_map,[-15 15]);
title('Solution:');

figure; 
imshow(PD);
title('Should be:');

figure;
imshow(PL);

%%
% <latex>
% We see that the solution shows basically the same image. The small
% differences are caused by the implementation. The maximum of the SSD must
% not be unique. So the design of the argmax function can influence the
% result. We see this clearly in the area associated with area in the back
% of the corridor. We have a huge area, where all values are equal. So it
% the SSD values are equal and the design of the argmax function has a huge
% impact on the result. To show this, I copied the funtion
% \texttt{disp\_map} to \texttt{disparity} and changed the search direction
% in line 116 from \texttt{15:-1:0} to \texttt{0:15} and the result is in
% this case better than the previous one.
% </latex>

disp_map2 = disparity(PL,PR,11,11);
imshow(-disp_map2,[-15,15]);
title('Solution 2');