# Hossam and Trainees

所有者: Zvezdy
标签: 数学
创建时间: 2024年12月8日 08:16

质数的性质，对于任何数，最多只能有一个质因子p>n^(1/2)，所以我们可以采用消除质因子的写法。消除质因子就是使用while循环一直除以那个质因子直到不能整除。只要有任意一个质因子在不同的两个数中出现我们就可以认为这题解决。同时这个消除质因子的方法也能让我们在极快的时间内拿到这个数的所有质因子。

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

std::vector<int> primes;
int minp[100000 + 5];
int bucket[100000 + 5];

void Main_work() {
    int n;
    std::cin >> n;
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    std::map<int, bool> vis;
    for (int i = 0; i < n; ++i) {
        for (auto p : primes) {
            if (arr[i] % p == 0) {
                if (vis[p]) {
                    std::cout << "Yes\n";
                    return;
                }
                vis[p] = true;
                while (arr[i] % p == 0) {
                    arr[i] /= p;
                }
            }
        }
        if (arr[i] > 1) {
            if (vis[arr[i]]) {
                std::cout << "Yes\n";
                return;
            } else {
                vis[arr[i]] = true;
            }
        }
    }
    std::cout << "No\n";
}

void init() {
    for (int i = 2; i <= 1e5; ++i) {
        if (minp[i] == 0) {
            minp[i] = i;
            primes.push_back(i);
        }
        for (auto j : primes) {
            if (i * j > 1e5) {
                break;
            }
            minp[i * j] = j;
            if (minp[i] == j) {
                break;
            }
        }
    }
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