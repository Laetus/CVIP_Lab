clear all
close all

PL = imread('images\corridorl.jpg');
PR = imread('images\corridorr.jpg');
PD = imread('images\corridor_disp.jpg');

disp_map = disp_map(PL,PR,11,11);

imshow(disp_map,[-15 15]);
title('Is:');

figure;
imshow(PD);
title('Should be:');