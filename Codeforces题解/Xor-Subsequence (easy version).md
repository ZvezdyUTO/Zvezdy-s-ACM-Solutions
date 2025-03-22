# Xor-Subsequence (easy version)

所有者: Zvezdy
标签: 位运算, 动态规划
创建时间: 2025年1月15日 12:00

利用了位运算的经典性质，首先化简题目给的那个狗屎式子，发现我们是要找到一个a的子序列，保证对于每个位置都有一个连锁关系，这代表当前位置的数至于它左右两边的数有关。最长子序列问题考虑使用动态规划求解，设状态为以第 i 个位置结尾的最长子序列长度，转移发生条件是arr[i]^j < arr[j]^i。得到的状态转移方程明显是n^2的，考虑优化这个部分。

发现每个数不超过200，根据异或运算的经典trick：b-a, a-b ≤ a^b ≤ a+b，我们要对我们的枚举部分进行优化，所以考虑找下标之间的关系，有式子 j-arr[i] ≤ arr[i]^j < arr[j]^i ≤ arr[j]+i → j-i <arr[i]+arr[j] = 400，所以两个可转移位置之间的下标差不超过400，据此打暴力求解即可。

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
    // arr[i] ^ j < arr[j] ^ i
    // j - arr[i] < arr[j] + i
    // j - i < arr[i] + arr[j] <= 400
    // j - i <= 400 -> j <= i+400，只往后找400位
    int n;
    std::cin >> n;
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    std::vector<int> f(n, 1);
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < std::min(n, i + 400); ++j) {
            if ((arr[i] ^ j) < (arr[j] ^ i)) {
                f[j] = std::max(f[j], f[i] + 1);
            }
        }
    }
    std::cout << *std::max_element(f.begin(), f.end()) << '\n';
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