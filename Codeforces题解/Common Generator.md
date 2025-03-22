# Common Generator

所有者: Zvezdy
标签: 思维, 数论
创建时间: 2024年11月14日 22:31

现在经过简单公式加工推导以后，会发现这个规律实际上也是对于一个数，我们可以不断减它的因数，直到变为零。先来看一些基础的情况，如果我们有一个2，那么我们可以一直拿它疯狂+2，直到变成任何一个偶数。从这个情况进行推广，如果我们拿到的是一个奇数，那么只要我们将其减掉一个最小的质因数，那么就会变为一个偶数，就可以继续拿-2来霍霍它。但是很显然我们必须有一个整除关系才能如此操作，所以这个奇数的最小质因数还得翻个2倍。如果场上有质数存在，那我们的生成数只能是那个质数了，然后根据我们刚才的关系推导出公式： base*2≤arr[i]-minp[i]，多个质数会有矛盾，而该公式只有在arr[i]为奇数的时候需要减掉最小质因数。

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

const int N = 1e5 + 5;
const int M = 4e5 + 5;
int n;

int prime;
std::array<int, M> minp;
std::vector<int> primes;
int sieve() {
    int m = 4e5;
    for (int i = 2; i <= m; ++i) {
        if (!minp[i]) {
            minp[i] = i;
            primes.push_back(i);
        }
        for (auto p : primes) {
            if (i * p > m) {
                break;
            }
            minp[i * p] = p;
            if (p == minp[i]) {
                break;
            }
        }
    }
    return minp.size();
}

std::array<int, N> arr;

inline int solve() {
    // 如果有多个质数，完蛋了
    int base = 0;
    for (int i = 1; i <= n; ++i) {
        if (arr[i] == minp[arr[i]]) {
            if (base) {
                return -1;
            }
            base = arr[i];
        }
    }

    if (!base) {
        base = 2;
    }

    for (int i = 1; i <= n; ++i) {
        if (arr[i] == base) {
            continue;
        }
        if (arr[i] % 2) {
            if (arr[i] == base) {
                continue;
            }
            arr[i] -= minp[arr[i]] + base;
            if (base != 2) {
                arr[i] -= base;
            }
            if (arr[i] < 0) {
                return -1;
            }
        } else {
            if (arr[i] < base * 2) {
                return -1;
            }
        }
    }
    return base;
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    // 2是否可生成其它所有的数？
    // 首先，每个数能减去自己的因数
    // 一个偶数的最小生成器一定是2，因为可以一直减
    // 如果是奇数的话，减去一个奇数因子，就可以变为偶数
    // 所以只要这个奇数不是质数，就可以转化为2的生成
    // 如果这个奇数是质数，就只能拿这个数做生成
    // 多个质数就没救了
    // 如果场上所有的质数都共享一个质因数，就可以转
    // 如果场上有一个质数，那么就一定是那个质数
    // 质数*2以后，就可以拿2堆上去了
    // 所以最好是其他数>=质数*2
    // 7 25
    // 14 25
    // 25->20
    // 对于奇数，就干掉它的最小质因子
    // 所以对于所有数来说，如果为偶数，就看
    // 场上最小质数*2能不能<=偶数
    // 然后<=奇数-最小质因子
    std::cout << solve() << '\n';
}

void init() {
    prime = sieve();
}

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