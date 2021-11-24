从`530.xlsx`开始的数据为标注正确，并且采集条件相同：

> - 积分时间：20
> - 拍照次数：2
> - 平滑度：2

因此全部整合到最新的数据集文件：`all_20_2_2.xlsx`中；其余三个拍摄条件不同的文件，可以尝试用如下方法解决：

- 积分时间不同：数据归一化，因为想要获取趋势信息；
- 拍照次数：只是代表一个平均值；
- 平滑度：将平滑度为0的数据，每一个索引取前后各两位数据取算术平均值。

`all_20_2_2.xlsx`中，第一个`sheet`中的数据第一列为标签，后续为响应度，注意，响应度只是一个`count`值，无实际的物理单位。数据从上至下可划分为如下九组：

- 8成熟：42个；
- 7.6成熟：6个；
- 7.5成熟：18个；
- 7.2成熟：2个；
- 7成熟：36个；
- 6.8成熟：24个；
- 6.5成熟：30个；
- 6成熟：12个；
- 5.5成熟：6个；

```matlab
% 读入数据并保存成熟度标签
Data = xlsread('all_20_2_2.xlsx');
one = xlsread('one.xlsx')
x = xlsread('X_axis.xlsx')
[m, n] = size(Data)
for i = 1:m
	label(i) = Data(i, 1);
	data(i, :) = Data(i, 2:end);
end

% 按成熟度画出不同颜色的线条
for i = 1:m
	if( label(i) == 7.5)
		plot(x(:), data(i, :), 'r')
		hold on
	elseif( label(i) == 6.8)
		plot(x(:), data(i, :), 'g')
		hold on
	elseif( label(i) == 7.2)
		plot(x(:), data(i, :), 'b')
		hold on
	elseif( label(i) == 6.5)
		plot(x(:), data(i, :), 'm')
		hold on
	elseif( label(i) == 7)
		plot(x(:), data(i, :), 'k')
		hold on
	elseif( label(i) == 6)
		plot(x(:), data(i, :), 'y')
		hold on
	else
		plot(x(:), data(i, :), 'c')
		hold on
	end
end

% 按成熟度画出不同颜色的线条 归一化版本
for i = 1:m
	if( label(i) == 7.5)
		plot(x(:), one(i, :), 'r')
		hold on
	elseif( label(i) == 6.8)
		plot(x(:), one(i, :), 'g')
		hold on
	elseif( label(i) == 7.2)
		plot(x(:), one(i, :), 'b')
		hold on
	elseif( label(i) == 6.5)
		plot(x(:), one(i, :), 'm')
		hold on
	elseif( label(i) == 7)
		plot(x(:), one(i, :), 'k')
		hold on
	elseif( label(i) == 6)
		plot(x(:), one(i, :), 'y')
		hold on
	else
		plot(x(:), one(i, :), 'c')
		hold on
	end
end
```

![image-20211120113902670](https://tva1.sinaimg.cn/large/008i3skNgy1gwlgqdtk63j31bk0u0ap3.jpg)

将此组数据暂时作为工作数据。

```matlab
% 读入数据并保存成熟度标签
Data = xlsread('all_20_2_2.xlsx');
one = xlsread('one.xlsx')
x = xlsread('X_axis.xlsx')
[m, n] = size(Data)
for i = 1:m
	label(i) = Data(i, 1);
	data(i, :) = Data(i, 2:end);
end

% 按成熟度画出不同颜色的线条
for i = 1:m
	if( label(i) == 7.5)
		plot(x(:), data(i, :), 'r')
		hold on
	elseif( label(i) == 6.8)
		plot(x(:), data(i, :), 'k')
		hold on
	elseif( label(i) == 7.2)
		plot(x(:), data(i, :), 'r')
		hold on
	elseif( label(i) == 6.5)
		plot(x(:), data(i, :), 'k')
		hold on
	elseif( label(i) == 7)
		plot(x(:), data(i, :), 'r')
		hold on
	elseif( label(i) == 6)
		plot(x(:), data(i, :), 'k')
		hold on
	else
		plot(x(:), data(i, :), 'c')
		hold on
	end
end

```

![image-20211120124824046](https://tva1.sinaimg.cn/large/008i3skNgy1gwliqmbpprj31al0u04d3.jpg)

