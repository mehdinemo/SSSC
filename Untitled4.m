clear all
close all
clc

N = 6;
A = (rand(N,N)<0.2);
A = triu(A);
A = A+A';
for i=1:N
    A(i,i)=0;
end

G = graph(A);
h = plot(G);

D = diag(sum(A,1));
L = D-A;

