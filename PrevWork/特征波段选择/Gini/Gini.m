clear;clc;
data=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtrain.xlsx');
data_test=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtest.xlsx');
% 训练数据
P_train=data(:,2:size(data,2));
% 测试数据
P_test=data_test(:,2:size(data_test,2));
[m,n] = size(data);% 得到数据集的大小  
Giniindex=zeros(1,n-1); 
% 计算信息增益 
for j = 2:n % 第一列为类别项
    meanTemp=mean(data(:,j));
    %计算基尼指数 
    Giniindex(1,j-1) = splitData(data,j,meanTemp);
end
IndMin=find(diff(sign(diff(Giniindex)))>0)+1;
newTrain=P_train(:,IndMin);
newTest=P_test(:,IndMin);
