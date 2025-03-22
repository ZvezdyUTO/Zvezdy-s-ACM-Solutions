# Alice's Adventures in the Rabbit Hole

所有者: Zvezdy
标签: 树形DP, 概率论
创建时间: 2024年11月19日 12:50

从base case讨论起：假如只有一条链，那么我们设链长为d，有d+1个点，我们可以列出p(i)=1/2 (p(i+1)+p(i-1))，显然是线性递归方程组，通解为p(i)=a*i+b，代入p(1)=1和p(d+1)=0可以解得p(i)=1-(i-1)/d。

现在来看皇后和爱丽丝的策略，爱丽丝肯定是一直往根节点跑，而皇后则是把爱丽丝往目前最浅的叶子拽。对于题目中给出的树，我们可以把这棵树拆分为一条从根到最浅叶节点的树和若干子树，然后对于子树仍是这么拆分，最后我们发现无论身在何处，都有一条固定的路线，只不过在交叉处皇后不会把爱丽丝往之前那个不优的节点拽，但是大体上我们依然可以把这个过程看作是在链上进行，所以我们需要把前面我们推导出的公式改为只依赖父节点概率和目前位置离最浅叶节点距离的的递推式。设方程为k*p(fa)=p(now)，代入之前的公式解得p(now)=deep(now)/(deep(now)+1)=p(fa)，其中deep是由原来链条长度和节点位置转换为节点到叶子深度得来的。

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

const int N = 2e5 + 5;
const int MODE = 998244353;
int n;

inline ll inv(ll base) {
    int tmp = MODE - 2;
    ll res = 1;
    while (tmp) {
        if (tmp % 2) {
            res = (res * base) % MODE;
        }
        base = (base * base) % MODE;
        tmp /= 2;
    }
    return res;
}

std::array<std::vector<int>, N> edge;

std::array<ll, N> deep;

int prework(int now, int par) {
    int res = 0x7fffffff;
    for (auto to : edge[now]) {
        if (to != par) {
            res = std::min(res, prework(to, now));
        }
    }
    if (res > n) res = 0;
    deep[now] = res;
    return res + 1;
}

std::array<ll, N> p;

void dp(int now, int par) {
    p[now] = p[par] * deep[now] % MODE * inv(deep[now] + 1ll) % MODE;
    for (auto to : edge[now]) {
        if (to != par) {
            dp(to, now);
        }
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        edge[i].clear();
    }
    for (int i = 1, u, v; i < n; ++i) {
        std::cin >> u >> v;
        edge[u].push_back(v);
        edge[v].push_back(u);
    }
    prework(1, 0);
    p[1] = 1;
    for (auto start : edge[1]) {
        dp(start, 1);
    }
    for (int i = 1; i <= n; ++i) {
        std::cout << p[i] << ' ';
    }
    std::cout << '\n';
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