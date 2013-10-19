close all
format short

% load and display

P = imread('images/maccropped.jpg');
P = rgb2gray(P);
imshow(P);

% Create 3x3 horizontal and vertical Sobel masks
% We are using convolution -> switch signs

vert = [1 0 -1 ;
        2 0 -2 ; 
        1 0 -1];
hori = vert';

%Apply convolution
Pv = conv2(double(P),double(vert),'same');
Ph = conv2(double(P),double(hori),'same');


figure;
imshow(uint8(Pv))
figure;
imshow(uint8(Ph))

%diagonal edges disappear e.g street, counter example: roof, but this
%consists of many small vertical and horizontal edges


% negative values are existing and important -> squaring & dufferences are
% emphasized


Ps = imadd(immultiply(Pv, Pv),immultiply(Ph, Ph));
Ps = sqrt(Ps);

%show result (not needed)
close 1
figure;
imshow(uint8(Ps));

%Thresholding the images

E32 = Ps > 32;
E64 = Ps > 64;
E128 = Ps > 128;
E180 = Ps > 180;
E200 = Ps > 200;
E245 = Ps > 245;

close all
figure;
subplot(2,3,1)
imshow(E32);

subplot(2,3,2)
imshow(E64);

subplot(2,3,3)
imshow(E128);

subplot(2,3,4)
imshow(E180);

subplot(2,3,5)
imshow(E200);

subplot(2,3,6)
imshow(E245);

% Too low -> too much information
% Too high -> details are lost


% Parte e)

figure;
subplot(2,3,1)
E1 = edge(P,'canny', [.04 .1], 1);
imshow(E1);

subplot(2,3,2)
E2 = edge(P,'canny', [.04 .1], 2);
imshow(E2);

subplot(2,3,3)
E3 = edge(P,'canny', [.04 .1], 3);
imshow(E3);

subplot(2,3,4)
E4 = edge(P,'canny', [.04 .1], 4);
imshow(E4);

subplot(2,3,5)
E5 = edge(P,'canny', [.04 .1], 5);
imshow(E5);

subplot(2,3,6)
E2_5 = edge(P, 'canny', [.04 .1] , 2.5);
imshow(E2_5);

close all

figure;
subplot(2,3,1)
E1 = edge(P,'canny', [ -.5 .1], 2);
imshow(E1);

subplot(2,3,2)
E2 = edge(P,'canny', [.0 .1], 2);
imshow(E2);

subplot(2,3,3)
E3 = edge(P,'canny', [.03 .1], 2);
imshow(E3);

subplot(2,3,4)
E4 = edge(P,'canny', [.05 .1], 2);
imshow(E4);

subplot(2,3,5)
E5 = edge(P,'canny', [.07 .1], 2);
imshow(E5);

subplot(2,3,6)
E2_5 = edge(P, 'canny', [.0999 .1] , 2);
imshow(E2_5);

% Gesucht sinnvolle erklärung
