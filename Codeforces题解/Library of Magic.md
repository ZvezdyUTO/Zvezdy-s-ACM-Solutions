# Library of Magic

所有者: Zvezdy
标签: 互动题, 位运算
创建时间: 2024年11月21日 15:23

经典异或性质，x^x=0，所以按理来说只需要二分找到这三个数在哪里，初步想法是先弄到三个数异或之值，然后二分找最大的数c和最小的数a，最后通过三个数的异或值处理出中间的数b。

但是有a^b^c==0的特殊情况，需要特殊讨论。注意到我们只有三个数a b c，这说明我们组合出的三个数里面，每一位要么三个都不是1，要么有两个数在这一位是1，所以我们把询问的范围从1~n不断缩短，每次除去最高一位，当询问不为0的时候，就说明我们除掉了b和c，此时询问值为a，接下来在a+1~n中求得c就可以拿到答案。

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

ll n;

ll Query(ll l, ll r) {
    std::cout << "xor " << l << ' ' << r << std::endl;
    ll get;
    std::cin >> get;
    return get;
}

ll Find_low(ll x, ll y) {
    ll l = x, r = y;
    ll res = y;
    while (l <= r) {
        ll mid = l + (r - l) / 2;
        if (Query(l, mid)) {
            res = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }
    return res;
}

ll Find_high(ll x, ll y) {
    ll l = x, r = y, res = l;
    while (l <= r) {
        ll mid = l + (r - l) / 2;
        if (Query(mid, r)) {
            res = mid;
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }
    return res;
}

void Main_work() {
    std::cin >> n;
    ll all = Query(1, n);
    if (all) {
        ll a = Find_low(1, n), c = Find_high(1, n);
        std::cout << "ans " << a << ' ' << (all ^ a ^ c) << ' ' << c << std::endl;
    } else {
        for (ll i = 63; i >= 0; --i) {
            if ((1ll << i) - 1 > n) continue;
            ll a = Query(1, (1ll << i) - 1);
            if (a) {
                ll c = Find_high(a + 1, n);
                std::cout << "ans " << a << ' ' << (all ^ a ^ c) << ' ' << c << std::endl;
                return;
            }
        }
    }
}

void init() {}

signed main() {
    // std::ios::sync_with_stdio(false);
    // std::cin.tie(0), std::cout.tie(0);
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