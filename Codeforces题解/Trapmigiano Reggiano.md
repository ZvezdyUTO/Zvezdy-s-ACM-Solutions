# Trapmigiano Reggiano

所有者: Zvezdy
标签: 图论, 思维, 拓扑排序
创建时间: 2025年3月2日 17:49

分析它的步骤可发现，有两种可能，如果目标在原位，那它不会动，如果目标在其它点，它一定会朝那个点的方向跑去。如果我们将终点悬挂起来，每次都从叶子结点向上勾引，那么最后目标一定在根节点处，因为根节点是严格的最后一位。实际上缩树的模型并非第一次见到，每次任选移除一个节点的操作是将节点向上逼一层，那么从外部开始删除一定能将节点聚集至根部。无论中间过程如何，只要认定基础操作这一事实，结果就一定是固定的。这不属于先预定后决策的过程，而是先有结果后决策。

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
    int n, st, en;
    std::cin >> n >> st >> en;
    std::vector<std::vector<int>> edge(n + 1);
    for (int i = 2, u, v; i <= n; ++i) {
        std::cin >> u >> v;
        edge[u].push_back(v);
        edge[v].push_back(u);
    }

    std::vector<int> cnt(n + 1, 0);
    auto dfs = [&](auto&& self, int now, int par) -> void {
        for (auto to : edge[now]) {
            if (to == par) continue;
            ++cnt[now];
            self(self, to, now);
        }
    };
    dfs(dfs, en, -1);

    std::vector<bool> vis(n + 1, false);
    std::vector<int> ans;
    std::queue<int> que;
    for (int i = 1; i <= n; ++i) {
        if (cnt[i] == 0) {
            que.push(i);
            vis[i] = true;
        }
    }

    while (que.size()) {
        int now = que.front();
        ans.push_back(now);
        que.pop();
        for (auto to : edge[now]) {
            if (--cnt[to] == 0 && !vis[to]) {
                vis[to] = true;
                que.push(to);
            }
        }
    }

    for (auto i : ans) {
        std::cout << i << ' ';
    }
    std::cout << '\n';
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
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```