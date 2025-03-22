# Problem about GCD

所有者: Zvezdy
标签: 数学
创建时间: 2025年3月22日 10:54

要求一段区间内尽可能远的同gcd数对，这里可以稍微转换一下思路，因为这两个数的GCD一样，所以把它们共同除上它们的gcd后，就是寻找两个最远互质点。这个是xx的倍数然后做除法处理进行讨论优化的trick似乎是比较常见的。求最远互质点有一个数学结论：两个相邻的质数不会太远。所以我们只需要暴力枚举，就可以在log的时间内找出来，或者根本找不出来，找不出来的情况肯定是区间过短了。

```cpp
/*
 *  ██╗   ██╗████████╗ ██████╗ ███╗   ██╗██╗   ██╗████████╗
 *  ██║   ██║╚══██╔══╝██╔═══██╗████╗  ██║██║   ██║╚══██╔══╝
 *  ██║   ██║   ██║   ██║   ██║██╔██╗ ██║██║   ██║   ██║
 *  ██║   ██║   ██║   ██║   ██║██║╚██╗██║██║   ██║   ██║
 *  ╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║╚██████╔╝   ██║
 *   ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝    ╚═╝
 *
 *  ███████╗██╗   ██╗███████╗███████╗██████╗ ██╗   ██╗
 *  ╚══███╔╝██║   ██║██╔════╝╚══███╔╝██╔══██╗╚██╗ ██╔╝
 *    ███╔╝ ██║   ██║█████╗    ███╔╝ ██║  ██║ ╚████╔╝
 *   ███╔╝  ╚██╗ ██╔╝██╔══╝   ███╔╝  ██║  ██║  ╚██╔╝
 *  ███████╗ ╚████╔╝ ███████╗███████╗██████╔╝   ██║
 *  ╚══════╝  ╚═══╝  ╚══════╝╚══════╝╚═════╝    ╚═╝
 */
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using ll = long long;
#define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int L, R, g;
    std::cin >> L >> R >> g;
    L = (L + g - 1) / g, R /= g;
    int ans = 0;
    int len = R - L;
    while (len >= 0) {
        for (int l = L; l <= R - len; ++l) {
            if (std::gcd(l, l + len) == 1) {
                std::cout << l * g << ' ' << (l + len) * g << '\n';
                return;
            }
        }
        --len;
    }
    std::cout << "-1 -1\n";
}

void init() {
}

signed main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    int Zvezdy = 1;
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```