function y = MyFunc(x1, x2)
y = (cos(x1.^2 + x2.^2) - 0.1) ./ (1 + 0.3*(x1.^2 + x2.^2).^2) + 3;
end