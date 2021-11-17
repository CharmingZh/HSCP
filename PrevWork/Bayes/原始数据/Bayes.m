A=xlsread('Wtrain.xlsx');
[m,n]=size(A);
sorted_target=sort(A(:,1),1);
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
        if A(j,1)==i
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
for j=1:n-1
    TotalMean(j)=0;
    for i=1:m
        TotalMean(j)=TotalMean(j)+A(i,j+1);
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
    matrix=A(low:up,:);
    MatrixMean=mean(matrix); %各分类组平均值
    GroupMean=[GroupMean;MatrixMean];

    for u=low:up
       for v=2:n
           C(u,v-1)=A(u,v)-MatrixMean(v);
       end
    end
end
V=C'*C/(m-g);
V_inv=pinv(V); %对矩阵V求逆
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GroupMean=GroupMean(:,2:n);
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
B=xlsread('Wtest.xlsx');
[u,v]=size(B);
result=[];
for i=1:u
    x=B(i,:);
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

G=xlsread('G.xlsx');
MissClassificationRate_Testing=0;
for i=1:size(G,1);
    [f, NewG]=max(H(i,:));
    OG=G(i,1);
    if OG~=NewG
       MissClassificationRate_Testing=MissClassificationRate_Testing+1;
    end
end
 TestAccuracy=1-MissClassificationRate_Testing/size(G,1);