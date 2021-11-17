% data=xlsread('Testing Acc.xlsx');
load('data.mat')
y=mean(data,1);
% index=find(data(1,:)~=0);
index=5:5:500;
plot(index,y(index))