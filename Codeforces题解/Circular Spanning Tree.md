# Circular Spanning Tree

所有者: Zvezdy
标签: 图论, 构造
创建时间: 2025年3月5日 16:53

没有想到相关的信息，这题的第一个关键在于给的度数，从度数信息可以观察到一点很重要的性质：所有顶点度数之和必须为偶数，所以奇数度数点一定为偶数，又因为这是一棵树，必须有叶子，所以一定要存在奇数度数点，有了这些东西，就可以就着手头上的信息进行初步的分类讨论了。我们可以分成有偶度数顶点、无偶度数顶点的情况讨论。

根据圆内边不相交的性质来看，从一个点发散出去的边是一定不可能交叉的。如果无偶度数顶点，那么一定是一个奇度数顶点做根然后连接剩下的奇度数顶点。比较麻烦的是偶度数顶点存在的情况，首先此时此刻奇度数顶点数目一定为偶数，所以我们按照简单构造的原则让那些奇度数顶点作为叶子，此时还需要处理场上剩余的偶度数顶点，可以发现，如果一个叶子被延长以后是中间连着一个点，那么那个点度数就是偶数，根据这个原则可以轻松构造出第二种情况。

类似题目可以先看熟悉信息推导出一些预置条件，根据预置条件进行分类讨论。构造的时候严格符合简单原则，只要符合条件并且能适应所有情形，那么就尽量从构造简单图开始。

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
    int n;
    std::cin >> n;
    std::string s;
    std::cin >> s;
    std::vector<int> cnt(2, 0);
    for (auto ch : s) cnt[ch - '0'] += 1;

    if (cnt[1] == 0 || cnt[1] % 2) {
        std::cout << "NO\n";
        return;
    }

    std::cout << "YES\n";

    auto next = [&](int i) {
        return i == n ? 1 : i + 1;
    };
    auto last = [&](int i) {
        return i == 1 ? n : i - 1;
    };

    if (cnt[0] == 0) {
        for (int i = 2; i <= n; ++i) {
            std::cout << 1 << ' ' << i << '\n';
        }
    } else {
        bool comb = false;
        std::vector<bool> vis(n + 1, false);
        for (int i = 1; i <= n; ++i) {
            if (s[i - 1] == '0') {
                std::cout << i << ' ' << next(i) << '\n';
                vis[next(i)] = true;
            }
        }

        int fst = -1;
        for (int i = 1, it = 1; it <= 2 * n; ++it, i = next(i)) {
            if (!vis[i]) {
                if (fst == -1) {
                    if (s[i - 1] == '0') {
                        fst = i;
                        vis[fst] = true;
                    }
                    continue;
                }
                std::cout << fst << ' ' << i << '\n';
                vis[i] = true;
            }
        }
    }
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