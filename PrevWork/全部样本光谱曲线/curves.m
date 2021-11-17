X=xlsread('All samples1.xlsx');
plot(X(1,:),X(2,:),'r');
hold on
plot(X(1,:),X(110,:),'g');
hold on
plot(X(1,:),X(278,:),'b');
hold on
for i=3:109
plot(X(1,:),X(i,:),'r');
hold on
end
for i=111:277
plot(X(1,:),X(i,:),'g');
hold on
end
for i=279:403
plot(X(1,:),X(i,:),'b');
hold on
end
legend('data1','data2','data3');
