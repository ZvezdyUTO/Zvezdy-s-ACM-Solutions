# Double Chance

所有者: Zvezdy
标签: 树状数组, 概率论

我们抽到每个球的概率为1/k，抽两个球的概率就是1/k^2，这两个球的贡献值为max(a[i], a[j])，这么算的复杂度是n^2，不可接受，考虑统合式子进行整理然后做进一步的优化。

整理以后发现式子为对所有max(a[i], a[j])求和并除k^2，无法进一步化简式子，考虑其它办法，因为是线性顺序求解，所以看能不能从前一个答案中快速获取当前答案，假设我们新插件来的数为v，那么按照大小关系，对于小于等于v的部分，贡献都是v，记作actn+actn+1，大于等于v的部分，贡献为它们自己。发现位置关系是根据大小排序，并且只用求数量以及求和，采用树状数组进行维护即可。

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

const int N = 2e5 + 5;
const int MODE = 998244353;

int inv(int num) {
    int multi = num;
    int res = 1;
    int pow = MODE - 2;
    while (pow) {
        if (pow & 1) {
            res = res * multi % MODE;
        }
        multi = multi * multi % MODE;
        pow >>= 1;
    }
    return res;
}

struct BIT {
    int bit[N]{0};

    void update(int i, int x) {
        while (i < N) {
            bit[i] += x;
            i += i & -i;
        }
    }

    int query(int i) {
        int res = 0;
        while (i) {
            res = (res + bit[i]) % MODE;
            i -= i & -i;
        }
        return res;
    }
} sum, actn;

void Main_work() {
    int n;
    std::cin >> n;
    int ans = 0, total = 0;
    for (int i = 1, v; i <= n; ++i) {
        std::cin >> v;

        ans = (ans + (2ll * actn.query(v) + 1) * v % MODE) % MODE;
        ans = (ans + (2ll * (total - sum.query(v)) % MODE + MODE) % MODE) % MODE;
        std::cout << (ans * inv(i * i % MODE) % MODE) << '\n';

        total = (total + v) % MODE;
        sum.update(v, v), actn.update(v, 1);
    }
}

void init() {}

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