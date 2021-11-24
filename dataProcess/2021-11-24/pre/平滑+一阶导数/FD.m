X=xlsread('train_s.xlsx');
Y=xlsread('test_s.xlsx');
FDX=diff(X,1,2);
FDY=diff(Y,1,2);