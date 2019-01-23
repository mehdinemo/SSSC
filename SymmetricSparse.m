function [SM, D] = SymmetricSparse(W)

ind = find(triu(W) ~= 0);
N = size(W,1);
[R, C] = ind2sub([N,N], ind);
SM = [R, C, W(ind)];

N = max(max(SM(:,1:2)));
D = zeros(N,1);
for i=1:size(SM,1)
    D(SM(i,1)) = D(SM(i,1)) + SM(i,3);
    D(SM(i,2)) = D(SM(i,2)) + SM(i,3);
end

end