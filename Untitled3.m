close all
clear all
clc
format long
% fileID = fopen('E:\User Identify\UserIdentify\NNet\bin\Debug\Followers.txt');
fileID = fopen('C:\Users\m.nemati\Desktop\Gephi\Retweet_Edges.txt');
C = textscan(fileID,'%u64 %u64 %f');
fclose(fileID);
% % sorce = C{1};
% % destination = C{2};

N = length(C{1});
W = uint64(zeros(N,3));
for i=1:N
    W(i,1)=C{1}(i);
    W(i,2)=C{2}(i);
    W(i,3)=C{3}(i);
end

clear C;
clear fileID;

nodes = unique(W(:,1:2));
SM = zeros(size(W));
for i=1:size(W,1)
    SM(i,1)=find(nodes==W(i,1));
    SM(i,2)=find(nodes==W(i,2));
end
SM(:,3)=W(:,3);
SD=DegreSparse(SM);









