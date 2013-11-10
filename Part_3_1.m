%%
% <latex>
% In a first step, we load the image,convert it into a a grey level image
% and display it.
% </latex>

close all
clear all
P = imread('images/maccropped.jpg');
P = rgb2gray(P);
imshow(P);
%%
% <latex>
% We want to convolute the Sobel mask with the image, therefore the vertical matrix
% must have the following form: $$ V =  \begin{pmatrix} 1 & 0 &-1 \\ 2 & 0 & -2
% \\1 & 0 & -1 \end{pmatrix}$$ The horizontal Sobel filter is: $$ H = V^T
% $$ If a edge is not vertical nor horizontal, we can not detect it. We see
% this, if we at the edge which separates street and grass. To detect edges with an angle of 45${}^\circ$, the following matrices are suitable.
% $$D_- = \begin{pmatrix} 0 & 1 & 2 \\ -1 & 0 & 1 \\ -2 & -1 & 0\end{pmatrix} \ \text{and} \ D_+ =  \begin{pmatrix} -2 & -1 & 0 \\ -1 & 0 & 1 \\ 0 & 1 & 2 \end{pmatrix} $$
% The results of both filters are displayed below. 
% </latex>

vert = [1 0 -1 ;
        2 0 -2 ; 
        1 0 -1];
hori = vert';
%Apply convolution
Pv = conv2(double(P),double(vert),'same');
Ph = conv2(double(P),double(hori),'same');
imshow(uint8(Pv))
title('Vertical  Sobel')
figure;
imshow(uint8(Ph))
title('Horizontal Sobel')
%%
% <latex>
% Now we add and square the results \texttt{Pv} and \texttt{Ph}. In this
% case there are two main reasons to square the sum. Firstly squaring
% eliminates negative values. Secondly the difference between the values
% are amplified.
% </latex>

Ps = imadd(immultiply(Pv, Pv),immultiply(Ph, Ph));
Ps = sqrt(Ps);
%show result
close 1
imshow(uint8(Ps));
%% 
% <latex>
% Now we apply different thresholds. I chose the following thresholds: $$
% \tau \in \{32, 64, 128,180,200,245\} $$ If the threshold is chosen too low, we have to
% much information. If the threshold is chosen too high, important
% information and details are lost.
% </latex>

E32 = Ps > 32;
E64 = Ps > 64;
E128 = Ps > 128;
E180 = Ps > 180;
E200 = Ps > 200;
E245 = Ps > 245;
subplot(2,3,1)
imshow(E32);
title('\tau = 32')
subplot(2,3,2)
imshow(E64);
title('\tau = 64')
subplot(2,3,3)
imshow(E128);
title('\tau = 128')
subplot(2,3,4)
imshow(E180);
title('\tau = 180')
subplot(2,3,5)
imshow(E200);
title('\tau = 200')
subplot(2,3,6)
imshow(E245);
title('\tau = 245')
%% 
% <latex>
% The parameter $\sigma$ is the standard deviation of the Gaussian filter.
% As we have learned in class, this parameter decides how much influence
% the adjacent pixels have. In one of the previous experiments was shown,
% that a higher $ \sigma$ value leads to more noise cancellation, but small
% details can disappear and the images becomes more blurred. In this case
% the results are similar. If $\sigma$ is small we see a lot of edges and
% also noise, e.g. in the grass. If $\sigma$ is higher, we might have lost
% some edges, but more noise is reduced.
% </latex> 

subplot(2,3,1)
E1 = edge(P,'canny', [.04 .1], 1);
imshow(E1);
title('\sigma = 1');
subplot(2,3,2)
E2 = edge(P,'canny', [.04 .1], 2);
imshow(E2);
title('\sigma = 2');
subplot(2,3,3)
E2_5 = edge(P, 'canny', [.04 .1] , 2.5);
imshow(E2_5);
title('\sigma = 2.5');
subplot(2,3,4)
E3 = edge(P,'canny', [.04 .1], 3);
imshow(E3);
title('\sigma = 3');
subplot(2,3,5)
E4 = edge(P,'canny', [.04 .1], 4);
imshow(E4);
title('\sigma = 4');
subplot(2,3,6)
E5 = edge(P,'canny', [.04 .1], 5);
imshow(E5);
title('\sigma = 5');
%%
% <latex>
% The variable \texttt{tl} is the \emph{lower threshold}. The lower this
% threshold is, the more details can be seen in the result. So the minimum
% intensity change leading to a edge detection is controlled by \texttt{tl}.
% Therefore every white point in a picture with lower threshold \texttt{tl}
% is also white in every picture with a smaller lower threshold. This is
% shown in by calculating the differences and finding their minimum and
% maximum. There we also see see, that negative values for \texttt{lt}
% produce the same output as $ \mathtt{lt} = 0 $.
% </latex>

subplot(2,3,1)
E_tl1 = edge(P,'canny', [ -.5 .1], 2);
imshow(E_tl1);
title('tl = -0.5');
subplot(2,3,2)
E_tl2 = edge(P,'canny', [.0 .1], 2);
imshow(E_tl2);
title('tl = 0');
subplot(2,3,3)
E_tl3 = edge(P,'canny', [.03 .1], 2);
imshow(E_tl3);
title('tl = 0.03');
subplot(2,3,4)
E_tl4 = edge(P,'canny', [.05 .1], 2);
imshow(E_tl4);
title('tl = 0.05');
subplot(2,3,5)
E_tl5 = edge(P,'canny', [.07 .1], 2);
imshow(E_tl5);
title('tl = 0.07');
subplot(2,3,6)
E_tl6 = edge(P, 'canny', [.0999 .1] , 2);
imshow(E_tl6);
title('tl = 0.0999');

%Calculate differences
diff1 = E_tl1 - E_tl2;
diff2 = E_tl2 - E_tl3;
diff3 = E_tl3 - E_tl4;
diff4 = E_tl4 - E_tl5;
diff5 = E_tl5 - E_tl6;

%max(diffx(:)) = 1 means white point in x but not in x+1
%min(diffx(:)) = 0 means no black point in x, which is white in x+1,
%otherwise the minimum would be -1

max1 = max(diff1(:));min1 = min(diff1(:));
max2 = max(diff2(:));min2 = min(diff2(:));
max3 = max(diff3(:));min3 = min(diff3(:));
max4 = max(diff4(:));min4 = min(diff4(:));
max5 = max(diff5(:));min5 = min(diff5(:));

if E_tl1 == E_tl2
    disp('Negative lower thresholds produce the same output as lt = 0');
end
if [max2 max3 max4 max5 ] == ones(1,4)
    disp('If lt increases, white points (= noise or edge pixels) disapear');
end
if [min2 min3 min4 min5] == zeros(1,4)
    disp('If lt increases, no black point turns white -> number of detected points decreases');
end