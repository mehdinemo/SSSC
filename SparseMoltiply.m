function  h = SparseMoltiply(SM, SD, x)

N = size(SD,1);
M = size(SM);
h = zeros(N,1);
for i=1:N
    h(i) = SD(i)*x(i);
    [r, c] = ind2sub(M, find(SM(:,1:2)==i));
    for j=1:length(r)
        h(i) = h(i)+SL(r(j),)
    end
end

end