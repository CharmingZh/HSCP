A=xlsread('train.xlsx');
B=xlsread('test.xlsx');

for i=1:size(A,1)
    SA(i,:)=smooth(A(i,:),10,'sgolay');
end
for j=1:size(B,1)
    SB(j,:)=smooth(B(j,:),10,'sgolay');
end
writematrix(A, 'Wtrain.xlsx');
writematrix(B, 'Wtest.xlsx');