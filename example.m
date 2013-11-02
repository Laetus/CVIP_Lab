%%
% <latex>
% The eigenvalues of a circulant matrix can be
% obtained by performing FFT on the first column
% of the matrix. First, let us construct a
% $5\times5$ circulant matrix \verb|C| whose first
% column \verb|c| is generated with random input:
% </latex>

c = rand(5,1);
% sad that Matlab does not provide a circulant()
% command...
C = toeplitz(c, c([1 end:-1:2]))

%%
% <latex>
% The eigenvalues of \verb|C| are nothing but
% </latex>

lambda = fft(c)

%%
% <latex>
% Check it out! The output is the same as using
% the \verb|eig| command:
% </latex>

eig(C)

%%
% Fun, isn't it?