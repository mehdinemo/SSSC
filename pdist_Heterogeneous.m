function d = pdist_Heterogeneous(X,Y)

d = 0;
for i = [1,3,4,5]
    if X(i) ~= Y(i)
        d = d+1;
    end
end
d = d / 4;
% d = sqrt(d^2 + (X(2)-Y(2))^2);
d = pdist([d; X(2)-Y(2)],'spearman');