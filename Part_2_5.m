%% 
% <latex>
% In this exercise we use Fourier transformations to get rid of more
% complex noise patterns. In this case, diagonal waves.
% </latex>

P = imread('images/pckint.jpg');
imshow(P);
%% 
% <latex>
% Now we apply a Fourier Transformation, to see the picture in the frequency
% domain. This transformation is very popular, so it is already implemented
% in \texttt{MATLAB}.
% </latex>

F = fft2(P);
% F has complex values
whos F
S = abs(F);
% S has now real positive values
whos S
% Display shifted and transformed image
imagesc(fftshift(S.^0.1));
colormap('default')
%% 
% <latex>
% Now we display the power spectrum without \texttt{fftshift} method. Then
% the peaks are at the edges of the picture.help 
% </latex>

imagesc(S.^0.1);
colormap('default')
% coord  = [up right; down left corner];
coord =    [ 17, 249;
            241, 9];
%% 
% <latex>
% Now we set the area around the specified peaks to zero. This is done
% "manually" to avoid a lot of error handling code.
% </latex>

F1 = F;
a = 2;
F1(17-a:17+a,249-a:249+a) = zeros(2*a + 1);
F1(241-a:241+a, 9-a:9+a) = zeros(2*a + 1);
S1 = abs(F1);
% Display shifted image
imagesc(fftshift(S1.^0.1));
colormap('default')
%% 
% <latex>
% Now we transform $F_1$ back. To obtain the best result, we do here
% contrast stretching again.
% </latex>

P1 = ifft2(F1);
imshow(P,[])
title('Before')
figure;
imshow(P1,[])
title('After')
%%
% <latex>
% This result is better, but if we look at the not shifted power spectrum,
% we see, that the rows and columns in which the peaks are, are bigger,
% than their neighbours. So in an additional step we set them also to zero.
% </latex>

F2 = F1;
% Get dimensions of the picture
[h w] = size(F1);
% sete rows and columns to zero
F2(:,9) = zeros(h,1);
F2(:,249) = zeros(h,1);
F2(17,:) = zeros(1,w);
F2(241,:) = zeros(1,w);
%Print power spectrum
imagesc(abs(F2).^.1);
colormap('default')
%Print Pictures
figure;
subplot(1,2,1)
imshow(P,[])
title('Before')
subplot(1,2,2)
imshow(P1,[])
title('After')
figure;
imshow(ifft2(F2),[])
title('After additional step')