function SM = SymmetricSparse(W)

ind = find(triu(W) ~= 0);
N = size(W,1);
[R, C] = ind2sub([N,N], ind);
SM = [R, C, W(ind)];

end