function len = calRoad(Dist, p)
% 计算个体距离函数
% Dist      城市间的距离矩阵
% p         要计算的个体
[N, ~] = size(Dist);
len = Dist(p(N), p(1));    % 首先计算起始点与终点间的距离
for i = 1 : N - 1
    len = len + Dist(p(i), p(i + 1));
end
end