function [X,Y,Z] = ackley2D(x,y,n)

x1 = linspace(x(1),x(2),n);
x2 = linspace(y(1),y(2),n);

l1 = length(x1);
l2 = length(x2);
[X,Y] = meshgrid(x1, x2);
Z = 0*X;
for l = 1:l1
    for k = 1:l2
        Z(k,l) = -20 * exp(-.2*sqrt(sum(x1(l).^2+x2(k)^2)/2)) - ...
            exp(sum(cos(2*pi*[x1(l),x2(k)]))/2) + 20 + exp(1);
    end
end
