# Lethal Company

所有者: Zvezdy
标签: 二分答案, 贪心

不难发现存活时间具有单调性，那么我们就可以用二分答案来进行枚举讨论。现在来看怎么验证在limit时间内能够存活。对于每个173，都有它出现时间+到达我们的时间+我们定身它的时间=limit。如果我们limit很小，那么定身时间在这个方程中会变为负数，意思是在这段时间内它不可能接近我们，选择跳过判断。已知我们定身它们的时间是按照走廊来单独分配的，所以我们开一个桶数组来储存我们对某个走廊使用的凝视，现在我们是剩余可用时间-当前单独定身所需时间>它出现的时间。根据等式可知我们的定身时间是见一个少一个的，所以最好是按照出现时间从大到小来判断。

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

const int N = 5e5 + 5;
const ll INF = 4e18;
int n, m;
ll k;

struct Info {
    ll t, x, y;
    bool operator<(const Info &ano) {
        return t > ano.t;
    }
};
std::array<Info, N> info;

std::array<ll, N> bkt;

bool check(ll limit) {
    std::fill(bkt.begin() + 1, bkt.begin() + n + 1, 0);
    ll tmp = limit;  // 剩余观察资源
    for (int i = 1; i <= m; ++i) {
        ll need = limit + 2 - info[i].t - (info[i].y + k - 1) / k - bkt[info[i].x];
        if (need > 0) {
            tmp -= need;
            // 剩余观察资源能不能撑到它出现的时间
            if (tmp + 1 < info[i].t) {
                return false;
            }
            bkt[info[i].x] += need;
        }
    }
    return true;
}

inline ll solve() {
    std::sort(info.begin() + 1, info.begin() + m + 1);
    ll l = 0, r = INF + 5;
    ll res = r;
    while (l <= r) {
        ll mid = l + (r - l) / 2ll;
        if (check(mid)) {
            res = mid;
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }
    if (res > INF) {
        return -1;
    } else {
        return res;
    }
}

void Main_work() {
    std::cin >> n >> m >> k;
    for (int i = 1; i <= m; ++i) {
        std::cin >> info[i].t >> info[i].x >> info[i].y;
    }
    std::cout << solve();
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