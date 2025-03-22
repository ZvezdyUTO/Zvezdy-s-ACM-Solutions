# Diverse Substrings

所有者: Zvezdy
标签: 双指针, 暴力枚举
创建时间: 2024年12月9日 09:07

一般对于这种题都是固定右端点枚举左端点，但是发现它没有单调性，固不能双指针尺取。仔细观察发现这题里面符合要求的字符串长度最多为10*10=100，所以我们固定右端点最多往左扫描100个字符。遇到此类题目一定留心：字符串搭配种类和条件长度极限，因为长度极限关系着我们最多重复计算多少次。

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
    std::string s;
    std::cin >> s;
    int ans = 0;
    for (int r = 0; r < n; ++r) {
        int max = 0, kinds = 0;
        std::vector<int> vis(10, 0);
        for (int l = r, len = 1; l >= 0 && len <= 100; --l, ++len) {
            if (++vis[s[l] - '0'] == 1) {
                ++kinds;
            }
            max = std::max(max, vis[s[l] - '0']);
            if (kinds >= max) {
                ++ans;
            }
        }
    }
    std::cout << ans << '\n';
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