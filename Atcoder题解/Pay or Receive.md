# Pay or Receive

所有者: Zvezdy
标签: dfs, 图论

看起来是一个最长路和判负环，但是仔细一想会发现，因为我们正负路是刚好反过来的，所以如果我们沿着负环反方向跑，那么负环就变成正环了，所以一般来说只要有环存在，就是正环，或者零环。如果是零环的话，就可以认为没有环，而有正环就一定走得出inf，所以我们有效的图就可以约等于一棵树，求一棵有向树上两个点之间的距离就是随便从根开始，拿终点到根的距离减去起点到根的距离，哪个是根无所谓。

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

const int N = 1e5 + 5;
int n, m, q;

std::array<std::vector<std::array<int, 2>>, N> edge;

int col[N], colour;
bool is_nf[N], vis[N];
ll dist[N];

// 如果存在负环、那么就一定存在正环
// 如果存在零环=没有环=树，那么所有路都是简单路长度
void dfs(int now) {
    col[now] = colour;
    vis[now] = true;
    for (auto [dis, to] : edge[now]) {
        if (!vis[to]) {
            dist[to] = dist[now] + dis;
            dfs(to);
        } else if (dist[to] != dist[now] + dis) {
            is_nf[colour] = true;
        }
    }
}

void Main_work() {
    std::cin >> n >> m >> q;
    for (int i = 1, u, v, w; i <= m; ++i) {
        std::cin >> u >> v >> w;
        edge[u].push_back({w, v});
        edge[v].push_back({-w, u});
    }
    for (int i = 1; i <= n; ++i) {
        if (!vis[i]) {
            ++colour;
            dfs(i);
        }
    }
    while (q--) {
        int a, b;
        std::cin >> a >> b;
        if (col[a] != col[b]) {
            std::cout << "nan\n";
        } else if (is_nf[col[a]]) {
            std::cout << "inf\n";
        } else {
            std::cout << dist[b] - dist[a] << '\n';
        }
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```