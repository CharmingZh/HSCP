```matlab
for i = 1:138
if(C(i, 1) == 7.5)
plot(x(:), C(i, :), 'r')
hold on
elseif( C(i, 1) == 6.8)
plot(x(:), C(i, :), 'g')
hold on
elseif(C(i, 1) == 7.2)
plot(x(:), C(i, :), 'b')
hold on
elseif(C(i, 1) == 6.5)
plot(x(:), C(i, :), 'm')
hold on
elseif(C(i, 1) == 7)
plot(x(:), C(i, :), 'k')
elseif(C(i, 1) == 6)
plot(x(:), C(i, :), 'y')
hold on
else
plot(x(:), C(i, :), 'c')
hold on
end
end
```

![image-20211119163310032](https://tva1.sinaimg.cn/large/008i3skNgy1gwkjm4jrqdj317z0pg4br.jpg)