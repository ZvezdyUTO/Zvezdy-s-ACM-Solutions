# Range = √Sum

所有者: Zvezdy
标签: 数学, 构造
创建时间: 2024年12月8日 11:28

出题人依据的trick与平方数有关，同时因为要求每一个数都不一样，所以可以考虑每一位递增加一的构造方式，这么看来我们的构造就与平方数和等差数列公式有关。

猜想估计是构造n的平方，那么先考虑构造n个不同的数字，我们以n为中心构造公差为1的等差数列，如果n为奇数，那么我们得到的和就是n*n，刚好足够。如果n为偶数的话，会出现两个n在中间的情况，我们可以把那两个n换为对称的两个数，也就是把它们分别+1、-1往两端挤开，这样我们偶数部分就构造好了。如果是奇数的话，我们此时拿到的最大最小之差就是n-1，但如果我们进行微调，把原来和为n^2变为n^2+2*n，再变为n^2+2*n+1，就可以完美构造出奇数n的序列

```cpp
/* ★ _____                           _         ★ */
/* ★|__  / __   __   ___   ____   __| |  _   _ ★ */
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★ */
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★ */
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★ */
/* ★                                     |___/ ★ */
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using ll = long long;
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int n;
    std::cin >> n;
    std::vector<int> ans(n, 0);
    if (n % 2) {
        for (int i = n / 2, it = n; i >= 0; --i, --it) {
            ans[i] = it;
        }
        for (int i = n / 2, it = n; i < n; ++i, ++it) {
            ans[i] = it;
        }
        for (int i = 0; i < n; ++i) {
            ans[i] += 2;
        }
        ++ans[n - 1], ++ans[n - 2], --ans[0];
    } else {
        int it = n / 2;
        for (int i = 0; i < n; ++i) {
            if (it == n) {
                ++it;
            }
            ans[i] = it++;
        }
    }

    for (auto i : ans) {
        std::cout << i << ' ';
    }
    std::cout << '\n';
}

void init() {}

int main() {
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