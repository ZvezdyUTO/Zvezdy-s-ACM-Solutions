# Resourceful Caterpillar Sequence

所有者: Zvezdy
标签: 图论, 数学
创建时间: 2025年3月13日 14:50

一如既往地从博弈论策略上来看，优先观察必败情况，有两种可能，一种是一开始就有一个头在叶子节点，而另一个头不在叶子节点。另一种情况是，在先手被迫走了一步以后，后手可以一步走到叶子处，否则两个人就会来回扯皮，无法结束。

对于计数题，找到一个合适的计数方法会让解法变得特别简单。考虑目前的情况，我们需要让p处于一个可以被拉到周围有叶子节点的点上，对这种拉扯的题目，只要拉扯的另一头不在我们p的子树内，就一定可以把p拉出它自己的子树到我们所需的节点中，直接一个个求似乎有一点麻烦，我们所需要排除掉的就只是每个p节点所对应的子树点，将它们所有情况的总数合并起来以后就可以发现，它们的和刚好等于所有不能一步走到有相邻叶子节点的节点数，所以可以快速打出公式求解。

对于树上拉扯的题目，只要拉扯点不在当前点的子树内，就可以把当前点往外拉，同时对于计数题，把难以求解的散部分进行公式整合，就有可能变成极好求解的公式。因此将公式抽象出来进行整合还是非常有必要的，把我们手头的条件列出来进行组合就会有新的收获。

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
    int n;
    std::cin >> n;
    std::vector<std::vector<int>> edge(n + 1);
    for (int i = 1, u, v; i < n; ++i) {
        std::cin >> u >> v;
        edge[u].push_back(v);
        edge[v].push_back(u);
    }

    int leaf_cnt = 0;
    std::vector<int> deg(n + 1);
    std::vector<bool> leaf(n + 1, false);
    for (int i = 1; i <= n; ++i) {
        deg[i] = edge[i].size();
        if (deg[i] == 1) {
            leaf[i] = true;
            ++leaf_cnt;
        }
    }

    int ans = (n - leaf_cnt) * leaf_cnt;

    int stic_cnt = 0;
    std::vector<int> s(n + 1, 0);
    std::vector<bool> stic(n + 1, false);

    for (int i = 1; i <= n; ++i) {
        if (deg[i] > 1) {
            for (auto j : edge[i]) s[i] += deg[j] > 1;
            if (s[i] == deg[i]) {
                ++stic_cnt;
            } else {
                stic[i] = true;
            }
        }
    }

    for (int i = 1; i <= n; ++i) {
        if (deg[i] > 1 && stic[i]) ans += stic_cnt * (s[i] - 1);
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
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```