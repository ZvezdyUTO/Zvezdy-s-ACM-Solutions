# River Locks

所有者: Zvezdy
标签: 思维
创建时间: 2025年2月24日 19:11

纯纯的思维题，题目给的是安排水管同时放水，但是可以发现，这种同时放水和每个水管轮流放t时间水是一样的，所以可以看作是我们让每个水管轮流放t小时水，看看能不能填满水池。但是我们还需要判断另一个条件：每个水管必须放在不同的位置，这就是说，如果我们放到第i个水管，但是前i-1个水管没有填满前i-1个水箱就会失败。

从base case开始判断，填满第一个水箱至少要a[1]/1时间，规定时间内填满了第一个水箱才能填第二个水箱，所以在第一个水箱被填满的前提下，填满两个水箱需要(a[1]+a[2])/2的时间，以此类推，我们填满前i个水箱要 sum(a[1]~a[i]+i-1)/i的时间，同时必须满足前面每个水箱都被填满，所以我们只要一路求过去填满每个水箱所需要的最大时间，并且在最终判断的时候依据这个进行特判，再用 sum/n向上取整=t这个方程就能求出至少需要的水箱。

此题需要技巧：等效代换、同时发生的累加量可以换做分批发生，以及从base case类似dp一样的用条件依赖关系进行推导。

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
    std::vector<int> arr(n);
    int sum = 0;
    int min = 0;
    for (int i = 1, v; i <= n; ++i) {
        std::cin >> v;
        sum += v;
        min = std::max(min, (sum + i - 1) / i);
    }
    int q;
    std::cin >> q;
    while (q--) {
        int t;
        std::cin >> t;
        if (t < min) {
            std::cout << "-1\n";
        } else {
            std::cout << ((sum + t - 1) / t) << '\n';
        }
    }
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