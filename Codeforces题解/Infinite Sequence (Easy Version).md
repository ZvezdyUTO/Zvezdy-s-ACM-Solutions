# Infinite Sequence (Easy Version)

所有者: Zvezdy
标签: 位运算, 数学
创建时间: 2025年3月3日 10:16

注意到是纯粹的推式子题。手推发现，前n项直接输出，第n项开始都是pxor[i/2]的值，但是到第2*n项的时候就会发生变化，因为第i项和第i+1项都等于pxor[i/2]，所以a_i=a_i+1 (i%2==0)。通过这个假设我们我可以发现，如果一路异或过去的话，在i>2*n后面前缀异或的相邻两项会被抵消，此时直接进行分类讨论，为了方便先统一起点，假设统一后都是从偶数位开始，此时我们需要求下标i的值=pxor[i/2]，如果i/2为偶数，那么可以从n开始向后两两抵消，直接返回pxor[n]的值，如果是奇数，那么还需要多异或一个a[i/2]的值，因此可以打出一个对数复杂度的递推式。

trick：推式子题尽量使用向上抽象来简化式子，以便发现规律，如果遇到分奇偶性讨论不同的地方，就使用微操统一起点减少讨论，递推关系到达复杂度要求时就可以直接输出。

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
#define int ll
#define debug(x) std::cout << #x << " = " << x << '\n'

void Main_work() {
    int n, l, r;
    std::cin >> n >> l >> r;
    std::vector<int> arr(2 * n + 2);
    for (int i = 1; i <= n; ++i) std::cin >> arr[i];
    std::vector<int> pxor(2 * n + 2, 0);
    for (int i = 1; i <= 2 * (n + (n % 2 == 0)); ++i) {
        if (i > n) arr[i] = pxor[i / 2];
        pxor[i] = arr[i] ^ pxor[i - 1];
    }
    n += (n % 2 == 0);

    auto check = [&](auto&& self, int idx) {
        if (idx <= 2 * n) return arr[idx];
        idx /= 2ll;
        if (idx % 2) {
            return pxor[n];
        } else {
            return pxor[n] ^ self(self, idx);
        }
    };

    std::cout << check(check, l) << '\n';
}

void init() {
}

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