```matlab
function [trainData, trainLabel, testData, testLabel] = ...
    splitData(Data, label, ratio)
% splitData 将数据集随机拆分为测试集和训练集
% args list 待分数据集，标签，标签类别个数，划分比例
% ret Val   训练集，训练集标签，测试集，测试集标签
% example:
% [trainData, trainLabel, testData, testLabel] = splitData(Data, label, num, ratio)
[row, ~] = size(Data);
labelList = unique(label); % 去重，length(labelList) 应该等于 num

d = [1:row]'; % 用于保存行索引信息

trainData = [];
trainLabel = [];

num = length(labelList);

for i = 1:num
    comm_i = find(label == labelList(i));
    size_comm_i = length(comm_i);
    rp = randperm(size_comm_i);
    rp_ratio = rp(1:floor(size_comm_i * ratio));
    ind = comm_i(rp_ratio);
    trainData = [trainData; Data(ind, :)];
    trainLabel = [trainLabel; label(ind, :)];
    d = setdiff(d, ind);
end

testData = Data(d, :);
testLabel = label(d, :);

end
```

