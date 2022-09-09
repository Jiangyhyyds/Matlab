function fval = objfun(x,n1,G)
N=20+size(x,2);
shortest =zeros(1,N);
best = zeros(n1,1);
for i = 1:n1            %外层循环所有路口
    for j=[1:20,x]      %内层循环设有交巡警服务平台的路口
        %计算从第 i 个路口到第 i 个设有交巡警服务平台的路口最短路径对应的路程
        d = G(i, j);
        k=find(j==[1:20,x]);
        shortest(i,k) = d;
    end
    [min_shortest(i),index] = min(shortest(i,:));       %找出最小值
    best(i) = index;    %第 i 个路口的所属交巡警服务平台
end
%计算每个服务平台管辖的路口（包括服务平台所在的路口）
guishu = zeros(10,N);
for i=1:N
index_b = find(best==i);%寻找第 i 个服务平台管辖的路口
k = size(index_b,1);
guishu(1:k,i) = index_b;
end
global w;
countzeros=zeros(1,N);
for i=1:N
countzeros(i)=length(find(guishu(:,i)>0));
end
delta(1)=cov(countzeros);
delta(2)=max(min_shortest)/10;
fval =sum(w.*delta);