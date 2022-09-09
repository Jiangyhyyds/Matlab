function [dad,mom] = selection(pop,fitvalue)
PP = cumsum( fitvalue ./ sum(fitvalue) );       %计算累计概率
[row, ~] = size(pop);
%采用轮盘赌的方式选择父代
for i = 1:row
    for j = 1:row
        r = rand;
        if r <= PP(j)
            dad(i,:) = pop(j,:);
            break;
        end
    end
    mom(i,:) = pop(randi([1 row]),:);
end
end