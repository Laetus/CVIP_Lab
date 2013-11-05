close all
format short

%Reuse canny image with sigma = 1
P = imread('images/maccropped.jpg');
P = rgb2gray(P);
E = edge(P,'canny', [.04 .1], 1);

%Apply Radon transform

theta = 0:179; % default theta
[H,xp] = radon(E,theta);

%Display image
iptsetpref('ImshowAxesVisible','on')
imshow(H,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('x''')
colormap(hot), colorbar %eye candy
iptsetpref('ImshowAxesVisible','off')

% Find maximum
maximum = max(H(:));
%Find position of maximum
[num] = max(H(:));
[x, y] = ind2sub(size(H),find(H==num));


%Find angle and radius, note that the order is X (right) Y (up) an in
%matrices first up (row) and then right (column)
angle = theta(y);
radius = xp(x);

%d)
% the center of the picture is:

[x, y ]= size(E);
 y = y/2;
 x = x/2;
 
 
  
 [A,B] = pol2cart(angle*pi/180,radius);
  B = -B;
  
  %Shift origin
  A = A + x/2;
  B = B + y/2;
 
 % A = radius * cos(angle), B = radius * sin(angle)
 % x * radius * cos(angle) + y * radius * sin(angle) = 
 % radius * (x * cos(angle)  + y * sin(angle))
 
 % We know x * cos(theta) + y * sin(theta) = radius
 % -> A * x + B * y = radius * radius = radius^2
 
 % A = radius * cos(theta), B = -radius * sin(theta)
 % x * radius * cos(theta) + y *radius * sin(theta) = 
 % radius * (x * cos(theta)  + y * sin(theta))
 
 % We know x * cos(theta) + y * sin(theta) = radius
 % -> A * x + B * y = radius * radius = radius^2 = C
 
 
 
 xl = 0;
 yl = (radius^2 - (A * xl))/B;
 
 xr = 2*x;
 yr = (radius^2 - (A * xr))/B;
 
 imshow(E)
 
 l = [xl yl];
 r = [xr yr];

 line(l,r,'LineWidth',2,'Color',[1,0,0]);
 
 
