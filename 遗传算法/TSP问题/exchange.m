function [x, y] = exchange(x, y)
% 对调两个个体相应的基因片段
% x, y      要对调的基因片段
temp = x;
x = y;
y = temp;
end