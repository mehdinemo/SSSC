clear all
close all
clc

X=iris_dataset';
X=X(1:100,:);
X = X./max(X);
N=size(X,1);
ind =randperm(N);
% X = X(ind,:);

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

[s,~] = eig(L);
s=s(:,2);

G = graph(A);
plot(G)

[SM, SD] = SymmetricSparse(A);
%%
fid = fopen('Results.txt', 'w');
for iii=1:100
x_0 = 0.5 * ones(N,1);
% x_0(51:100) = -x_0(51:100);
% x_0 = x_0(ind,:);
pos=[];
neg=[];
% % p_ind=randperm(100);
% % ii=1;
% % while length(pos)<10
% %     if(p_ind(ii)>50)
% %         pos = [pos,p_ind(ii)];
% %     end
% %     ii = ii+1;
% % end
% % neg=randperm(50,10);
in=0;
out=0;
r=randperm(100,15);
L1 = length(find(r<51));
for i=1:length(r)
    if r(i)<51
        in = in+sum(A(r(i),1:50));
        out = out+sum(A(r(i),51:100));
        neg=[neg,r(i)];
    else
        in = in+sum(A(r(i),51:100));
        out = out+sum(A(r(i),1:50));
        pos=[pos,r(i)];
    end
end

s=sum([SD(pos);SD(neg)]);

count=0;
for j=1:1000
    x_0 = 0.5 * ones(N,1);
    random_ind=randperm(N);
    for i=1:length(r)
%         random_ind(find(random_ind==pos(i)))=[];
%         random_ind(find(random_ind==neg(i)))=[];
        random_ind(find(random_ind==r(i)))=[];
    end
    random_ind = [pos,random_ind,neg];

    x_0(random_ind(51:100)) = -x_0(random_ind(51:100));

    [f_value, x, k] = SparseSpectralConjugate(SM, SD, x_0);
    count = count+k;
end
count=count/1000;
fprintf(fid,'In=%d, Out=%d, Sum=%d, Count=%d%, L1=%d',in,out,s,count,L1);
end
fclose(fid);
%%
count=0;
for i=1:1000
    [f_value, x, k] = SparseSpectralConjugate(SM, SD);
    count = count+k;
end
count/1000

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

