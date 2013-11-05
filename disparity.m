function [ disparity_map ] = disparity( PL,PR, n,m )
%DISPARITY Summary of this function goes here
%   Detailed explanation goes here

PL = double(rgb2gray(PL));
PR = double(rgb2gray(PR));

[nl,ml] = size(PL);
[nr,mr] = size(PR);

disparity_map = zeros(nl,ml);

%Every picture should have a nX m neighbourhood 1,1 -> 6,6 for n=m=11
PL = [zeros(nl,floor(n/2)), PL ,zeros(nl,floor(n/2))];
PL = [zeros(floor(m/2),ml+n-1);PL;zeros(floor(m/2),ml+n-1)];

% i = x (right)  , j = y  (down)  coordinate in PL
for i = 1:nl
    for j = 1:ml
        
% Extract a template comprising the 11x11 neighbourhood
        
        % 1 dimensional SSD matching
        % Correlation = Convolution with rot180(filter)
        
        %Extract neighbourhood
        template = PL(j+floor(n/2), i : i+n-1);
        
        %Calculate SSD matching 
        amax  = 2 * conv2(PR(j,:)',rot90(rot90(template)),'same') - conv2(PR(j,:)'.^2, ones(1,mr),'same');
        
        %Find maximum
        x_had = 0;        
        max = -Inf;
        for t = 1:mr 
            if max < amax(t)
                max = amax(t);
                x_had = t;
            end
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
          % 2 dimensional SSD 
%         neighbourhood= PL(j:j+10,i:i+10);       
%         argmax =  2 * conv2(PR,rot90(rot90(neighbourhood)),'same') - conv2(PR.^2,ones(nr,mr),'same');
%         
%         %Extraxt scanline
%         scanline = argmax(j,:);
%         
%         Find t, with scanline(t) is maximal
%         max = -Inf;
%         x_had = 0;
%         scanline
%         
%         for t = 1:mr 
%             if max < scanline(t)
%                 max = scanline(t);
%                 x_had = t;
%             end
%         end
%         
%         disp(x_had)
       




        %d = disparity;
        disparity_map(j,i) = i - x_had;
    
    end
end

end

