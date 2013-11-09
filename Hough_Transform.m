%a)
close all
clear all
format short

P = imread('images/maccropped.jpg');
P = rgb2gray(P);
iptsetpref('ImshowAxesVisible','on')
E = edge(P,'canny', [.04 .1], 1);
imshow(E);

%Test
%line( [0 358],[260 183],'LineWidth',2,'Color',[1,0,0]);

%b)
angles = 0:179;

[H,xp] = radon(E',angles);
figure;
imshow(H,[],'Xdata', angles, 'YData',xp,'InitialMagnification','fit');
xlabel('\theta (degrees)');
ylabel('x''');
colormap(hot),colorbar;

%c) 
%Find position of maximum
[num] = max(H(:));
[xmax, ymax] = ind2sub(size(H),find(H==num));

%Get line parameters theta and radius with strongest edge support
theta = angles(ymax);
radius = xp(xmax);

%d)
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;

[sizey , sizex] = size(E);

%compute center, as shown in help radon
center = floor(([sizex sizey] +1 )/2);

xl = - floor((sizex +1) / 2) +1;
xr = - xl +1;

C = radius^2;
yl = (C - (A*xl))/B;
yr = (C - (A*xr))/B;

%Shift origin to upper left corner
xshift = [xl, xr] + center(1);
yshift = [yr, yl] + center(2);

figure;
imshow(P);
line([xl xr], [yl yr],'LineWidth',2,'Color',[0,1,0]);
line(xshift,yshift ,'LineWidth',2,'Color',[0,1,1]);
%line([xltest xrtest], [yltest yrtest],'LineWidth',2,'Color',[0,0,1]);