# Sums of Segments

所有者: Zvezdy
标签: 二分查找, 分块, 前缀和&差分, 数学
创建时间: 2024年11月28日 14:44

看起来是一个疯狂推式子并求解的题目，但如果我们使用上计算机里面解决问题的一些技巧，就会让问题得到有效的解决。

通过公式可以发现，这题实际上是一块一块元素的求和的组合，它的真实状态是一堆区间和通过奇怪的方式组合到了一起。对于区间和，我们可以使用一维坐标来分割他们，这样可以更直观地发现它们之间的联系。如果我们这么做了我们会发现实际上在大范围上，他是一个n, n-1, n-2, n-3, … , 1的许多小区间拼凑而成的组。此时我们抽出其中任意一个组进行研究发现，每个组中的单个元素是从组编号为左端点到该元素在组中的位置作为右端点的区间和。每往右一格，这个区间和就多往右延伸一个，那么我们就可以将这个看作是前缀和的前缀和。对于这种大范围的不带修区间和，我们都可以考虑使用一个完整的前缀和数组将它们剪切出来。比如在这个区间中，我们的左端点部分就可以用一层前缀和进行剪切。

另外我们还需要使用分治的思想来回答询问，我们发现在完整的一个块中处理元素非常方便，所以我们考虑像做分块一样按块处理。在寻找区间的时候可以拿二分查找来找。

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

const int N = 3e5 + 5;
int n, q;

std::array<ll, N> arr;

std::array<ll, N> prefix, prefix_2;
std::array<ll, N> start = {0};
std::array<ll, N> block, prefix_block;

ll sum_of_block(int id, int l, int r) {
    if (r <= l) return 0ll;
    int actn = r - l;
    ll head = prefix[id] * actn;
    ll sums = prefix_2[r + 1] - prefix_2[l + 1];
    return sums - head;  // 对后面每一个都要减掉前面的部分
}

inline void Prework() {
    for (int i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + arr[i];
    }
    for (int i = 0; i <= n; ++i) {
        prefix_2[i + 1] = prefix_2[i] + prefix[i];
    }

    for (int i = 1, j = n; j >= 1; ++i, --j) {
        start[i] = start[i - 1] + j;
    }

    for (int i = 0; i < n; ++i) {
        block[i] = sum_of_block(i, i, n);
    }
    for (int i = 0; i < n; ++i) {
        prefix_block[i + 1] = prefix_block[i] + block[i];
    }
}

std::array<ll, 2> convert(ll i) {
    int index = std::upper_bound(start.begin(), start.begin() + 1 + n, i) - start.begin() - 1;
    return {index, i - start[index] + index};
}

inline ll Query() {
    ll l, r;
    std::cin >> l >> r;
    --l, --r;
    auto [l_x, l_y] = convert(l);
    auto [r_x, r_y] = convert(r);
    ll res = prefix_block[r_x + 1] - prefix_block[l_x];
    if (l_y != l_x) {
        res -= sum_of_block(l_x, l_x, l_y);
    }
    if (r_y != n - 1) {
        res -= sum_of_block(r_x, r_y + 1, n);
    }
    return res;
}

void Main_work() {
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    Prework();
    std::cin >> q;
    while (q--) {
        std::cout << Query() << '\n';
    }
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