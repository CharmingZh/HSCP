clear;clc;
data=xlsread('F:\���ڸ߹��׳�����������ʶ��\ƽ������\Wtrain.xlsx');
data_test=xlsread('F:\���ڸ߹��׳�����������ʶ��\ƽ������\Wtest.xlsx');
% ѵ������
P_train=data(:,2:size(data,2));
% ��������
P_test=data_test(:,2:size(data_test,2));
[m,n] = size(data);% �õ����ݼ��Ĵ�С  
Giniindex=zeros(1,n-1); 
% ������Ϣ���� 
for j = 2:n % ��һ��Ϊ�����
    meanTemp=mean(data(:,j));
    %�������ָ�� 
    Giniindex(1,j-1) = splitData(data,j,meanTemp);
end
IndMin=find(diff(sign(diff(Giniindex)))>0)+1;
newTrain=P_train(:,IndMin);
newTest=P_test(:,IndMin);
