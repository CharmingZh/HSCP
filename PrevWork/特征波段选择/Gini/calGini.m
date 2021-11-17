function [ Gini] = calGini( data )  
    [m,n] = size(data);  
      
    % �õ�������  
    label = data(:,1);  
      
    % �������label  
    label_deal = unique(label);  
      
    numLabel = length(label_deal);  
    prob = zeros(numLabel,2);  
      
    % ͳ�Ʊ�ǩ  
    for i = 1:numLabel  
        prob(i,1) = label_deal(i,:);  
        for j = 1:m  
            if label(j,:) == label_deal(i,:)  
                prob(i,2) = prob(i,2)+1;  
            end  
        end  
    end  
      
    % ������  
    prob(:,2) = prob(:,2)./m;  
    G= 0;  
    for i = 1:numLabel  
        G=G+ prob(i,2)^2;
    end  
    Gini=1-G;
end  