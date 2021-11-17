clear;clc;
data=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtrain.xlsx');
data_test=xlsread('F:\基于高光谱成像技术的树种识别\平滑光谱\Wtest.xlsx');
% 训练数据
P_train=data(:,2:size(data,2));
% 测试数据
P_test=data_test(:,2:size(data_test,2));
[m,n] = size(data);% 得到数据集的大小  
baseEntropy = calEntropy(data);    % 原始的熵  
infoGain=zeros(1,n-1); 
% 计算信息增益 
for j = 2:n % 第一列为类别项
    meanTemp=mean(data(:,j));
    newEntropy = splitData(data,j,meanTemp);
    %计算增益  
    infoGain(1,j-1) = baseEntropy - newEntropy;  
end
meaninfoGain=mean(infoGain);
[pks,locs] = findpeaks(infoGain,'minpeakheight',meaninfoGain);
% [pks,locs] = findpeaks(infoGain);
newTrain=P_train(:,locs);
newTest=P_test(:,locs);  