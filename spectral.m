function Label = spectral(A,k)

% error

D = diag(sum(A,1));
L = D - A;

[s,u] = eig(L);
X = s(:,1:k);
Label = kmeans(X,k);
end