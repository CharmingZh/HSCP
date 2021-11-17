将所有样本绘制出来后，可以看到191～350的区间内有大量噪声信号（0 ～ 191 nm为缺省值，无意义），所以考虑剔除掉 400nm 以下的数据；

![image-20211115143615347](https://tva1.sinaimg.cn/large/008i3skNly1gwftr97dwrj31e80u0dys.jpg)

![image-20211115141010990](https://tva1.sinaimg.cn/large/008i3skNly1gwft01uwq3j30u0128api.jpg)

```matlab
% 读入
cd dataProcess/target_2
x = xlsread('X_axis.xlsx'); % 1 * 1487
top = xlsread('All_top_label.xlsx'); % 116 * 1487
mid = xlsread('All_mid_label.xlsx'); % 112 * 1487
tail = xlsread('All_tail_label.xlsx'); % 108 * 1487
all = xlsread('All_data.xlsx'); % 302 * 1487
```

