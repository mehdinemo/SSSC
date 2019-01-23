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
% N = 8;
% A = (rand(N,N)<0.4);
% A = triu(A);
% A = A+A';
% for i=1:N
%     A(i,i)=0;
% end

G = graph(A);
h = plot(G);

D = diag(sum(A,1));
L = D-A;

%%
x = [3;2;1;-1;-2;-3];

[SM, SD] = SymmetricSparse(A);
% SL = SparseLaplacian(SM);
% x = sym('x',[1,size(L,1)]);