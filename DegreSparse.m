function D = DegreSparse(SM)

N = max(max(SM(:,1:2)));
D = zeros(N,1);
for i=1:size(SM,1)
    D(SM(i,1)) = D(SM(i,1)) + SM(i,3);
    D(SM(i,2)) = D(SM(i,2)) + SM(i,3);
end

end