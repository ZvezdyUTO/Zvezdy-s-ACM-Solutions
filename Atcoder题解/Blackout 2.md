# Blackout 2

所有者: Zvezdy
标签: 并查集, 思维

如果这题是在严格加边的话，直接拿并查集就能简单维护。不过它永远在删除边，进一步观察又发现它做的事情就只是删除边。所以我们完全可以逆向操作一波，把它删除的边都先不加上，然后逆序按询问将边一条一条地加上。这种策略也是正难则反的一种体现。有时将操作逆向考虑就能得到很简单的结果。

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
    int n, m, e, q;
    std::cin >> n >> m >> e;
    std::vector<std::array<int, 2>> edges(e);
    for (int i = 0; i < e; ++i) std::cin >> edges[i][0] >> edges[i][1];

    std::cin >> q;
    std::vector<int> query(q);
    std::vector<bool> del(e, false);
    for (int i = 0; i < q; ++i) {
        std::cin >> query[i];
        --query[i];
        del[query[i]] = true;
    }

    std::vector<int> dsu(n + m + 1), size(n + m + 1, 1);
    std::iota(dsu.begin(), dsu.end(), 0);

    auto find = [&](int x) {
        while (dsu[x] != x) x = dsu[x] = dsu[dsu[x]];
        return x;
    };

    auto merge = [&](int i, int j) {
        i = find(i), j = find(j);
        if (i == j) return;
        if (i > j) std::swap(i, j);
        dsu[i] = j;
        size[j] += size[i];
    };

    for (int i = 0; i < e; ++i) {
        if (del[i]) continue;
        merge(edges[i][0], edges[i][1]);
    }
    int cur = 0;
    for (int i = 1; i <= n; ++i) cur += find(i) > n;

    std::vector<int> ans(q);
    for (int i = q - 1; i >= 0; --i) {
        ans[i] = cur;
        auto [u, v] = edges[query[i]];
        if (find(u) > n && find(v) <= n) {
            cur += size[find(v)];
        } else if (find(u) <= n && find(v) > n) {
            cur += size[find(u)];
        }
        merge(u, v);
    }

    for (int i = 0; i < q; ++i) std::cout << ans[i] << '\n';
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