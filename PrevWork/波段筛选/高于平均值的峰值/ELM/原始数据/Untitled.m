% 导入数据
Train=xlsread('Wtrain.xlsx');
Test=xlsread('Wtest.xlsx');
% 训练数据
P_train=Train(:,2:size(Train,2))';
T_train=Train(:,1)';
[m,n]=size(P_train);
% 测试数据
P_test=Test(:,2:size(Test,2))';
T_test=Test(:,1)';
[m1,n1]=size(P_test);
% 检测类别数目
sorted_target=sort(cat(2,T_train,T_test),2);
label=zeros(1,1);                              
label(1,1)=sorted_target(1,1);
j=1;
for i = 2:(n+n1)
    if sorted_target(1,i) ~= label(1,j)
        j=j+1;
        label(1,j) = sorted_target(1,i);
    end
end
number_class=j;
       
Tn_train=zeros(number_class,n);
for i = 1:n
    for j = 1:number_class
        if label(1,j) == T_train(1,i)
            break; 
        end
    end
    Tn_train(j,i)=1;
end

Tn_test=zeros(number_class,n1);
for i = 1:n1
    for j = 1:number_class
        if label(1,j) == T_test(1,i)
            break; 
        end
    end
    Tn_test(j,i)=1;
end
net=newff(P_train,Tn_train,100);
   net.trainParam.epochs=100;
   net.trainParam.lr=0.1;
   net.trainParam.goal=0.01;
   %BP 神经网络训练
   net=train(net,P_train,Tn_train);
   % 训练数据预测
   Y_train=sim(net,P_train);
   Y_test=sim(net,P_test);
   
   MissClassificationRate_Training=0;
MissClassificationRate_Testing=0;
 for i = 1 : size(Tn_train, 2)
        [x,label_index_expected]=max(Tn_train(:,i));
        [x,label_index_actual]=max(Y_train(:,i));
        if label_index_actual~=label_index_expected
            MissClassificationRate_Training=MissClassificationRate_Training+1;
        end
    end
    TrainingAccuracy=1-MissClassificationRate_Training/size(Tn_train,2);
    
    for i = 1 : size(Tn_test, 2)
        [x, label_index_expected]=max(Tn_test(:,i));
        [x, label_index_actual]=max(Y_test(:,i));
        Ytest_label(i)=label_index_actual;
        if label_index_actual~=label_index_expected
            MissClassificationRate_Testing=MissClassificationRate_Testing+1;
        end
    end
    TestingAccuracy=1-MissClassificationRate_Testing/size(Tn_test,2);