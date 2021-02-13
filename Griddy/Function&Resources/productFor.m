function [z_out] = productFor(x,y,z)
[x_r,x_c] = size(x);
[y_r,y_c] = size(y);
[z_r,z_c] = size(z);
if ismatrix(x) && ismatrix(y) && x_c == y_r && z_r == x_r && z_c && y_c
    for i = 1:y_c
        for j = 1:y_r
            for m = 1:x_c
                z(j,i) = x(j,m) * y(m,i) + z(j,i);
            end
        end
    end
    z_out = z;
else
    z_out = 'FAILED';
end
end

