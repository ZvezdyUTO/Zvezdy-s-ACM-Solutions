# Rain

所有者: Zvezdy
标签: 思维, 数学
创建时间: 2025年1月28日 17:30

数形结合的思维题目。首先对于有公式存在的题目，最重要的首先就是通过各种途径去分析它的公式。这一题题目中给出的公式是每个地区降水量的存储条件，题目给出的核心条件是任意一处位置降水量不超过m即为合格，那么这个式子就变成了一个不等式：降水量的计算 ≤ m

同时题目给出的另一个目标就是取消某一天的降水能不能阻止洪水。那么我们的不等式就变成了：总降水量-某一天降水量 ≤ m，如果现在直接按这个式子解决问题是非常麻烦的，所以对不等式进行处理，也就是移项+整理。移项后可以拿到：总降水量 ≤ m+某一天降水量，使用数形结合思想对其进行具象化，可发现只要某一天的降水量向上偏移m能盖住所有的降水量就行。

接下来考虑如何快速判断某一天的降水量能否实现条件。因为降水量的累计是从降水地点向左右两侧递减，所以降水中心一定是极大值点，挨个统计超过m的极大值点，并通过代入未知数设方程的方式来计算怎么样的位置和高度能满足覆盖它们的条件，这一定是一个不等式，并且求出这些不等式的有效交集就可以判断我们的每个降水点是否可以满足条件。在处理绝对值的部分，就分类讨论，按正负来取。

最后是计算总降水量的方式，因为都是函数的区间叠加，所以使用差分数组，同时这是一个线性函数，所以值应该是 当前斜率*两个点之间的距离 ，查分数组记录的就是斜率的变化。

```jsx
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
    int n, m;
    std::cin >> n >> m;
    std::vector<int> x(n + 1, 0), p(n + 1, 0);
    std::map<int, int> delt;
    for (int i = 1; i <= n; ++i) {
        std::cin >> x[i] >> p[i];
        delt[x[i] - p[i] + 1] += 1;
        delt[x[i] + 1] -= 2;
        delt[x[i] + p[i] + 1] += 1;
    }

    int cur = 0, k = 0, last = -1e15;
    int a1 = -1e15, a2 = -1e15;
    for (auto [pos, add] : delt) {
        cur += k * (pos - last);
        k += add;

        if (cur > m) {
            a1 = std::max(a1, cur - pos + 1);
            a2 = std::max(a2, cur + pos - 1);
        }

        last = pos;
    }
    for (int i = 1; i <= n; ++i) {
        std::cout << ((p[i] + m - x[i] >= a1) && (p[i] + m + x[i] >= a2));
    }
    std::cout << '\n';
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