# Natlan Exploring

所有者: Zvezdy
标签: 动态规划, 数论
创建时间: 2024年11月18日 15:07

题目给出了很明确的提示：所有数不大于1e6，那么这一题就可以分解因数求解，并且是按照值来进行映射转移，当我们计算f[i]的时候，我们选择从它所有因数中所包含的路径之和进行转移，并在求出值以后更新回他所有因数中。

不过这样就会有个严重的问题：如果一个数中出现多个重复的嵌套因子，那么按照我们的这个方法就会被重复计算，据此我们需要使用唯一分解定理来进行修正，而莫比乌斯函数正好契合了容斥这个过程。莫比乌斯函数的值是(-1)^k（k是一个数中不同质因数个数），而如果一个数某个质因数的指数大于1，那么也是重复计算，需要直接剔除。

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

const int N = 1e5 + 5;
const int M = 1e6 + 5;
const int MODE = 998244353;
int n;

std::array<int, N> arr;

std::array<int, M> mob;
std::array<std::vector<int>, M> divs;

inline void prework() {
    // 求莫比乌斯函数
    mob.fill(1);
    for (int i = 2; i < M; ++i) {
        for (int j = 2 * i; j < N; j += i) {
            mob[j] -= mob[i];
        }
    }

    // nlog分解因数
    for (int i = 2; i < M; ++i) {
        for (int j = i; j < N; j += i) {
            divs[j].push_back(i);
        }
    }
}

std::array<ll, M> sum;
std::array<ll, N> f;

inline ll dp() {
    for (int i = 1; i <= n; ++i) {
        if (i == 1) {
            f[i] = 1;
        } else {
            // 遍历所有因子，并使用莫比乌斯函数进行容斥
            for (auto num : divs[arr[i]]) {
                f[i] = (f[i] + mob[num] * sum[num]) % MODE;
            }
        }
        for (auto num : divs[arr[i]]) {
            sum[num] = (sum[num] + f[i]) % MODE;
        }
    }
    return f[n];
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    prework();
    std::cout << dp();
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    int Zvezdy = 1;
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```