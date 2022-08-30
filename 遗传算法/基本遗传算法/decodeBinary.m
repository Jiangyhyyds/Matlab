function dec = decodeBinary(pop)
% 二进制转化为十进制数
% pop   初始种群二进制编码矩阵
[row, col] = size(pop);     % 求矩阵的行和列
Weight = zeros(row, col);   % 二进制转十进制的权值矩阵
for i = 1 : col
    Weight(:, i) = pop(:, i) .* 2 .^ (col - i);
end
dec = sum(Weight, 2);       % 二进制转换后的十进制数
% 求Weight的每行之和，即为转化后的十进制数
end