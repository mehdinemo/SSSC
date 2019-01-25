function  h = SparseMoltiply(SM, SD, x)

N = size(SD,1);
M = size(SM);
h = zeros(N,1);
for i=1:N
    h(i) = SD(i)*x(i);
    [r, c] = ind2sub(M, find(SM(:,1:2)==i));
    for j=1:length(r)
        if c(j)==1
            h(i) = h(i) - (SM(r(j),3)*x(SM(r(j),2)));
        end
        if c(j)==2
            h(i) = h(i) - (SM(r(j),3)*x(SM(r(j),1)));
        end
    end
end

end