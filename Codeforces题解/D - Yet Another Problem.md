# D - Yet Another Problem

所有者: Zvezdy
标签: 位运算, 前缀和&差分
创建时间: 2024年12月9日 20:29

因为异或运算的交换律和结合率，还有0异或的特性，所以在这一题中无论我们按什么顺序如何进行操作，一开始异或和不为零的部分永远不为0。

再考虑另一个条件：每次我们只能选奇数区间，这意味着如果我们选的是偶数区间我们不能一口气全异或完，唯一一个能让这个区间全部变为0的可能就是我们将其一分为两个奇数区间（奇数+奇数=偶数），然后两半都能异或为0。为了实现这个特判，我们可以贪心地维护每个下标右边第一个和它奇偶不同，并且与它异或和为0的端点。

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

void Main_work() {
    int n, q;
    std::cin >> n >> q;

    std::vector<int> arr(n + 1);
    std::vector<int> prefix(n + 1, 0);
    std::vector<int> prexor(n + 1, 0);

    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
        prefix[i] = prefix[i - 1] + arr[i];
        prexor[i] = (prexor[i - 1] ^ arr[i]);
    }

    std::array<std::map<int, int>, 2> last;
    std::vector<int> next(n + 1, -1);

    for (int i = n; i >= 0; --i) {
        next[i] = last[(i & 1) ^ 1][prexor[i]];
        if (next[i] == 0) {
            next[i] = n + 1;
        }
        last[i & 1][prexor[i]] = i;
    }

    while (q--) {
        int l, r;
        std::cin >> l >> r;
        if ((prexor[l - 1] ^ prexor[r]) == 0) {
            if (prefix[r] - prefix[l - 1] == 0) {
                std::cout << "0\n";
            } else if ((r - l + 1) & 1) {
                std::cout << "1\n";
            } else if (next[l - 1] <= r) {
                if (arr[l] == 0 || arr[r] == 0) {
                    std::cout << "1\n";
                } else {
                    std::cout << "2\n";
                }
            } else {
                std::cout << "-1\n";
            }
        } else {
            std::cout << "-1\n";
        }
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