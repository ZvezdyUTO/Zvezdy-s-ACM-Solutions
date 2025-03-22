# Permute K times 2

所有者: Zvezdy
标签: 图论

跳转的问题，每个点都有一个自己的起点，还有自己的固定终点，那么就可以看作是一张图，而每次所谓的跳转就是沿着图往下跑，可以看作图在流动。这里还有一个trick就是，因为我们每个点都会发生这样子的“流动”，所以我们跳转实际上是每个点都自己在最初始的那张图上跳了2^(k-1)步。

n点n边，一定存在环，我们对每个点进行跳跃的时候都可以把这个点的整个环处理出来，然后使用快速幂和取模来找到它的终点。

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
#define debug(x) std::cout << #x << " = " << x << std::endl

const int N = 2e5 + 5;
int n;
ll k;

std::array<int, N> arr;
std::array<int, N> ans;
std::array<bool, N> vis;

ll qmi(ll num, ll mod) {
    ll multi = 2ll;
    ll res = 1;
    while (num) {
        if (num % 2) {
            res = res * multi % mod;
        }
        multi = multi * multi % mod;
        num /= 2;
    }
    return res;
}

void Main_work() {
    std::cin >> n >> k;
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
        --arr[i];
    }
    for (int i = 0; i < n; ++i) {
        if (!vis[i]) {
            std::vector<int> cycle;
            for (int j = i; !vis[j]; j = arr[j]) {
                vis[j] = true;
                cycle.push_back(j);
            }
            int len = cycle.size();
            int shift = qmi(k, len);
            for (int j = 0; j < len; ++j) {
                ans[cycle[j]] = cycle[(j + shift) % len];
            }
        }
    }
    for (int i = 0; i < n; ++i) {
        std::cout << ans[i] + 1 << ' ';
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
        Main_work();
    }
    return 0;
}
```