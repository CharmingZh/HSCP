clear;clc;
data=xlsread('F:\���ڸ߹��׳�����������ʶ��\ƽ������\Wtrain.xlsx');
data_test=xlsread('F:\���ڸ߹��׳�����������ʶ��\ƽ������\Wtest.xlsx');
% ѵ������
P_train=data(:,2:size(data,2));
% ��������
P_test=data_test(:,2:size(data_test,2));
[m,n] = size(data);% �õ����ݼ��Ĵ�С  
baseEntropy = calEntropy(data);    % ԭʼ����  
infoGain=zeros(1,n-1); 
% ������Ϣ���� 
for j = 2:n % ��һ��Ϊ�����
    meanTemp=mean(data(:,j));
    newEntropy = splitData(data,j,meanTemp);
    %��������  
    infoGain(1,j-1) = baseEntropy - newEntropy;  
end
meaninfoGain=mean(infoGain);
[pks,locs] = findpeaks(infoGain,'minpeakheight',meaninfoGain);
% [pks,locs] = findpeaks(infoGain);
newTrain=P_train(:,locs);
newTest=P_test(:,locs);  