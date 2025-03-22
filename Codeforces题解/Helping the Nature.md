# Helping the Nature

所有者: Zvezdy
标签: 前缀和&差分
创建时间: 2025年2月24日 15:52

看到区间操作一般想到前缀和或者差分，前缀和进行区间操作一般是信息统合，这题要求让信息散开，所以可以考虑使用差分进行解决。关键在于，将原数组构建为差分数组后，原来的操作在差分的影响下从区间操作变成了双点操作，这样我们就可以挨个挨个格子进行操作并将它们化为0。

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
    std::vector<int> dif(n + 1);
    int lst = 0, now;
    for (int i = 0; i < n; ++i) {
        std::cin >> now;
        dif[i] = now - lst;
        lst = now;
    }
    dif[n] = -now;
    // ctrl1: dif[0]-1, dif[i+1]+1
    // ctrl2: dif[i]-1, dif[n]+1
    // ctrl3: dif[0]+1, dif[n]-1
    int ans = 0;
    for (int i = 1; i < n; ++i) {
        if (dif[i] > 0) {
            dif[n] += dif[i];
            ans += dif[i];
        } else {
            dif[0] += dif[i];
            ans -= dif[i];
        }
    }
    if (dif[0] > 0) {
        ans += dif[0];
        dif[0] = 0;
    }
    std::cout << ans - dif[0] << '\n';
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