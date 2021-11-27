X=xlsread('train.xlsx');
Y=xlsread('test.xlsx');
FDX=diff(X,1,2);
FDY=diff(Y,1,2);

writematrix(X, 'Wtrain.xlsx');
writematrix(Y, 'Wtest.xlsx');