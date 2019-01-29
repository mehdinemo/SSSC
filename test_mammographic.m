clear all
close all
clc

W = importdata('B:\Research\mammographic_masses.txt');
W(:,1:end-1) = (W(:,1:end-1) - min(W(:,1:end-1))) ./ ...
               (max(W(:,1:end-1)) - min(W(:,1:end-1)));

N = size(W,1);
Labels = W(:,end);
A = zeros(N,N);

for i=1:N
    for j=i+1:N
        A(i,j)=pdist_mine(W(i,1:end-1),W(j,1:end-1));
        A(j,i)=A(i,j);
    end
end

A = A./max(max(A));
A = 1 - A;

for i=1:N
    A(i,i)=0;
end

%%
% AA = A>0.7;
D = diag(sum(A,1));
L = D-A;
% 
% G = graph(AA);
% plot(G)

[s,u] = eig(double(L));
labels = s(:,2)<mean(s(:,2));

[f_value, x] = Spectral_Conjugate(L);
labels = s(:,2)<mean(x);
k=2;
labels=kmeans(x,k);

%%
tp=0;
tn=0;
fp=0;
fn=0;
pre=0;
recal=0;

for i=1:N
    if Labels(i)==1
        if labels(i)==1
            tp=tp+1;
        else
            fn=fn+1;
        end
    else
        if labels(i)==0
            tn=tn+1;
        else
            fp=fp+1;
        end
    end
end

pre=tp/(tp+fp)
recal=tp/(tp+fn)













