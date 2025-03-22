# Chess

所有者: Zvezdy
标签: 博弈论, 思维, 数学

两个人轮流取数，有一方先不能取的，就是经典巴什博奕。巴什博弈多半和整除有关，最重要的必败点就是最后一位为0。现在来注意这题lnc数的限制，它说把十进制数x转为k进制数y之后按位相乘的结果z能被x整除，这个条件其实是复合的，因为它们乘积能被x整除意味着它们每个都能被x整除，以后遇到此类可拆分条件要小心一些。现在我们知道根据lnc数的性质，只关心它最后一位的话，它一定是非0，并且是k的倍数，已知巴什博弈在最后一定可以化为末位为0其它位也为0的状况，所以我们只需要观察末位就能掌控全局，这也是通过分析得出的简化讨论。那我们只要保证无论怎么拿，先手都不会沦落到让当前数在k进制下末位为0的状态，就一定有方法拿到k进制下末位为0的状态。因为最末尾永远能保证被x整除。那找到第一个不能被x整除的k即可。

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

ll x;

void Main_work() {
    std::cin >> x;
    int k = 2;
    while (true) {
        if (x % k) {
            break;
        }
        ++k;
    }
    std::cout << k << '\n';
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