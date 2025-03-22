# Gifts Order

所有者: Zvezdy
标签: 线段树
创建时间: 2025年1月5日 16:39

依旧是先观察题目中给出的计算公式：区间中最大值-最小值-区间长度。如果最大值和最小值确定，那么区间长度肯定是越短越好，所以可以肯定的是最大值最小值一定在两端。此时分类讨论可以写出两个公式：arr[r]-arr[l]-(r-l)或者arr[l]-arr[r]-(r-l)，尽量把式子化成相同元素在相同位置的情况：(arr[r]-r)-(arr[l]-l)和(arr[l]+l)-(arr[r]+r)，本质上就是维护arr[i]-i和arr[i]+i的最大值和最小值。但是需要注意左大右小和左小右大的限制，所以在区间合并的时候维护这个限制。

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

struct Info {
    ll min1, min2, max1, max2, ans1, ans2;
    Info() : min1(1e15), max1(-1e15), min2(1e15), max2(-1e15), ans1(0), ans2(0) {};
    Info(std::array<ll, 2> inp) {
        min1 = max1 = inp[0];
        min2 = max2 = inp[1];
        ans1 = ans2 = 0;
    }
};
Info operator+(Info a, Info b) {
    Info res;
    res.min1 = std::min(a.min1, b.min1);
    res.min2 = std::min(a.min2, b.min2);
    res.max1 = std::max(a.max1, b.max1);
    res.max2 = std::max(a.max2, b.max2);
    res.ans1 = std::max({a.ans1, b.ans1, b.max1 - a.min1});
    res.ans2 = std::max({a.ans2, b.ans2, a.max2 - b.min2});
    return res;
}

struct SegTree {
    int n;
    std::vector<Info> info;
    SegTree(int n) : n(n), info(4 << std::__lg(n)) {}
    SegTree(std::vector<ll>& input) : SegTree(input.size()) {
        auto build = [&](auto&& self, int p, int l, int r) {
            if (l + 1 == r) {
                info[p] = Info({input[l] - l, input[l] + l});
                return;
            }
            int mid = (l + r) / 2;
            self(self, 2 * p, l, mid);
            self(self, 2 * p + 1, mid, r);
            pull(p);
        };
        build(build, 1, 0, n);
    }

    void pull(int p) {
        info[p] = info[2 * p] + info[2 * p + 1];
    }

    void modify(int p, int l, int r, int pos, ll neww) {
        if (l + 1 == r) {
            info[p] = Info({neww - pos, neww + pos});
            return;
        }
        int mid = (l + r) / 2;
        if (pos < mid) {
            modify(2 * p, l, mid, pos, neww);
        } else {
            modify(2 * p + 1, mid, r, pos, neww);
        }
        pull(p);
    }

    ll check() {
        return std::max(info[1].ans1, info[1].ans2);
    }
};

void Main_work() {
    int n, q;
    std::cin >> n >> q;
    std::vector<ll> arr(n);
    for (auto& i : arr) {
        std::cin >> i;
    }
    SegTree segTree(arr);
    std::cout << segTree.check() << '\n';
    while (q--) {
        int pos;
        ll chk;
        std::cin >> pos >> chk;
        segTree.modify(1, 0, n, pos - 1, chk);
        arr[pos - 1] = chk;
        std::cout << segTree.check() << '\n';
    }
}

void init() {}

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