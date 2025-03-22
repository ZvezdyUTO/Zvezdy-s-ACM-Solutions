# New Rating

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年11月14日 13:30

我们需要从所有可能性中推导出状态，有了状态以后就可以设计状态转移方程，这也是动态规划的一种设计思路。像这题，对于每个格子，只有切断前、切断中、切断后三种状态，知道这三种状态以后很容易推导它们之间的状态转移方程。所以对于动态规划来说，推导可能性和找到表示状态非常重要。

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

const int N = 3e5 + 5;
int n;

std::array<int, N> arr;

std::array<std::array<int, 3>, N> f;

inline int dp() {
    std::fill(f.begin(), f.begin() + n + 1, std::array<int, 3>{-N, -N, -N});
    f[0][0] = 0;
    for (int i = 1; i <= n; ++i) {
        // 要么是不删、删除中、删除后
        // 如果是刚开始，那么就是从前面的f[i-1][0]
        f[i][0] = f[i - 1][0];
        if (f[i][0] < arr[i]) {
            ++f[i][0];
        } else if (f[i][0] > arr[i]) {
            --f[i][0];
        }

        f[i][1] = std::max(f[i - 1][0], f[i - 1][1]);

        f[i][2] = std::max(f[i - 1][2], f[i - 1][1]);
        if (f[i][2] < arr[i]) {
            ++f[i][2];
        } else if (f[i][2] > arr[i]) {
            --f[i][2];
        }
    }
    return std::max(f[n][1], f[n][2]);
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    std::cout << dp() << '\n';
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