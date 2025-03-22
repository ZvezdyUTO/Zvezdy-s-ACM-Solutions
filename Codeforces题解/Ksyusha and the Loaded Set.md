# Ksyusha and the Loaded Set

所有者: Zvezdy
标签: 二分答案, 线段树
创建时间: 2024年10月3日 16:02

要是我们可以维护一个支持修改的数据结构，每次查询区间都可以找到区间中两个数相隔最远的距离的话，就可以使用二分答案来找最左边的合法位置。看到数据范围，发现可以用数大小来打线段树，一开始所有位置都是0，然后有数字存在的位置就设为1，求一个区间里面最长的连续0的个数就好。考虑如何合并两个区间，我们维护每个区间左边0的个数和右边0的个数，这样两个区间拼接的时候就可以靠这个来维护最长连续0的长度，同时特判一下一个区间中没有1出现，如果没有1出现就可以完全合并。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl
#define int long long
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int INF = 1e18;

struct Info {
    int l = 1, r = 1, len = 1, full = 1;
};
Info operator+(Info a, Info b) {
    Info c;
    c.full = a.full & b.full;

    c.l = a.l;
    if (a.full) {
        c.l += b.l;
    }

    c.r = b.r;
    if (b.full) {
        c.r += a.r;
    }

    c.len = max({c.l, c.r, a.r + b.l, a.len, b.len});
    return c;
}

struct SegmentTree {
    const int n;
    vector<Info> info;
    SegmentTree(int n) : n(n), info(4 << __lg(n)) {
        auto build = [&](auto& self, int p, int l, int r) {
            if (r - l == 1) {
                info[p] = Info();
                return;
            }
            int m = l + (r - l) / 2;
            self(self, p << 1, l, m);
            self(self, p << 1 | 1, m, r);
            pull(p);
        };
        build(build, 1, 0, n);
    }
    void pull(int p) {
        info[p] = info[p << 1] + info[p << 1 | 1];
    }

    void modify(int p, int l, int r, int x, const Info& v) {
        if (r - l == 1) {
            info[p] = v;
            return;
        }
        int m = l + (r - l) / 2;
        if (x < m) {
            modify(p << 1, l, m, x, v);
        } else {
            modify(p << 1 | 1, m, r, x, v);
        }
        pull(p);
    }
    void modify(int x, const Info& v) {
        modify(1, 0, n, x, v);
    }

    Info rangeQuery(int p, int l, int r, int x, int y) {
        if (l >= y || r <= x) {
            return {0, 0, 0, 0};
        }
        if (l >= x && r <= y) {
            return info[p];
        }
        int m = l + (r - l) / 2;
        return rangeQuery(p << 1, l, m, x, y) + rangeQuery(p << 1 | 1, m, r, x, y);
    }
    Info rangeQuery(int l, int r) {
        return rangeQuery(1, 0, n, l, r);
    }
};

const int N = 4e6 + 10;
SegmentTree st(N + 10);

void solve() {
    int n;
    cin >> n;
    vector<int> a(n + 1);
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
        st.modify(a[i], {0, 0, 0, 0});
    }

    int q;
    cin >> q;
    while (q--) {
        char op;
        int x;
        cin >> op >> x;
        if (op == '+') {
            st.modify(x, {0, 0, 0, 0});
            a.push_back(x);
        } else if (op == '-') {
            st.modify(x, {1, 1, 1, 1});
        } else {
            int l = 1, r = N;
            while (l <= r) {
                int mid = l + (r - l) / 2;
                if (st.rangeQuery(1, mid).len >= x) {
                    r = mid - 1;
                } else {
                    l = mid + 1;
                }
            }
            cout << l - x << " ";
        }
    }
    cout << endl;

    for (auto i : a) {
        st.modify(i, {1, 1, 1, 1});
    }
}

void init() {
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```