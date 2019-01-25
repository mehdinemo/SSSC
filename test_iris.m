clear all
close all
clc

X=iris_dataset';
X=X(1:100,:);
X = X./max(X);

N=size(X,1);

A = pdist(X);
% A = A/(max(max(A)));
A = 1-A;

for i=1:N
    A(i,i)=0;
end

AA=A;

A = AA>0.40;
D = diag(sum(A,1));
L = D-A;

[SM, SD] = SymmetricSparse(A);

x_0 = ones(size(SD,1),1);
x_0 = 0.5 * x_0;
x_0(51:100) = -x_0(51:100);
%%
[f_value, x] = SparseSpectralConjugate(SM, SD,x_0);

%%
% [s,u] = eig(L);


label_spect=spectral(A,3);
label_km=kmeans(X,3);


[idx,C] = kmeans(X,50);
% C=C./max(C);
B = pdist(C);
% B=B/max(max(B));
B=1-B;
% for i=1:size(B,1)
%     B(i,i)=0;
% end
label_B=spectral(B,3);
label_BS=kmeans(B,3);

label_fB=zeros(size(idx,1),1);
label_fBS=zeros(size(idx,1),1);
for i=1:size(label_B,1)
    label_fB(find(idx==i))=label_B(i);
    label_fBS(find(idx==i))=label_BS(i);
end
















