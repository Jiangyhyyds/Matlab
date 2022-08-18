function z = pso_func(in)
[m, n] = size(in);
x = in(:, 1);
y = in(:, 2);
z = zeros(m, 1);
for i = 1 : m
    z(i, :) = 0.4 * (x(i) - 2) .^ 2 + 0.3 * (y(i) - 4) .^ 2 - 0.7;
end
end