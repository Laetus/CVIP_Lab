close all
format short

%Reuse canny image with sigma = 1
P = imread('images/maccropped.jpg');
P = rgb2gray(P);
E1 = edge(P,'canny', [.04 .1], 1);

