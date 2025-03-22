# Toss a Coin to Your Graph...

所有者: Zvezdy
标签: 二分答案, 图论, 拓扑排序
创建时间: 2025年3月5日 17:17

赛时就看出来是二分答案+判断是否存在合法道路了，不过写成了一坨屎，最优写法如下：

在原写法中，我计划只要目标点大于我们限制值，就不能走，然后用很奇怪的方式判环。实际上有向图中找最多边路+判环都是可以用拓扑排序实现的操作。我们使用二分答案，意味着只要在check中我们的操作是线性级别的，那无论怎样叠加都只是常数，所以完全可以在验证的时候重新建一遍图，只有两个顶点值都在我们当前验证下合法才建图。建图完成以后再跑拓扑排序就行，复杂度完全过关。

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
int n, m, k;

int arr[N];
std::array<std::array<int, 2>, N> save;

bool check(int goal) {
    std::vector<std::vector<int>> edge(n + 1);
    std::vector<int> inp(n + 1, 0);

    for (int i = 1; i <= m; ++i) {
        auto [u, v] = save[i];
        if (arr[u] <= goal && arr[v] <= goal) {
            edge[u].push_back(v);
            ++inp[v];
        }
    }

    std::vector<bool> vis(n + 1);
    std::queue<int> que;
    std::vector<int> maxdist(n + 1, 0);

    for (int i = 1; i <= n; ++i) {
        if (inp[i] == 0 && arr[i] <= goal) {
            que.push(i);
            vis[i] = true;
            maxdist[i] = 1;
        }
    }

    while (que.size()) {
        int now = que.front();
        vis[now] = true;
        que.pop();

        for (auto to : edge[now]) {
            maxdist[to] = std::max(maxdist[to], maxdist[now] + 1);
            if (--inp[to] == 0) que.push(to);
        }
    }

    for (int i = 1; i <= n; ++i) {
        if (!vis[i] && arr[i] <= goal) return true;
    }
    for (int i = 1; i <= n; ++i) {
        if (maxdist[i] >= k) return true;
    }
    return false;
}

void Main_work() {
    std::cin >> n >> m >> k;
    for (int i = 1; i <= n; ++i) std::cin >> arr[i];
    for (int i = 1; i <= m; ++i) std::cin >> save[i][0] >> save[i][1];

    int l = 1, r = 1e9;
    int ans = -1;
    while (l <= r) {
        int mid = (l + r) / 2ll;
        if (check(mid)) {
            ans = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
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