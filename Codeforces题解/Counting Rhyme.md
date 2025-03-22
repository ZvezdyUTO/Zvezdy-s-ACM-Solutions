# Counting Rhyme

所有者: Zvezdy
标签: 动态规划, 数学
创建时间: 2025年3月14日 09:31

这题给出了一个关键的信息：整除，对于整除这个操作，通常情况下都和gcd以及gcd的因数有关。不过肯定先从gcd方面入手。为了找切入点，先从打出暴力解开始行动，枚举每个对i与j，如果gcd(arr[i], arr[j])的因数在数组中出现过，那么肯定是无效对。观察到题目给出的所有数大小不超过1e6，因此完全可以从枚举每个数这个方法下手，于是记录一个vis数组，如果i的因数在数组中出现过，那么vis[i]=false。因此只要有是数组中没有出现过其因子的gcd所对应的数对都完全有效。根据之前的经验，可以通过枚举gcd来反向计算出数对个数。

已知一个gcd为d的数对，元素一定能被d整除，但还有一个重要条件，能整除这个数对的数最大一定必须是d，所以我们还需要在这个预选组中容斥掉那些gcd更大的数。我们这么选其实选出来的是能被d整除的数字个数，那么那些多余的数对就是gcd不等于d但是d是它们gcd的因子，所以逆向思维可以减去gcd为2d 3d 4d…的数对个数，可以看出这是一个依赖以前答案的关系，所以打出dp进行解决。

经典trick：整除关系通常想到gcd以及分解gcd的因子，如果所有数的大小在一个较小的范围内，完全可以考虑逆向进行枚举统计，无论如何处理都可能遇到需要使用埃氏筛思想找倍数，这时候明确整除和gcd的概念就特别重要了。遇到依赖的递归求解关系可以想到使用动态规划进行优化解决。

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
    std::vector<int> cnt(n + 1, 0);
    for (int i = 0, v; i < n; ++i) {
        std::cin >> v;
        ++cnt[v];
    }

    std::vector<bool> vis(n + 1, 1);
    for (int i = 1; i <= n; ++i) {
        if (cnt[i] == 0) continue;
        for (int j = i; j <= n; j += i) vis[j] = false;
    }

    for (int i = 1; i <= n; ++i) {
        for (int j = 2 * i; j <= n; j += i) {
            cnt[i] += cnt[j];
        }
    }

    int ans = 0;
    std::vector<int> f(n + 1, 0);
    for (int d = n; d >= 1; --d) {
        f[d] = cnt[d] * (cnt[d] - 1) / 2ll;
        for (int it = 2 * d; it <= n; it += d) f[d] -= f[it];
        ans += f[d] * vis[d];
    }

    std::cout << ans << '\n';
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