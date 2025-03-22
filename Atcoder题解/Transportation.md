# Transportation

所有者: Zvezdy
标签: 分层图, 最小生成树

很明显的分层图，题目给出的条件是两个都有港口或者机场就能连接，对于这种类似传送门的东西，我们就分别额外建一个超级源点与之相连。实际上对于分层图或者多源点的图论问题，建立虚点是非常有帮助的。接下来自然是传统的最小生成树，按边来排序并且使用并查集进行判断。不过对于这个方法有一个关键的漏洞：我们可能没必要使用机场或者港口，但是我们在使用并查集的时候可能还是会与那两个虚点相连，由于题目只有两种特殊情况，所以我们只需要分别求有无机场、港口的四种情况，再取最小即可。注意每次求完以后验证当前图是否连通。

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

const int N = 2e5 + 5;
int n, m;

int x[N], y[N];

std::array<std::array<int, 4>, 3 * N> edge;

int dsu[N];

int find(int x) {
    while (x != dsu[x]) {
        x = dsu[x] = dsu[dsu[x]];
    }
    return x;
}

bool check(int i, int j) {
    return find(i) == find(j);
}

void comb(int i, int j) {
    i = find(i);
    j = find(j);
    dsu[i] = j;
}

int kruskal(bool fly, bool boat) {
    int res = 0;
    std::iota(dsu, dsu + n + 3, 0);
    for (int i = 1; i <= 2 * n + m; ++i) {
        auto [cost, u, v, id] = edge[i];
        if (!fly && id == 1) continue;
        if (!boat && id == 2) continue;
        if (check(u, v)) continue;
        // debug(cost);
        res += cost;
        comb(u, v);
    }
    // std::cout << '\n';
    for (int i = 2; i <= n; ++i) {
        if (!check(1, i)) {
            return 1e15;
        }
    }
    return res;
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 1; i <= n; ++i) {
        std::cin >> x[i];
        edge[i] = {x[i], n + 1, i, 1};
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> y[i];
        edge[i + n] = {y[i], n + 2, i, 2};
    }
    for (int i = 1, u, v, w; i <= m; ++i) {
        std::cin >> u >> v >> w;
        edge[i + 2 * n] = {w, u, v, 0};
    }
    std::sort(edge.begin() + 1, edge.begin() + 2 * n + m + 1);

    int ans = 1e15;
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 2; ++j) {
            ans = std::min(ans, kruskal(i, j));
        }
    }
    std::cout << ans << '\n';
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