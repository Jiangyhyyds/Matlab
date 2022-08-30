function y = MyFunc(x)
y = abs(x .* sin(x) .* cos(2 * x) - 2 * x .* sin(3 * x) +3 * x .* sin(4 * x));
end