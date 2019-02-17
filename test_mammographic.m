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

%%
A = squareform(pdist(W(:,[1,3,4,5]),'spearman'));
A = A./max(max(A));
A = 1 - A;

% % d1=pdist(W(:,[1,3,4,5]),'spearman');
% % d1=(d1-min(d1))./(max(d1)-min(d1));
% % d2=pdist(W(:,2));
% % d2=(d2-min(d2))./(max(d2)-min(d2));
% % A=1-squareform((d1+d2)/2);

for i=1:N
    A(i,i)=0;
end

D = diag(sum(A,1));
L = D-A;

[s,u]=eig(L);
% labels = kmeans(s(:,2),2);
labels = s(:,2) < mean(s(:,2));
%% semisupervised start point
format short
fid = fopen('Results.txt', 'w');
fprintf(fid,'f,k,x_dis,f_dis,p,r');

percent = 6;
NChoose = round(percent/100 * N);

for ii=1:1000
    rand_x=zeros(N,1);
    for i=1:N
        rand_x(i)=i-(N+1)/2;
    end
    
    Pos_labels=find(Labels==1);
    Neg_labels=find(Labels==0);
    Pos_labels=Pos_labels(randperm(length(Pos_labels)));
    Neg_labels=Neg_labels(randperm(length(Neg_labels)));
    
    Pos_indx = sort(Pos_labels(1:NChoose));
    Neg_indx = sort(Neg_labels(1:NChoose));
    
    NV_ind=randperm(N/2);
    NV_ind=NV_ind(1:NChoose);
    PV_ind=randperm(N/2) + 415;
    PV_ind=PV_ind(1:NChoose);
    
    PVal=rand_x(PV_ind);
    NVal=rand_x(NV_ind);
    
    rand_x([NV_ind,PV_ind])=[];
    rand_x=rand_x(randperm(length(rand_x)));
    
    all_ind = sort([Pos_indx; Neg_indx]);
    for i=1:length(all_ind)
        rand_x = [rand_x(1:all_ind(i)-1);0;rand_x(all_ind(i):end)];
    end
    
    rand_x(Pos_indx)=PVal;
    rand_x(Neg_indx)=NVal;
    
    [f_value, x, k] = Spectral_Conjugate(L,rand_x);
    dis = min([norm(s(:,2)-x,2),norm(s(:,2)+x,2)]);
    dis2=abs(f_value-u(2,2));
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
    
    p2=fn/(fn+tn);
    r2=fn/(fn+tp);
    
    if p2>pre
        pre=p2;
        recal=r2;
    end
    
    fprintf(fid,'f%d,%d,%d,%d,%d,%d%',f_value,k,dis,dis2,pre,recal);
end
fclose(fid);
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
fprintf(fid,'f,k,x_dis,f_dis,p,r');

for j=1:1000
% rand_x = evaluation_stx(Labels, 0.001);
[f_value, x, k] = Spectral_Conjugate(L);
 dis = min([norm(s(:,2)-x,2),norm(s(:,2)+x,2)]);
 dis2=abs(f_value-u(2,2));
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

p2=fn/(fn+tn);
r2=fn/(fn+tp);

if p2>pre
    pre=p2;
    recal=r2;
end

fprintf(fid,'f%d,%d,%d,%d,%d,%d%',f_value,k,dis,dis2,pre,recal);
end

fclose(fid);











