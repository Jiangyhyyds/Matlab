function real = decode(pop,lb,ub)
[~,col] = size(pop);
for j = col:-1:1
    temp(j) = 2^(j-1)*pop(j);
end
temp = sum(temp);
real = round(lb + temp * (ub - lb)/(2^col-1));%解码
end
