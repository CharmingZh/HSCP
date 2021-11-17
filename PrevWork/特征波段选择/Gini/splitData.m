function [ Giniindex] = splitData( data, axis, value )  
    [m,n] = size(data);%得到待划分数据的大小  
     Giniindex = 0; %划分之后的熵 
    % 小于value
    subSet = data;  
    subSet(:,axis) = [];  
    k = 0;  
    for i = 1:m  
        if data(i,axis) >=value  
            subSet(i-k,:) = [];  
            k = k+1;  
        end  
    end     
   [m_1, n_1] = size(subSet);  
   prob = m_1./m;  
    Giniindex =  Giniindex + prob * calGini(subSet);  
   % 大于value
   subSet = data;  
   subSet(:,axis) = [];  
    k = 0;  
    for i = 1:m  
        if data(i,axis) <value  
            subSet(i-k,:) = [];  
            k = k+1;  
        end  
    end     
   [m_1, n_1] = size(subSet);  
   prob = m_1./m;  
   Giniindex=Giniindex + prob * calGini(subSet);  