# P2986 [USACO10MAR] Great Cow Gathering G

所有者: Zvezdy
标签: 树的重心

树重心模板题，已知树的重心有如下性质：

1. 所有节点走向重心，所经过的边最少。
2. 以重心为根，最大子树点权和不超过总点权和的一半，并且最大子树的节点最小

一棵树最多有两个中心，如果有两个重心那么它们一定相邻。如果在树上删除或者增加一个叶节点，那么转以后重心最多只移动一条边。如果把两棵树连起来，那么新的重心一定在这两个重心的简单路上。假如边权全为正，那么不管边权怎么分布，所有节点走向重心的总距离最小。

在这题中更可以发现，不带点权的树求重心，我们只需要把每个点点权默认设为1，带点权的树求重心就是找最大子树的点权最小，记得找的时候要排除根的影响。

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
#define int long long
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>

const int N = 1e5;
array<int, N + 1> node;
array<int, N + 1> len;

struct Edge {
    int to, next, dis;
};
int cnt = 0;
array<int, N + 1> head;
array<Edge, 2 * N + 1> edge;
void Add_edge(int from, int to, int dis) {
    edge[++cnt].to = to;
    edge[cnt].next = head[from];
    edge[cnt].dis = dis;
    head[from] = cnt;
}

void solve() {
    int n, sum = 0;
    cin >> n;
    for (int i = 1; i <= n; ++i) {
        cin >> node[i];
        sum += node[i];
    }
    for (int i = 1, u, v, w; i < n; ++i) {
        cin >> u >> v >> w;
        Add_edge(u, v, w);
        Add_edge(v, u, w);
    }

    int bc;
    int minn = 1e15;
    auto f = [&](auto& self, int now, int par) -> int {
        int subsize = node[now];
        int maxsize = 0;
        for (int i = head[now]; i; i = edge[i].next) {
            int to = edge[i].to;
            if (to != par) {
                int nextsize = self(self, to, now);
                maxsize = max(maxsize, nextsize);
                subsize += nextsize;
            }
        }
        if (max(maxsize, sum - subsize) < minn) {
            bc = now;
            minn = max(maxsize, sum - subsize);
        }
        return subsize;
    };
    f(f, 1, -1);

    int ans = 0;
    auto dfs = [&](auto& self, int now, int par, int dis) -> void {
        ans += dis * node[now];
        for (int i = head[now]; i; i = edge[i].next) {
            int to = edge[i].to;
            if (to != par) {
                self(self, to, now, dis + edge[i].dis);
            }
        }
    };
    dfs(dfs, bc, -1, 0);
    cout << ans << endl;
}

void init() {
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    init();
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```