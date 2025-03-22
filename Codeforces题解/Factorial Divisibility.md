# Factorial Divisibility

所有者: Zvezdy
标签: 数学
创建时间: 2025年1月2日 22:18

还是那句话，先对题目给定式子的特殊性质进行分析入手。题目给出的式子中大部分是阶乘，阶乘与阶乘相除，在a≤b的情况下a! | b!，并且整除仅可能在这种情况下发生。再观察题目给定的条件：一些阶乘相加，已知 a|c，b|c则a+b | c，因此我们完全可以不管那些大于等于x的元素，因为关于阶乘整除阶乘只有那个性质，所以我们需要将我们剩余元素的和加工成?|的形式，已知a!*(a+1)=(a+1)!，利用这个性质我们将我们的阶乘从小到大进行转移，最后变为?1*a! + ?2*a2! + ?3*a3!…，只要小于x的部分和为0，我们就可以认定这个式子是能够整除x!的。

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
// #define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int n, x;
    std::cin >> n >> x;
    std::map<int, int> freq;
    for (int i = 0, v; i < n; ++i) {
        std::cin >> v;
        if (v < x) {
            ++freq[v];
        }
    }
    for (auto [v, nums] : freq) {
        if (nums > v) {
            int add = nums / (v + 1);
            freq[v] -= add * (v + 1);
            freq[v + 1] += add;
        }
    }
    ll sum = 0;
    for (auto [v, nums] : freq) {
        if (v < x) {
            sum += v * nums;
        }
    }
    if (sum == 0) {
        std::cout << "yes\n";
    } else {
        std::cout << "no\n";
    }
}

void init() {}

signed main() {
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