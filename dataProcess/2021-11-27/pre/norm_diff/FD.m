X=xlsread('train.xlsx');
Y=xlsread('test.xlsx');
FDX=diff(X,1,2);
FDY=diff(Y,1,2);

writematrix(FDX, 'Wtrain.xlsx');
writematrix(FDY, 'Wtest.xlsx');