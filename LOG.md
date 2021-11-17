# 基于高光谱技术的香蕉成熟度分类

```matlab
% 读入
cd dataProcess/target_1
x = xlsread('X_axis.xlsx'); % 1 * 2049
top = xlsread('All_top_label.xlsx'); % 116 * 2049
mid = xlsread('All_mid_label.xlsx'); % 112 * 2049
tail = xlsread('All_tail_label.xlsx'); % 108 * 2049
all = xlsread('All_data.xlsx'); % 302 * 2049
```



```matlab

% 按部位绘图
for i = 2:117
	plot( top(1, :), top(i, :), 'r')
	plot( mid(1, :), mid(i, :), 'b')
	plot( tail(1, :), tail(i, :), 'g')
	hold on
end

for i = 1:116
	plot( x(:), top(i, :), 'r')
	plot( x(:), mid(i, :), 'b')
	plot( x(:), tail(i, :), 'g')
	hold on
end

legend('tail', 'top', 'mid');
axis([350 900 0 600])

```

```matlab
% 将相同部位的曲线 计算均值为一条曲线
top_vec = zeros(1, 2049);
mid_vec = zeros(1, 2049);
tail_vec = zeros(1, 2049);
for i = 1:2049
	top_vec(i) = mean(top(:, i));
	mid_vec(i) = mean(mid(:, i));
	tail_vec(i) = mean(tail(:, i));
end
```

![image-20211115135519499](https://tva1.sinaimg.cn/large/008i3skNly1gwfsklj93jj31b00u0mym.jpg)

```matlab
% draw depend on ripeness
for i = 1:302
	if(all(i, 1) == 5)
		plot(x(:), all(i, :), 'g')
		count = count + 1;
		hold on
	elseif(all(i, 1) == 5.5)
		plot(x(:), all(i, :), 'g')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 6)
		plot(x(:), all(i, :), 'b')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 6.5)
		plot(x(:), all(i, :), 'b')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 6.8)
		plot(x(:), all(i, :), 'b')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 7)
		plot(x(:), all(i, :), 'y')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 7.5)
		plot(x(:), all(i, :), 'y')
		hold on
		count = count + 1;
	elseif(all(i, 1) == 8)
		plot(x(:), all(i, :), 'r')
		hold on
		count = count + 1;
	else
		plot(x(:), all(i, :), 'o')
		hold on
		count = count + 1;
	end
end
% 5 ～ 5.5 Green
% 6 ～ 6.8 Blue
% 7 ～ 7.5 Yellow
% 8 Red
axis([350 900 0 600])
```

![image-20211115135453990](https://tva1.sinaimg.cn/large/008i3skNly1gwfsk7j3pdj31ap0u0qpq.jpg)
