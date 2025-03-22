# Equal Binary Subsequences

所有者: Zvezdy
标签: 思维
创建时间: 2025年1月3日 21:13

题目设置的比较难读懂，但是有一个最初始的目的：把一个数组分成两段相同的子序列。这里就有一个思维点了，就是如果我们的数组是11001100这种相邻两个元素一样的，我们就可以轻松实现奇数取，偶数取得两个相同子序列。但是我们拿到的数组不一定符合这种条件，但是放到单元上来看，就只有相邻元素相同、不相同两种可能，题目给出的操作是选一个子序列让后让它们向后轮滚一位，如果我们选出的子序列为10交题，那么轮滚一位以后就相当于把原来位置上的元素切换为另一个元素了，所以我们只需要找到所有相邻位置不同的元素，并把它们10交替着取出来并轮滚就能得到答案。

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
// #define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int n;
    std::cin >> n;
    std::string s;
    std::cin >> s;
    // 求能不能在某次轮换操作以后让数组能选出两个不相交相同子序列
    std::vector<int> nums(2, 0);
    for (auto ch : s) {
        ++nums[ch - '0'];
    }
    if (nums[0] & 1) {
        std::cout << "-1\n";
        return;
    }
    // 怎么把一个数组分成两个相同的子序列？或者说怎么知道能不能分成两个相同的子序列？
    // 一个tips：如果都是00 11 00 11 11这种两个一起的，那么一定可以组成两个相同的子序列
    // 但是我们不一定能弄到这种，我们可能会弄到00 10 01 11 10 01这种有交叉的
    // 但是题目给的条件是，我们是任选一个子序列进行轮转
    // 我们的目的是让不同的变成相同，而，101010进行轮换之后刚好交替
    std::vector<int> chg;
    int cho = 0;
    for (int i = 1; i < 2 * n; i += 2) {
        if (s[i] != s[i - 1]) {
            if ((cho && s[i - 1] == '1') || (!cho && s[i - 1] == '0')) {
                chg.push_back(i - 1 + 1);
            } else {
                chg.push_back(i + 1);
            }
            cho ^= 1;
        }
    }
    std::cout << chg.size() << ' ';
    for (auto i : chg) {
        std::cout << i << ' ';
    }
    std::cout << '\n';
    for (int i = 1; i <= 2 * n; i += 2) {
        std::cout << i << ' ';
    }
    std::cout << '\n';
}

void init() {}

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