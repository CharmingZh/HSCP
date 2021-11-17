Train=xlsread('Wtrain.xlsx');
Test=xlsread('Wtest.xlsx');
% 训练数据
P_train=Train(:,2:size(Train,2));
T_train=Train(:,1);
% 测试数据
P_test=Test(:,2:size(Test,2));
T_test=Test(:,1);
% A=xlsread('Wtrain.xlsx');
[m,n]=size(P_train);
sorted_target=sort(T_train,1);
label=zeros(1,1);                              
label(1,1)=sorted_target(1,1);
d=1;
    for i = 2:m
        if sorted_target(i,1) ~= label(d,1)
            d=d+1;
            label(d,1) = sorted_target(i,1);
        end
    end
g=d;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:g
    groupNum(i)=0;
    group(i)=0;
    for j=1:m
        if T_train(j)==i
           group(i)=group(i)+1;
        end
    end
    if i==1
       groupNum(i)=group(i);
    else
       groupNum(i)=groupNum(i-1)+group(i);
    end
end
group;
groupNum; %计算分类个数数组
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算总平均值
for j=1:n
    TotalMean(j)=0;
    for i=1:m
        TotalMean(j)=TotalMean(j)+P_train(i,j);
    end
    TotalMean(j)=TotalMean(j)/m;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GroupMean=[];
for i=1:g
    if i==1
       low=1;
       up=groupNum(i);
    else
       low=groupNum(i-1)+1;
       up=groupNum(i);
    end
    matrix=P_train(low:up,:);
    MatrixMean=mean(matrix); %各分类组平均值
    GroupMean=[GroupMean;MatrixMean];

    for u=low:up
       for v=1:n
           C(u,v)=P_train(u,v)-MatrixMean(v);
       end
    end
end

C;
GroupMean;
V=C'*C/(m-g);
V_inv=pinv(V); %对矩阵V求逆
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q1=GroupMean*V_inv;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:g
    lnqi(i)=log(group(i)/m);
    mat=GroupMean(i,:);
    Q2(i)=lnqi(i)-0.5*mat*V_inv*mat';
end
lnqi;
Q2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[u,v]=size(P_test);
result=[];
for i=1:u
    x=P_test(i,:);
    yy=Q1*x'+Q2';
    result=[result yy];
end
res=result'; %计算的待判数据对各标准数据的线性计算值

[rows,cols]=size(result);
for i=1:cols
    iljj=0;
    mlljj=result(:,i);
    for j=1:rows
        iljj=iljj+exp(result(j,i)-max(mlljj));
    end
    for j=1:rows
        houyangailv(j,i)=exp(result(j,i)-max(mlljj))/iljj;
    end
end
H=houyangailv'; %后验概率

MissClassificationRate_Testing=0;
for i=1:size(T_test,1);
    [f, NewG]=max(H(i,:));
    if T_test(i)~=NewG
       MissClassificationRate_Testing=MissClassificationRate_Testing+1;
    end
end
 TestAccuracy=1-MissClassificationRate_Testing/size(T_test,1);