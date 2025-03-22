# Sugar Sweet II

所有者: Zvezdy
标签: 图论, 概率论

敏锐地发现这么一个依赖关系：第i号小朋友可能依赖b[i]号的状态，这个情况发生在第i号小朋友只有在b[i]号小朋友拿到糖以后才能拿到糖，否则要么完全拿不到糖，要么必拿到糖，这两都为独立事件，题目说了所有事件按随机顺序全部发生，所以发生概率为100%。现在关键是计算那些依赖事件的期望，观察到每个小朋友都只依赖单独另一小朋友，那么这个关系就可以被抽象为一张图，从每个源点开始，后续事件的发生必须是前面事件按某种顺序被触发，所以这个事件发生的概率是全排列分之一，具体数量为源点到当前事件的距离。

所以求概率必须摸清楚的条件为，什么是独立时间，什么是依赖事件，依赖事件的依赖关系如何。然后才可以通过依赖关系求出概率以及数学期望。

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
#define debug(x) std::cout << #x << " = " << x << std::endl

const int N = 5e5;
const ll MODE = 1e9 + 7;

// 阶乘和逆元
std::array<ll, 2 * N + 1> ft;
inline ll Ie(ll num) {
    int p = MODE - 2;
    ll res = 1ll;
    ll pow = num;
    while (p) {
        if (p & 1) {
            res = res * pow % MODE;
        }
        pow = pow * pow % MODE;
        p >>= 1;
    }
    return res;
}

// 基础数据
std::array<ll, N + 1> a, b, w;
std::array<int, N + 1> dist;

struct Edge {
    int to, next;
};
int cnt = 0;
std::array<int, N + 5> head;
std::array<Edge, 2 * N + 5> edge;
void Add_edge(int from, int to) {
    edge[++cnt].to = to;
    edge[cnt].next = head[from];
    head[from] = cnt;
}

void solve() {
    int n;
    std::cin >> n;
    cnt = 0;
    std::fill(head.begin(), head.begin() + n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        std::cin >> a[i];
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> b[i];
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> w[i];
    }

    std::fill(dist.begin(), dist.begin() + n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        if (a[b[i]] > a[i]) {
            dist[i] = 1;  // 独立事件
        } else if (a[b[i]] + w[b[i]] > a[i]) {
            Add_edge(b[i], i);  // 依赖事件
        }
    }

    auto dfs = [&](auto&& self, int now) -> void {
        for (int i = head[now], to; i; i = edge[i].next) {
            to = edge[i].to;
            dist[to] = dist[now] + 1;
            self(self, to);
        }
    };
    for (int i = 1; i <= n; ++i) {
        if (dist[i] == 1) {
            dfs(dfs, i);
        }
    }

    for (int i = 1; i <= n; ++i) {
        if (dist[i] == 0) {
            std::cout << a[i] << " ";
        } else {
            ll cur = w[i] * Ie(ft[dist[i]]) % MODE;
            std::cout << (a[i] + cur) % MODE << " ";
        }
    }
    std::cout << '\n';
}

void init() {
    ft[0] = 1;
    for (int i = 1; i <= 2 * N; ++i) {
        ft[i] = (ll)(ft[i - 1] * i % MODE);
    }
}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    init();
    int Zvezdy = 1;
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```