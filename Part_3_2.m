%%
% <latex>
% We load the picture and apply the Canny algorithm.
% </latex>

close all
clear all
format short
P = imread('images/maccropped.jpg');
P = rgb2gray(P);
E = edge(P,'canny', [.04 .1], 1);
%%
% <latex>
% The Hough transform maps every point $(x,y)$ to a sinusoidal curve in the feature space. We know from the tutorial, that the intersection between two sinusoidals in the feature space represents the line between the points in the original space. The image has only two intensities $0,1$. If we map the image into the feature space, every point with intensity $1$ is represented by its sinusoidal weighted with the intensity 1. Every point with intensity $0$ disappears. The value of a point in the feature space indicates how many sinusoidals intersect in this point. Therefore we know, how many edgels are located on the corresponding line in the original space.\\ \\ 
% The Radon transform is slightly different. Here the angles $( \theta_1 ,
% \dots , \theta_N )$  and radii $ (r_1 , \dots , r_M)$  are given. Every
% combination of these parameters defines an unique line $l(\theta, r)$.
% The function value $R(\theta_i , r_j)$ is given as the line integral over
% the image intensity I(t). $$\int_{l(\theta_i,r_j)}  I(t) \ \mathrm{d}t $$
% As we are in the discrete domain, $R(\theta_i , r_j)$ is simply the sum of the image intensities for every pixel which is located on line $l(\theta_i , r_j)$. In our case the intensities are $0$ and $1$ and represent "not edgel" and "edgel". We use a lot of angles and radii to get a lot of lines. Therefore $R(\theta_i , r_j)$ is simply the number of edgels on line $l(\theta_i , r_j)$. But that is exactly, what Hough transform produced. Note that, the origin of is in the center of the image and not in the upper left corner.\\ \\
% The command is slightly modified, but we obtain the same result.
% \texttt{angles = 0:179} is the default value, if no angles are specified.
% To visualize the result better, we apply a colormap and plot the axis.
% </latex>

angles = 0:179;
[H,xp] = radon(E,angles);
iptsetpref('ImshowAxesVisible','on');
imshow(H,[],'Xdata', angles, 'YData',xp,'InitialMagnification','fit');
xlabel('\theta (degrees)');
ylabel('x''');
title('Radon transform');
colormap(hot),colorbar;
iptsetpref('ImshowAxesVisible','off');
%%
% <latex>
% Now we have to find the position of the maximum value. This point is
% associated with the line which has most edgels on it. Therefore it is
% probably an edge. 
% </latex>

[num] = max(H(:));
[xmax, ymax] = ind2sub(size(H),find(H==num));
%Get line parameters theta and radius with strongest edge support
theta = angles(ymax);
radius = xp(xmax);
%%
% <latex> 
% If we convert a complex number $c$ in radial representation $ c = r e^{i \varphi}$, where $r$ is the radius and $\varphi = \frac{\theta \pi}{180}$ the angle in radial representation, into Cartesian representation $c = A + Bi$, $A$ and $B$ have the form
% \begin{align*}
% A = r \cos (\varphi) \\
% B = r \sin (\varphi)
% \end{align*}
% From the tutorial we know, that $\cos (\varphi) + \sin (\varphi) = r$. Now we can think about $C$:
% \begin{align*}
% Ax + By = C\\
% r \cos (\varphi) x + r \sin (\varphi) y = C \\
% r ( \underbrace{\cos (\varphi) x + \sin (\varphi) y }_{ = \ r \ \text{shown in tutorial} } ) = C \\
% r^2 = C
% \end{align*}
% </latex>

[A, B] = pol2cart(theta*pi/180, radius);
B = -B;
C = radius^2;
%%
% <latex>
% $y$ can be expressed as:
% $$ y = \frac{C - Ax}{B} $$
% As Radon transform shifted the the origin to the center, we calculate the line in this coordinates and shift the origin to the upper left corner afterwards.
% </latex>

%compute center, as shown in help radon
[sizey , sizex] = size(E);
center = floor(([sizex sizey] +1 )/2);

xl = - floor((sizex +1) / 2) ;
xr = - xl -1;
yl = (C - (A*xl))/B;
yr = (C - (A*xr))/B;

%Shift origin to upper left corner
xshifted = [xl, xr] + center(1)
yshifted = [yl, yr] + center(2)

%Display image and line
imshow(P);
hold on
line(xshifted,yshifted ,'LineWidth',2,'Color',[1,0,0]);
%Display the edge image and line
figure;
imshow(E);
hold on
line(xshifted,yshifted ,'LineWidth',2,'Color',[1,0,0]);
%%
% <latex>
% We see that the line is not the edge of the running path. The reason is,
% that the edge image contains a lot of noise, especially in the grass
% area. So we have to reduce the noise. In the previous task was shown,
% that a higher $\sigma$ reduces this noise. If we change only this
% parameter, we get the following result.
% </latex>

E3 = edge(P,'canny', [.04 .1], 3);
[H,xp] = radon(E3,angles);

[num] = max(H(:));
[xmax, ymax] = ind2sub(size(H),find(H==num));
%Get line parameters theta and radius with strongest edge support
theta = angles(ymax);
radius = xp(xmax);

[A, B] = pol2cart(theta*pi/180, radius);
B = -B;
C = radius^2;
%compute center, as shown in help radon
[sizey , sizex] = size(E);
center = floor(([sizex sizey] +1 )/2);

xl = - floor((sizex +1) / 2) ;
xr = - xl -1;
yl = (C - (A*xl))/B;
yr = (C - (A*xr))/B;

%Shift origin to upper left corner
xshifted = [xl, xr] + center(1);
yshifted = [yl, yr] + center(2);

%Display image and line
imshow(P);
hold on
line(xshifted,yshifted ,'LineWidth',2,'Color',[1,0,0]);
figure;
imshow(E3);
hold on
line(xshifted,yshifted ,'LineWidth',2,'Color',[1,0,0]);