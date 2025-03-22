# Subsequence Path

所有者: Zvezdy
标签: 动态规划

表面上是非常复杂的图论爆搜题，实际上进行转换以后就是一道动态规划题。我们可以设f[i]是从1号点走到i号点的最短距离。既然题目说了，我们走的路必须是操作序列的子序列，那我们完全可以按照操作序列挨个进行操作。遍历操作序列的时候我们就走走它目前这一步，看看能不能走到新地方或者带来更短的路径，直到执行完操作路径。

这里的思维处在于，我们需要按照操作序列进行模拟，但我们能够舍弃掉其中的一些路径，那我们就可以把所有的结果都打印出来，因为操作序列很少，这个想法是可以被实现的，只要模拟完操作序列就能拿到最优的答案。

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

std::array<std::array<int, 3>, N> edge;

int e[N];

int f[N];

void Main_work() {
    std::cin >> n >> m >> k;
    for (int i = 1; i <= m; ++i) {
        std::cin >> edge[i][0] >> edge[i][1] >> edge[i][2];
    }
    for (int i = 1; i <= n; ++i) {
        f[i] = 1e15;
    }
    f[1] = 0;
    for (int i = 1; i <= k; ++i) {
        int v;
        std::cin >> v;
        f[edge[v][1]] = std::min(f[edge[v][1]], f[edge[v][0]] + edge[v][2]);
    }
    if (f[n] != 1e15) {
        std::cout << f[n] << '\n';
    } else {
        std::cout << -1 << '\n';
    }
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