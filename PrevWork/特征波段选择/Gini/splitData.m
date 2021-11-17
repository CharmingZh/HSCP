function [ Giniindex] = splitData( data, axis, value )  
    [m,n] = size(data);%�õ����������ݵĴ�С  
     Giniindex = 0; %����֮����� 
    % С��value
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
   % ����value
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