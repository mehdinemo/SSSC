clear all
close all
clc


% A = [0 1 1 0 0 0;
%      1 0 1 0 0 0;
%      1 1 0 1 0 0;
%      0 0 1 0 1 1;
%      0 0 0 1 0 1;
%      0 0 0 1 1 0];

A = [0 1 0 1 1 0;
     1 0 0 0 1 0;
     0 0 0 1 0 1;
     1 0 1 0 0 1;
     1 1 0 0 0 0;
     0 0 1 1 0 0];
% N = 500;
% A = (rand(N,N)<0.2);
% A = triu(A);
% A = A+A';
% for i=1:N
%     A(i,i)=0;
% end

% G = graph(A);
% h = plot(G);

D = diag(sum(A,1));
L = D-A;

[SM, SD] = SymmetricSparse(A);

%%
tic
[f_value, x] = SparseSpectralConjugate(SM, SD);
toc
%%
tic
[s,u]=eig(L);
toc
%%
if mod(N,2)==0
    x = [N/2:-1:1,-1:-1:-N/2]';
else
    x = [fix(N/2):-1:0,-1:-1:fix(-N/2)]';
end

tic
h = SparseMoltiply(SM, SD, x);
toc

tic
H = L*x;
toc
% SL = SparseLaplacian(SM);
% x = sym('x',[1,size(L,1)]);