# Sheikh (Hard Version)

所有者: Zvezdy
标签: 位运算, 前缀和&差分, 数学
创建时间: 2024年12月12日 10:41

疯狂的分讨，还有利用了一些性质。看到数学公式的时候可以想到去观察这个式子本身的性质，再去考虑它本身要达成的目的。这题将异或和加法掺杂在了一起，异或作为不进位加法，肯定是比直接加上要小的，所以在这题中一定是选越多的元素越好。但是这题的另一个限制就是要我们最终选出的区间长度最短，所以这里我们必须考虑缩短区间让答案还和原来那样一样。问题是不清楚应该缩短多少区间。但可以肯定的是一定是从两头开始缩进。考虑什么时候删掉尽头元素不会造成影响，逆向思维一下，我们是减去并异或上了一个元素只有之前我们关于这个元素的所有位都是0的时候才会抵消影响，并且这么做完以后那些位上一定全为1了，不可能再动。我们的数字一共有32位，那么我们假设每一位都是如此，那么我们最多能删掉左右两边三十个元素，暴力枚举代价就是log^2，可以接受。

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
    std::vector<int> ord(1, 0);
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
        if (arr[i]) {
            ord.push_back(i);
        }
    }

    n = ord.size() - 1;
    std::vector<int> prexor(n + 1, 0);
    std::vector<ll> prefix(n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        prexor[i] = prexor[i - 1] ^ arr[ord[i]];
        prefix[i] = prefix[i - 1] + arr[ord[i]];
    }

    auto check = [&](int l, int r) -> ll {
        return prefix[r] - prefix[l - 1] - (prexor[r] ^ prexor[l - 1]);
    };

    while (q--) {
        int l, r;
        std::cin >> l >> r;
        int save = l;

        l = std::lower_bound(ord.begin() + 1, ord.end(), l) - ord.begin();
        r = std::upper_bound(ord.begin() + 1, ord.end(), r) - ord.begin() - 1;

        if (l > r || n == 0) {
            std::cout << save << ' ' << save << '\n';
            continue;
        }

        int ans_l = l, ans_r = r;
        for (int i = l; i <= std::min(l + 30, r); ++i) {
            for (int j = r; j >= std::max(r - 30, l); --j) {
                if (i <= j && check(l, r) == check(i, j) && ord[j] - ord[i] < ord[ans_r] - ord[ans_l]) {
                    ans_l = i, ans_r = j;
                }
            }
        }

        std::cout << ord[ans_l] << ' ' << ord[ans_r] << '\n';
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
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```