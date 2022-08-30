function decVar = decodeChrom(pop, spoint, length)
% 将染色体（二进制编码）转化为十进制数（可编码多个变量）
% pop       初始种群矩阵
% spoint    待解码变量的二进制串起始位置
% length    每个变量的长度
binaryVar = pop(:, spoint : spoint + length - 1);
decVar = decodeBinary(binaryVar);
end