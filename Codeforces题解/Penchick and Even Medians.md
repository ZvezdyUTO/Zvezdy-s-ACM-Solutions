# Penchick and Even Medians

所有者: Zvezdy
标签: 互动题, 位运算, 思维
创建时间: 2024年11月16日 20:11

如果我们把所有元素一起查询，会得到本排列的两个中位数，但如果我们把查询中任意两个元素挖掉，会产生不同情况：1.我们挖掉了两个中位数，那么会查出来mid-1和mid+2。2,如果我们挖掉了其中一个中位数，就看挖掉的另一个部分在哪里，假如我们挖掉的是左边的中位数，并挖掉了排列左半边的数，那么我们会查询到mid+1和mid+2，如果我们挖掉的另一个是右半边的，那么我们会查到mid-1和mid+2，类比一下右半边，我们就可以得出基本的讨论情况，刚好挖到两个中位数的话就特判一下交了，挖到一个左半边一个右半边的无关数情况我们忽略不计。

这样子从1~n中两个两个挖，就会得到这么一些数对：包含两个半边无关数和一个半边无关数一个中位数的数对们按来源分为左半边、右半边两组，我们需要从这些数对中找到包含中位数的那些对。这就变成一个经典的二分查找问题：老鼠试毒。这个问题的标准解法是利用二进制位来分组，把二进制中每一位为1的元素分为一组，每次查询看我们所需的答案是否在该位中，最后把所有符合要求的位拼起来就是我们的答案。

由这个思路我们查找到了中位数存在的2个数对，此时4次询问内暴力枚举中位数究竟在哪里就好。

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

int n, k;

std::vector<int> lower, upper;
int lower_mid, upper_mid;

std::array<int, 2> take_list(std::vector<int>& list) {
    std::cout << "? " << list.size() << ' ';
    for (auto it : list) {
        std::cout << it << ' ';
    }
    std::cout << std::endl;

    int m1, m2;
    std::cin >> m1 >> m2;
    return {m1, m2};
}

std::array<int, 2> query(int x, int y) {
    std::vector<int> list;
    for (int i = 1; i <= n; ++i) {
        if (i != x && i != y) {
            list.push_back(i);
        }
    }
    return take_list(list);
}

// 第一次分类，把所有2元配对查询出来
inline bool prework() {
    lower.clear(), upper.clear();
    lower_mid = upper_mid = -1;

    for (int i = 1; i <= k; ++i) {
        auto [m1, m2] = query(2 * i - 1, 2 * i);

        if (m1 == k + 1 && m2 == k + 2) {  // 上元素
            lower.push_back(i);
        } else if (m1 == k - 1 && m2 == k) {  // 下元素
            upper.push_back(i);
        } else {  // 绝对包含目标元素
            bool has_lower = (m1 == k - 1);
            bool has_upper = (m2 == k + 2);
            if (has_lower && has_upper) {
                std::cout << "! " << 2 * i - 1 << ' ' << 2 * i << std::endl;
                return true;
            } else if (has_lower) {
                lower_mid = i;
            } else if (has_upper) {
                upper_mid = i;
            }
        }
    }
    return false;
}

// 如果没找到，那么精准查找出配对元素
inline void exact_check() {
    int lower_index = 0, upper_index = 0;
    for (int bit = 0; bit < 10; ++bit) {
        std::vector<int> list;
        for (int i = 0; i < lower.size(); ++i) {
            // 枚举二进制位下为？的子集
            // 把这些子集按照二进制位组合起来，就是答案
            if (i & (1 << bit)) continue;
            list.push_back(2 * lower[i] - 1);
            list.push_back(2 * lower[i]);
            list.push_back(2 * upper[i] - 1);
            list.push_back(2 * upper[i]);
        }
        auto [m1, m2] = take_list(list);
        if (m1 < k) lower_index |= (1 << bit); // 被删除的元素中有左元素
        if (m2 > k + 1) upper_index |= (1 << bit); //被删除的元素中有右元素
    }
    if (lower_mid == -1) lower_mid = lower[lower_index];
    if (upper_mid == -1) upper_mid = upper[upper_index];
}

// 确定两个中位数所在配对位置，暴力匹配
inline void solve() {
    for (int i = 2 * lower_mid - 1; i <= 2 * lower_mid; ++i) {
        for (int j = 2 * upper_mid - 1; j <= 2 * upper_mid; ++j) {
            auto [m1, m2] = query(i, j);
            if (m1 == k - 1 && m2 == k + 2) {
                std::cout << "! " << i << ' ' << j << std::endl;
                return;
            }
        }
    }
}

void Main_work() {
    std::cin >> n;
    k = n / 2;
    if (prework()) return;
    if (lower_mid == -1 || upper_mid == -1) exact_check();
    solve();
}

void init() {}

int main() {
    // std::ios::sync_with_stdio(false);
    // std::cin.tie(0), std::cout.tie(0);
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