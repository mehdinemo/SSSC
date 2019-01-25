function A = pdist(X)

N = size(X,1);

A = zeros(N,N);
for i=1:N
    for j=i+1:N
        A(i,j) = sqrt(sum((X(i,:) - X(j,:)).^2));
        A(j,i) = A(i,j);
    end
end

end
