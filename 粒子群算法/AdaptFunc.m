function y = AdaptFunc(x)
y = (sin(sqrt(x(1)^2+x(2).^2)) - cos(sqrt(x(1).^2+x(2).^2)) + 1) ./ (1 + 0.1*x(1).^2 + 0.1*x(2).^2).^2 - 0.7;
end