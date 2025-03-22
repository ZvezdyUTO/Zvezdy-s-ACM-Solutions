# COT2 - Count on a tree II

所有者: Zvezdy
标签: 树链剖分, 莫队

树上莫队，在使用树上莫队之前，我们需要将树转为链式结构，这就需要使用欧拉序进行树链剖分。在记录欧拉序的同时，也记录每个节点第一次被访问到和最后一次被访问到的时间戳，有助于我们划分线性操作范围。同时树链剖分需要我们筛选轻重链，在这题中该操作会被用于求解LCA，记录这些链的规则是：对于每个节点，选择其最大子树作为重链节点，记录在son数组中，就像father数组那样，这样当我们求解lca的时候，就可以通过深度数组，不断让深的节点一层层跳上去，直到两个节点的链头汇合，取较浅节点为lca.

化树为链以后，我们就可以使用分块排序来对操作进行离线，树上莫队块的大小取sqrt(2*n)，按照欧拉序来进行排列，因为我们的区间挪动操作也是在欧拉序数组上进行的。注意特判两个节点的位置情况，欧拉序里面有节点第一次出现位置和第二次出现位置，我们需要按照节点在欧拉序左右以及出现分批出现位置情况来划分我们的工作区间。如果两个节点并不为上下关系，那么我们所选区间中是不存在它们lca的，要人为补上，然后在查询完成后删去。

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
using ll = long long;
#define debug(x) std::cout << #x << " = " << x << endl

const int N = 1e5 + 5;

int n, q;

std::array<int, N> node;
std::array<int, N> rank;
void discretization() {
    for (int i = 1; i <= n; ++i) {
        rank[i] = node[i];
    }
    std::sort(rank.begin() + 1, rank.begin() + n + 1);
    int m = std::unique(rank.begin() + 1, rank.begin() + n + 1) - rank.begin() - 1;
    for (int i = 1; i <= n; ++i) {
        node[i] = std::lower_bound(rank.begin() + 1, rank.begin() + m + 1, node[i]) - rank.begin();
    }
}

std::array<std::vector<int>, N> edge;

int euler_cnt = 0;
std::array<int, N> start, end;
std::array<int, 2 * N> ord;
std::array<int, N> deep, size;
std::array<int, N> father, son;
void dfs1(int now, int par) {
    size[now] = 1;
    father[now] = par;
    deep[now] = deep[par] + 1;

    start[now] = ++euler_cnt;
    ord[euler_cnt] = now;
    for (auto to : edge[now]) {
        if (to != par) {
            dfs1(to, now);
            size[now] += size[to];
            if (size[to] > size[son[now]]) {
                son[now] = to;
            }
        }
    }
    end[now] = ++euler_cnt;
    ord[euler_cnt] = now;
}

std::array<int, N> top;
void dfs2(int now, int cur_top) {
    top[now] = cur_top;
    if (son[now]) {
        dfs2(son[now], cur_top);
    }
    for (auto to : edge[now]) {
        if (to != son[now] && to != father[now]) {
            dfs2(to, to);
        }
    }
}

void TCD() {
    dfs1(1, 0);
    dfs2(1, 1);
}

int get_lca(int x, int y) {
    while (top[x] != top[y]) {
        if (deep[top[x]] < deep[top[y]]) {
            std::swap(x, y);
        }
        x = father[top[x]];
    }
    if (deep[x] > deep[y]) {
        std::swap(x, y);
    }
    return x;
}

struct Query {
    int id, lca;
    int l, r;
    int left, right;
};
std::array<Query, N> query;
int block;
void MO() {
    block = sqrt(2 * n);
    for (int i = 1, x, y; i <= q; ++i) {
        std::cin >> x >> y;
        if (start[x] > start[y]) {
            std::swap(x, y);
        }
        query[i].id = i;
        query[i].lca = get_lca(x, y);
        if (query[i].lca == x) {
            query[i].l = start[x];
            query[i].r = start[y];
            query[i].left = start[x] / block;
            query[i].right = start[y] / block;
            query[i].lca = 0;
        } else {
            query[i].l = end[x];
            query[i].r = start[y];
            query[i].left = end[x] / block;
            query[i].right = start[y] / block;
        }
    }
    std::sort(query.begin() + 1, query.begin() + q + 1, [&](Query x, Query y) {
        if (x.left != y.left) {
            return x.left < y.left;
        } else {
            if (x.left % 2) {
                return x.r < y.r;
            } else {
                return x.r > y.r;
            }
        }
    });
}

int l = 1, r = 0, sum = 0;
std::array<int, N> freq;

void add(int loca) {
    sum += (++freq[node[loca]] == 1);
}
void del(int loca) {
    sum -= (--freq[node[loca]] == 0);
}

std::array<bool, N> use;
void calc(int x) {
    (!use[x]) ? add(x) : del(x);
    use[x] ^= 1;
}

std::array<int, N> ans;
void culculate(int x, int y, int lca, int id) {
    while (l > x)
        calc(ord[--l]);
    while (l < x)
        calc(ord[l++]);
    while (r < y)
        calc(ord[++r]);
    while (r > y)
        calc(ord[r--]);
    if (lca)
        calc(lca);
    ans[id] = sum;
    if (lca)
        calc(lca);
}

void solve() {
    std::cin >> n >> q;
    for (int i = 1; i <= n; ++i) {
        std::cin >> node[i];
    }
    for (int i = 1, u, v; i < n; ++i) {
        std::cin >> u >> v;
        edge[u].push_back(v);
        edge[v].push_back(u);
    }

    discretization();
    TCD();
    MO();
    for (int i = 1; i <= q; ++i) {
        culculate(query[i].l, query[i].r, query[i].lca, query[i].id);
    }
    for (int i = 1; i <= q; ++i) {
        std::cout << ans[i] << '\n';
    }
}

void init() {}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    init();
    int Zvezdy = 1;
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```