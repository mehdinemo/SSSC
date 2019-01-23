close all
clear all
clc
format long
fileID = fopen('E:\User Identify\UserIdentify\NNet\bin\Debug\Followers.txt');
C = textscan(fileID,'%u64 %u64');
fclose(fileID);
% % sorce = C{1};
% % destination = C{2};

N = length(C{1});
W = uint64(zeros(N,2));
for i=1:N
    W(i,1)=C{1}(i);
    W(i,2)=C{2}(i);
end

clear C;
clear fileID;

nodes = unique(W);











