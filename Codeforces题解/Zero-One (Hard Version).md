# Zero-One (Hard Version)

所有者: Zvezdy
标签: 动态规划
创建时间: 2025年1月10日 17:33

让a和b数组变得相同，每次会修改两个元素，只有可能把0变成1，1变成0，容易发现只和两个元素不同的地方有关，所以在剔除掉无关信息以后，我们创建一个新数组c=a^b，其中为1的地方就是需要被消除的，并且每次操作都可以消除掉两个。

对于消除相邻元素和非相邻元素，我们的代价有所不同，考虑对这两种情况进行分类讨论，x≥y的情况很简单，着重考虑x<y的情况。

先把手头上有用的信息收集起来：数组中1的个数绝对为偶数个，消除相邻元素比消除非相邻元素更划算，对于某个非相邻元素，可以使用滑动的方式消除他们，代价是2x*(pos[i]-pos[i-1])。发现代价只和1的个数和每个1的相对位置有关，所以为0的地方可以不考虑，我们只考虑每个1以及它们的坐标。可以发现对于每次拼接，跳着拼不用考虑位置，而衔接着拼是越近越好，所以考虑设f[i]是拼完前i个1的最小代价，每次的选择就是将第i个1选择跳着拼，代价y/2，因为1个数为偶数个可以证明这一定是可以拼完的。另一种选择是让当前这一个和上一个进行衔接着拼，两种选择取最小就行。

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
    int n, x, y;
    std::string a, b;
    std::cin >> n >> x >> y >> a >> b;
    std::vector<bool> dif(n);
    int cnt = 0;
    for (int i = 0; i < n; ++i) {
        dif[i] = (a[i] != b[i]);
        cnt += dif[i];
    }
    if (cnt & 1) {
        std::cout << -1 << '\n';
        return;
    }
    if (x >= y || cnt == 0) {
        if (n == 2 && cnt == 2) {
            std::cout << y << '\n';
        } else {
            bool neib = false;
            for (int i = 1; i < n; ++i) {
                if (dif[i] && dif[i - 1]) {
                    neib = true;
                }
            }
            if (neib && cnt == 2) {
                std::cout << std::min(2 * y, x) << '\n';
            } else {
                std::cout << cnt / 2 * y << '\n';
            }
        }
    } else {
        std::vector<int> pos;
        for (int i = 0; i < n; ++i) {
            if (dif[i]) pos.push_back(i);
        }
        int cur = 0, next = y;
        for (int i = 1; i < pos.size(); ++i) {
            int tmp = cur;
            cur = next;
            next = std::min(next + y, tmp + (pos[i] - pos[i - 1]) * 2 * x);
        }
        std::cout << next / 2 << '\n';
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
    std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```