clear all
close all
clc

W = importdata('B:\Research\mammographic_masses.txt');
W(:,1:end-1) = (W(:,1:end-1) - min(W(:,1:end-1))) ./ ...
               (max(W(:,1:end-1)) - min(W(:,1:end-1)));
% W(:,2) = (W(:,2) - min(W(:,2))) ./ ...
%                (max(W(:,2)) - min(W(:,2)));

N = size(W,1);
Labels = W(:,end);
A = zeros(N,N);

% for i=1:N
%     for j=i+1:N
%         A(i,j)=pdist_Heterogeneous(W(i,1:end-1),W(j,1:end-1));
%         A(j,i)=A(i,j);
%     end
% end
%%
A = squareform(pdist(W(:,[1,3,4,5]),'spearman'));

A = A./max(max(A));
A = 1 - A;

for i=1:N
    A(i,i)=0;
end

D = diag(sum(A,1));
L = D-A;

[s,u]=eig(L);
% labels = kmeans(s(:,2),2);
labels = s(:,2) < mean(s(:,2));
%%
ind=find(Labels==1);
Labels(ind)=2;
ind=find(Labels==0);
Labels(ind)=1;
ind=find(Labels==2);
Labels(ind)=0;


%%
format short

fid = fopen('Results.txt', 'w');

for j=1:1000

% rand_x = evaluation_stx(Labels, 0.001);
    
[f_value, x, k] = Spectral_Conjugate(L);

labels = x < mean(x);

tp=0;
tn=0;
fp=0;
fn=0;

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

pre=tp/(tp+fp);
recal=tp/(tp+fn);

fprintf(fid,'f=%d,k=%d,p=%d,r=%d%',f_value,k,pre,recal);
end

fclose(fid);











