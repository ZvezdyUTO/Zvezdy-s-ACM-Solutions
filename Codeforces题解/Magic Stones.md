# Magic Stones

所有者: Zvezdy
标签: 数学
创建时间: 2024年10月31日 21:24

猜猜题，如果把这题的数组转化为差分数组，再在此基础上对原元素进行操作，就会发现是把两个元素调换了位置。。。

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
#define debug(x) std::cout << #x << " = " << x << std::endl

const int N = 2e5 + 5;
int n;

std::array<ll, N> a, b;
std::array<ll, N> A, B;

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> a[i];
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> b[i];
    }
    if (a[1] != b[1] || a[n] != b[n]) {
        std::cout << "No\n";
        return;
    }
    for (int i = 1; i <= n; ++i) {
        A[i] = a[i] - a[i - 1];
        B[i] = b[i] - b[i - 1];
    }
    std::map<ll, int> mp;
    for (int i = 1; i <= n; ++i) {
        ++mp[A[i]];
        --mp[B[i]];
    }
    for (auto [_, check] : mp) {
        if (check) {
            std::cout << "No\n";
            return;
        }
    }
    std::cout << "Yes\n";
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    init();
    int Zvezdy = 1;
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```