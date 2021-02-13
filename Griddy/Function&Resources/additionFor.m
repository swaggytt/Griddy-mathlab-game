function [y_out] = additionFor(x,y)
[x_r,x_c] = size(x);
[y_r,y_c] = size(y);
if ismatrix(x) && ismatrix(y) && x_r == y_r && x_c == y_c
    for i = 1:x_r
        for j = 1:x_c
            y(i,j) = x(i,j) + y(i,j);
        end
    end
    y_out = y;
else
    y_out = 'FAILED';
end
end

