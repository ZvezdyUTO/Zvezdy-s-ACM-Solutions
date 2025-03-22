# Fishing

所有者: Zvezdy
标签: 数学, 暴力枚举

我们在这题中需要枚举一个区间和时间，枚举区间一般都是枚举其某个端点，这里有一个贪心的trick：我们区间最优一定是左端点刚好在某一条鱼上面。因此我们是可以拿某条鱼作为左端点进行枚举的。

下一步就是看以某条鱼为左端点的时候，在什么时间上收益最高。敏锐发现时间其实是线性的，其它鱼匀速游动，那么很明显其它鱼就可能有一个时间区间，是会被我们网到的，计算这个时间区间，根据两条鱼之间距离=(x1-x2)+(v1-v2)t，可列出区间在(x1-x2)/(v2-v1), (a+x1-x2)/(v2-v1)范围内，但是还需要判号，让小的在左边大的在右边就行，这里可能会出现负数，说明鱼需要往回游，排除掉这种情况的部分就好。此时可以发现我们有效时间区间就是一条一条的带权线段，差分做扫描线即可。

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

const int N = 2e3 + 5;
const double eps = 1e-9;
int n, a;

std::array<std::array<int, 3>, N> fish;  // w, x, v

int Enum() {
    int ans = 0;

    for (auto [w1, x1, v1] : fish) {
        std::map<double, int> scan;
        int cur = 0;
        for (auto [w2, x2, v2] : fish) {
            if (v1 == v2 && x1 <= x2 && x1 + a >= x2) {
                cur += w2;
                continue;
            }
            double l = 1.0 * (x1 - x2) / (v2 - v1);
            double r = 1.0 * (a + x1 - x2) / (v2 - v1);
            if (l > r) std::swap(l, r);
            if (r >= 0) {
                l = std::max(l, 0.0);
                scan[l] += w2;
                scan[r + eps] -= w2;
            }
        }
        int res = cur;
        for (auto [_, w] : scan) {
            cur += w;
            res = std::max(res, cur);
        }
        ans = std::max(ans, res);
    }

    return ans;
}

void Main_work() {
    std::cin >> n >> a;
    for (int i = 1; i <= n; ++i) {
        std::cin >> fish[i][0] >> fish[i][1] >> fish[i][2];
    }
    // 区间问题，枚举左端点
    // 枚举左端点，寻找最长的右端点
    std::cout << Enum();
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