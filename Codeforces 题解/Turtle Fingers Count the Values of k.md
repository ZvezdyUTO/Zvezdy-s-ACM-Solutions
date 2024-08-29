# Turtle Fingers: Count the Values of k

所有者: Zvezdy
标签: 数学, 暴力枚举
创建时间: 2024年2月29日 16:51

按理来说，1e9遇上最小数2的n次方，那也就最多30次方，所以我们完全可以把所有的a和b都枚举一遍。

我们写一个双重for循环，外层枚举a内层枚举b，无法被整除就break，把所有算出来的k都录入map中。
