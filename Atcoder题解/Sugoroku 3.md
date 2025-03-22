# Sugoroku 3

所有者: Zvezdy
标签: 动态规划, 概率论

概率DP，本身不难，重点是知道怎么处理概率。假设我们在位置i，有p的概率走到终点，但是有(1-p)的概率走到另一个点，而另一个点走到终点的期望是a，那么我们在位置i走到终点的期望就是1+p*0+(1-p)*a，其中那个0是终点走到终点的期望，自然是0。由此可以总结出，当前位置的期望=当前位置进行操作所需要的必要代价+后续操作的期望值*需要使用后续操作的概率。也就是一个倒推模型，每一次都严格使用后续操作的期望值。列出基本的式子后使用数学方法进行化简就可以轻松求和。

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

const int MODE = 998244353;

int inv(int num) {
    int pow = MODE - 2ll, multi = num, res = 1;
    while (pow) {
        if ((pow & 1)) res = res * multi % MODE;
        multi = multi * multi % MODE;
        pow >>= 1;
    }
    return res;
}

void Main_work() {
    int n;
    std::cin >> n;
    std::vector<int> arr(n);
    for (int i = 1; i < n; ++i) std::cin >> arr[i];
    std::vector<int> psum(n + 2, 0), f(n, 0);
    for (int i = n - 1; i >= 1; --i) {
        f[i] = ((psum[i + 1] - psum[i + arr[i] + 1] + MODE) % MODE + arr[i] + 1) % MODE * inv(arr[i]) % MODE;
        psum[i] = (f[i] + psum[i + 1]) % MODE;
    }
    std::cout << f[1] << '\n';
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```