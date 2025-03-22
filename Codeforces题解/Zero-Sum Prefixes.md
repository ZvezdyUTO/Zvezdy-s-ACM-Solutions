# Zero-Sum Prefixes

所有者: Zvezdy
标签: 前缀和&差分, 数学
创建时间: 2024年12月9日 09:49

很有意思的一道题目，我们发现我的操作会对后面造成影响，同时也会受到前面的影响，再加上我们是没有前效性的，也就是说我们我们可以同时抵消前面的影响以及对后面造成影响，这需要用到加法的叠加性。因此我们发现我们一个0所能影响到的范围是末尾/下一个0出现的位置。根据前缀和的性质，两个相等的前缀和可以组合出一个0，所以我们只要找两个0中间的众数，让左边的0等于那个众数就能取到小区间里面的最大值。

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
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    std::map<ll, int> freq;
    int max = 0;
    int ans = 0;
    ll pre = 0;
    bool start = false;
    for (int i = 0; i < n; ++i) {
        if (arr[i] == 0) {
            start = true;
            ans += max;
            pre = 0;
            max = 0;
            freq.clear();
        }
        if (!start) {
            pre += arr[i];
            ans += pre == 0;
            continue;
        }
        pre += arr[i];
        ++freq[pre];
        max = std::max(max, freq[pre]);
    }
    ans += max;
    std::cout << ans << '\n';
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