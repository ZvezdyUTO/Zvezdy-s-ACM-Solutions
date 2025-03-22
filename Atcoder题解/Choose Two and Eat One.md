# Choose Two and Eat One

所有者: Zvezdy
标签: 克鲁苏卡尔, 思维

看题目的操作，抽两个元素出来，然后记录它们组合的分数，有一种建边的感觉，随后删除其中一个元素，有一种缩点的既视感。它一直这么做直到只剩下一个元素，其实就是在把一棵树从叶子往根收集，而我们所能拿到的分数就是这棵树的边权之和。于是我们建出n*n条边并且使用克鲁苏卡尔来跑一棵最大生成树然后计算边权就好。

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

const int N = 5e2 + 5;
int n, MODE;

int arr[N];

ll qmi(int num, int pow) {
    ll res = 1;
    ll multi = num;
    while (pow) {
        if ((pow & 1)) {
            res = res * multi % MODE;
        }
        multi = multi * multi % MODE;
        pow >>= 1;
    }
    return res;
}

std::array<std::array<ll, 3>, N * N> edges;

inline void Get_edges() {
    int cnt = 1;
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= n; ++j) {
            edges[cnt] = {0, i, j};
            if (i != j) {
                edges[cnt][0] = (qmi(arr[i], arr[j]) + qmi(arr[j], arr[i])) % MODE;
                // debug(edges[cnt][0]);
            }
            ++cnt;
        }
    }
}

int dsu[N];

int find(int x) {
    while (x != dsu[x]) {
        x = dsu[x] = dsu[dsu[x]];
    }
    return x;
}

bool is_same(int x, int y) {
    return find(x) == find(y);
}

void merge(int x, int y) {
    x = find(x);
    y = find(y);
    dsu[y] = x;
}

inline ll Krusukar() {
    std::iota(dsu + 1, dsu + n + 1, 1);
    std::sort(edges.begin() + 1, edges.begin() + n * n + 1, std::greater<std::array<ll, 3>>());
    ll ans = 0;
    for (int i = 1; i <= n * n; ++i) {
        if (!is_same(edges[i][1], edges[i][2])) {
            ans += edges[i][0];
            merge(edges[i][1], edges[i][2]);
        }
    }
    return ans;
}

void Main_work() {
    std::cin >> n >> MODE;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    Get_edges();
    std::cout << Krusukar();
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