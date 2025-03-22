# Best Concatenation

所有者: Zvezdy
标签: 字符串, 排序

其实在初步推导的时候就已经发现，在讨论摆放字符串顺序的时候，前面的所有字符串都可以抽象看作是x的个数和以前分值的总和，而新加进来这个串后我们的总贡献是 以前的总贡献+现在这个串与前面所有x带来的总贡献。此时我们正在解决一种排序问题，更重要的是发现此时的排序是可以从相邻最优链式推导至全局最优的，因此使用std::sort可以完美解决这个问题。

下次遇到排序问题，并且是可以由相邻最优推广至全局最优的，统一使用自定义排序函数+std::sort处理。

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
#define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int n;
    std::cin >> n;
    std::vector<std::string> str(n);
    for (auto& i : str) {
        std::cin >> i;
    }
    auto sco = [](std::string chk) {
        int res = 0;
        int x = 0;
        for (auto ch : chk) {
            if (ch == 'X') {
                ++x;
            } else {
                int v = ch - '0';
                res += v * x;
            }
        }
        return res;
    };
    std::sort(str.begin(), str.end(), [&](auto a, auto b) {
        return sco(a + b) > sco(b + a);
    });
    std::string solve = "";
    for (int i = 0; i < n; ++i) {
        solve += str[i];
    }
    std::cout << sco(solve) << '\n';
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```