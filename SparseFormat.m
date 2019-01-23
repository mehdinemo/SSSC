function A = SparseFormat(W)

N = sum(sum(triu(W),1));
A = zeros(N,2);
for i=1:N
    A(i)
end

end