X=xlsread('train.xlsx');
Y=xlsread('test.xlsx');
LX=log10(X);
LY=log10(Y);
writematrix(LX, 'Wtrain.xlsx');
writematrix(LY, 'Wtest.xlsx');