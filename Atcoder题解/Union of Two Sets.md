# Union of Two Sets

所有者: Zvezdy
标签: ST表, 交互题

发现4000*log(4000)很接近50000，考虑使用nlog的构造方式，用两个区间的交集覆盖一个区间的思想和ST表一模一样。

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
    std::vector<std::vector<int>> L(n + 1);
    std::vector<std::array<int, 2>> save;
    int cnt = 0;
    for (int l = 1; l <= n; ++l) {
        // 按l端点 1 2 4 8 16存储线段
        for (int len = 1; l + len - 1 <= n; len *= 2) {
            L[l].push_back(++cnt);
            save.push_back({l, l + len - 1});
        }
    }
    std::cout << save.size() << std::endl;
    for (auto [l, r] : save) {
        std::cout << l << ' ' << r << std::endl;
    }

    int q;
    std::cin >> q;
    while (q--) {
        int l, r;
        std::cin >> l >> r;
        for (int i = 12; i >= 0; --i) {
            int len = (1 << i);
            if (l + len - 1 <= r) {
                std::cout << L[l][i] << ' ';
                std::cout << L[r - len + 1][i] << std::endl;
                break;
            }
        }
    }
}

void init() {}

int main() {
    // std::ios::sync_with_stdio(false);
    // std::cin.tie(0), std::cout.tie(0);
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