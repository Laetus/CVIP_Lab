function [ H ] = getH( sigma )
H = zeros(5);
for x = -2:2
    for y = -2:2
        H(x+3,y+3) = exp(-(x^2 + y^2) / (2 * sigma^2) ) / (2 * pi * sigma^2);
    end
end
end

