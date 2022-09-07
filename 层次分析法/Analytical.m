% 层次分析法MATLAB代码
clear, clc;
%% 数据准备
JudgeMat = xlsread("Mat.xlsx", "Matrix", "A2 : F7");    % 读取准则层判断矩阵
load RI.mat;    % 一致性指标
analyse = zeros(3, 3, 6);   % 成分因素比较矩阵
analyse(:, :, 1) = xlsread("Mat.xlsx", "Matrix", "A12 : C14");  % 方案层对准则层因素B1的重要性比较矩阵
analyse(:, :, 2) = xlsread("Mat.xlsx", "Matrix", "A18 : C20");  % 方案层对准则层因素B1的重要性比较矩阵
analyse(:, :, 3) = xlsread("Mat.xlsx", "Matrix", "A24 : C26");  % 方案层对准则层因素B1的重要性比较矩阵
analyse(:, :, 4) = xlsread("Mat.xlsx", "Matrix", "H12 : J14");  % 方案层对准则层因素B1的重要性比较矩阵
analyse(:, :, 5) = xlsread("Mat.xlsx", "Matrix", "H18 : J20");  % 方案层对准则层因素B1的重要性比较矩阵
analyse(:, :, 6) = xlsread("Mat.xlsx", "Matrix", "H24 : J26");  % 方案层对准则层因素B1的重要性比较矩阵
%% 计算判断矩阵的特征向量和特征值
[Vector, Value] = eig(JudgeMat);
lamda = max(diag(Value));   % 寻找最大特征值
%% 计算判断矩阵最大特征值对应的W, CR，并进行一次性检验
N1 = length(JudgeMat);  % 判断矩阵的长度
max_index = find(diag(Value) == lamda);
max_vector = Vector(:, max_index) / sum(Vector(:, max_index));
CR = (lamda - N1) / (N1 - 1) / RI(N1);
if CR < 0.10
    disp("准则层判断矩阵的一致性可以接受");
end
%% 计算准则矩阵的最大特征值并做一致性检验
Cr = zeros(size(analyse, 3), 1);
N2 = length(analyse(:, :, 1));          % 准则判断矩阵的长度;
W = zeros(N2, size(analyse, 3));        % 每个判断矩阵的特征向量
for i = 1 : N1
    [vector, value] = eig(analyse(:, :, i));    % 计算特征向量以及特征值
    alpha = max(diag(value));           % 寻找最大特征值
    maxIndex = find(diag(value) == alpha);
    W(:, i) = vector(:, maxIndex) / sum(vector(:, maxIndex));
    Cr(i) = (alpha - N2) / (N2 - 1) / RI(N2);
    if Cr(i) < 0.10
        disp(["方案层对准则层因素B", num2str(i), "的重要性比较矩阵的一致性可以接受"]);
    end
end
Cr
%% 计算总结果并给出对应方案层的选择
result = W * max_vector     % 综合所有权值后给出的最终权重，越大代表着选择的可能性越大
cr = Cr' * max_vector       % 对最终的结果再做一次一致性检验，排除不同因素综合起来又产生的影响