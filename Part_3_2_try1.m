close all
format short

%Reuse canny image with sigma = 1
P = imread('images/maccropped.jpg');
P = rgb2gray(P);
E = edge(P,'canny', [.04 .1], 1);


% Radon Transformation ist ein Spezialfall der Hough Transf. zählt für eine
% Linie gamma, die Winkel alpha und Abstand r hat, wieviele Punkte auf
% dieser Linie liegen, Radon betrachtet nur gegebene Winkel (0:179),
% während bei der houghs Transf. der Winkel \in R ist


%Apply Radon Transf.
[H, xp] = radon(E);
theta = 0:179; %default value
iptsetpref('ImshowAxesVisible','on')
imshow(H,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit');
    xlabel('\theta (degrees)')
ylabel('x''')
colormap(hot), colorbar
iptsetpref('ImshowAxesVisible','off')

%Find positions of maximum values
[num] = max(H(:));
[x y] = ind2sub(size(H),find(H==num));

%radius is centered in the middle of the image
[s t ] = size(H);

theta = y;
radius = ((s-1)/2) - x;

% normal line equation
[A, B] = pol2cart(theta*pi/180, radius);
B = -B; %y Axis

[a b] = size(E);
middle = [a/2 b/2];
%Center of the system is in the middle of the picture (a/2 , b/2)



% Shifting the center of the coordinate system from the middle to the upper left corner 
A1 = A + a/2;
B1 = B + b/2;

% Calculating the polar coordinates of A1 and B1
[theta1 radius1] = cart2pol(A1,B1);

% x * cos(theta) + y * sin(theta) = radius

%Calculate 2 points : (0,y0) and (x0,0)

costhet = sin(theta1);
sinthet = cos(theta1);

if (costhet * sinthet == 0) 
   error( 'Theta is multiple of pi or pi/2');
end

y0 = radius1 / sinthet;
x0 = radius1 / costhet;

figure;
imshow(E);
hold on
line([x0,0],[0 y0],'LineWidth',2,'Color',[1,0,0]);





