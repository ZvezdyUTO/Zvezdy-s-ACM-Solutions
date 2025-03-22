# Burenka and Traditions (hard version)

所有者: Zvezdy
标签: 位运算, 思维, 贪心
创建时间: 2025年1月16日 13:06

比较思维，观察操作发现，从小往大看，就是如果选长度为1的区间，代价为1，长度为2的区间，代价也为1，长度为n的区间，代价为n/2向上取整，也就可以看成执行了n/2次选长度为2的区间加上n%2次长度为1的区间。容易发现大的统合操作能够拆分成若干小的独立操作，代价一致，且小操作更加灵活，所以小操作一定更优，因此抛弃大操作，在只执行小操作这一层面继续思考。当两个数可以被一次性异或完的时候，这两个数相等，换句话来说这两个数异或和为0。考虑根据异或和为0这个特殊性质来判断多个数的情况，如果有三个数a b c异或为0，那么我们先将a和b异或上a以消除a，那么此时b变为b^a=c，按照这个连锁反应，我们可以发现只要区间异或和为0，那么我们就可以少花1代价完成消除，让这种区间尽可能更多即可。新得到的技巧就是异或和为0或者说类似条件是有拓展性的。

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
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    int ans = n;
    std::map<int, bool> mp;
    mp[0] = true;
    int pxor = 0;
    for (int i = 0; i < n; ++i) {
        pxor ^= arr[i];
        if (mp.count(pxor)) {
            --ans;
            mp.clear();
            mp[pxor = 0] = true;
        } else {
            mp[pxor] = true;
        }
    }
    std::cout << ans << '\n';
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