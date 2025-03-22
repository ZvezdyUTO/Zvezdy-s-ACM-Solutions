# Cool Graph

所有者: Zvezdy
标签: 图论, 思维
创建时间: 2024年11月15日 10:16

经过分析之后发现，如果我们选择对所有度大于等于2的点做一遍操作，那么我们场上所有点的度就会小于2，现在我们剩下的就是点和线，再把点和线串为一棵树就结束了。

先看最开始的分割操作，当我们添加边的时候，因为我们所有点的度要么为1要么为0，所以我们存边应该是用一个数组，然后我们如果发现这两个点连边时如果有其他点还与之链接，那么这个点的度一定大于2，对这三个点执行删除操作。可以保证我们所有的操作下来，点的度不会大于1。然后就是链接操作了如果是线的话，我们选择一条线的一个端点，让它和所有线进行连接，然后选择线的另一个端点，让它和所有的点进行挨个连接，每次连接我们就换另一个点作为媒介。

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

const int N = 3e5 + 5;
int n, m;

std::array<int, N> to;
std::vector<std::array<int, 3>> ans;

// 添加边，同时保证所有点的度小于2
void add(int u, int v) {
    if (to[u] == v) {
        to[u] = -1;
        to[v] = -1;
        return;
    }
    if (to[u] != -1) {
        int w = to[u];
        ans.push_back({u, v, w});
        to[u] = -1, to[w] = -1;
        add(v, w);
        return;
    }
    if (to[v] != -1) {
        int w = to[v];
        ans.push_back({u, v, w});
        to[v] = -1, to[w] = -1;
        add(u, w);
        return;
    }
    to[u] = v;
    to[v] = u;
}

std::vector<std::array<int, 2>> p;

inline void solve() {
    p.clear();
    for (int i = 1; i <= n; ++i) {
        if (to[i] > i) {
            p.push_back({i, to[i]});
        }
    }
    if (p.size()) {
        // 现在场上只剩下度小于2的边
        auto [a, b] = p[0];
        // 处理度为2的边
        for (int i = 1; i < p.size(); ++i) {
            auto [u, v] = p[i];
            ans.push_back({a, u, v});
        }
        // 处理度为1的边
        for (int i = 1; i <= n; ++i) {
            if (to[i] == -1) {
                ans.push_back({a, b, i});
                b = i;
            }
        }
    }
}

void Main_work() {
    std::cin >> n >> m;
    std::fill(to.begin() + 1, to.begin() + n + 1, -1);
    ans.clear();
    for (int i = 1, u, v; i <= m; ++i) {
        std::cin >> u >> v;
        add(u, v);
    }
    solve();
    std::cout << ans.size() << '\n';
    for (auto [a, b, c] : ans) {
        std::cout << a << ' ' << b << ' ' << c << '\n';
    }
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