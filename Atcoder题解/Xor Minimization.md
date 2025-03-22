# Xor Minimization

所有者: Zvezdy
标签: dfs, 位运算

也是分类讨论的题目，考虑到异或运算对于每一位操作独立，我们选择分类讨论。因为涉及最大值所以考虑从最高位往低位考虑。我们扫描整个数组的这一位，如果所有数字这一位都是1，那么我们可以让这一位全部变为0，如果全是0，就不用管，如果有一些1一些0，那么就需要分类讨论，我们可以选择把所有1变为0然后讨论另一组数据，或者直接不管，然后讨论原本为1的那一组数据。这里的核心思路就是模拟放1或者不放1所带来的后果，最后在两个选择之间选较小值就行。这里的空间复杂度也比较奇妙，如果我们在每一层搜索中都强制分类数字并下发，按照最坏的可能性，我们大概会开成一个线段树大小。

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
    int n;
    std::cin >> n;
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    auto dfs = [&](auto&& self, std::vector<int>& cur, int bit) {
        if (bit < 0) {
            return 0;
        }
        std::vector<int> a, b;
        for (auto i : cur) {
            if (i & (1 << bit)) {
                a.push_back(i);
            } else {
                b.push_back(i);
            }
        }
        if (a.size() == 0) {
            return self(self, b, bit - 1);
        } else if (b.size() == 0) {
            return self(self, a, bit - 1);
        } else {
            return std::min(self(self, a, bit - 1), self(self, b, bit - 1)) | (1 << bit);
        }
    };
    std::cout << dfs(dfs, arr, 29);
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