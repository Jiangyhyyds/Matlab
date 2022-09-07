function [] = JudgeAnalyse(Matrix)
% 判断输入矩阵的一致性
% 应用于层次分析法
% Matrix    输入N维矩阵
[N, M] = size(Matrix);
ri = [0, 0, 0.58, 0.90, 1.12, 1.24, 1.32, 1.41, 1.45];      %一致性指标
if N ~= M
    error("输入矩阵不是N维矩阵类型")
end
[vector, value] = eig(Matrix);  % 求输入矩阵的特征值和特征向量
lamda = max(diag(value));       % 最大特征值
max_index = find(diag(value) == lamda);     % 最大特征值对应的索引
max_vector = vector(:, max_index) / sum(max_index);     % 最大特征值对应的特征向量
cr = (lamda - N) / (N - 1) / ri(N);
if cr < 0.10
    disp(["cr = ", cr, "该矩阵通过一致性检验"]);
else
    disp(["cr = ", cr, "该矩阵没通过一致性检验"]);
end
end