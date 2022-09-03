function [] = plot_route(pos, R)
% 连点画图函数
% pos   城市坐标
% R     随即生成的路径
scatter(pos(:, 1), pos(:, 2), "rx");
hold on;
plot([pos(R(1), 1), pos(R(end), 1)], [pos(R(1), 2), pos(R(end), 2)]);
% 画起点和终点相接的一条路径
hold on;
for i = 2 : length(R)
    x0 = pos(R(i - 1), 1);
    y0 = pos(R(i - 1), 2);
    x1 = pos(R(i), 1);
    y1 = pos(R(i), 2);
    plot([x0, x1], [y0, y1]);
    hold on;
end
end