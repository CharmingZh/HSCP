A=xlsread('train.xlsx');
[m,n]=size(A); 
rmean=mean(A,2);  
dr=A-repmat(rmean,1,n);
Asnv=dr./repmat(sqrt(sum(dr.^2,2)/(n-1)),1,n); 
writematrix(Asnv, 'Wtrain.xlsx');