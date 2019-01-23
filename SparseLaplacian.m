function SL = SparseLaplacian(SM)

N = max(max(SM(:,1:2)));
D = zeros(N,1);
for i=1:size(SM,1)
    D(SM(i,1)) = D(SM(i,1)) + SM(i,3);
    D(SM(i,2)) = D(SM(i,2)) + SM(i,3);
end

SL = zeros(N,3);
for i=1:N
    SL(i,:) = [i, i, D(i)];
end

SL = [SL; SM(:,1:2),-SM(:,3)];
% SL = [SL; SM(:,2), SM(:,1),-SM(:,3)];

end