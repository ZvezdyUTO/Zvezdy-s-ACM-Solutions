# BOX

所有者: Zvezdy
标签: 并查集, 思维

集合的合并，实际上就是并查集。但是单纯的合并集合，但是这里实际上并不是集合合并，而是把盒子里的东西放到另一个盒子中，后面还需要用到原来的盒子。所以这里可以有一个转换。如果原来的盒子被合并了，我们就新建一个新的盒子替代原来那个被合并的盒子。

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
    int n, q;
    std::cin >> n >> q;

    std::vector<int> dsu(n + 2 * q + 1);
    std::iota(dsu.begin(), dsu.end(), 0);
    auto find = [&](int id) -> int {
        while (dsu[id] != id) {
            id = dsu[id] = dsu[dsu[id]];
        }
        return id;
    };
    auto merge = [&](int a, int b) {
        a = find(a), b = find(b);
        if (a != b) dsu[b] = a;
    };

    int cnt_ball = n;
    int cnt_box = n + q;
    std::vector<int> id(n + 2 * q + 1);
    std::vector<int> ans(n + 2 * q + 1);
    std::iota(id.begin(), id.end(), 0);
    std::iota(ans.begin(), ans.end(), 0);

    while (q--) {
        int op;
        std::cin >> op;
        if (op == 1) {
            int x, y;
            std::cin >> x >> y;
            merge(id[x], id[y]);
            id[y] = ++cnt_box;
            ans[cnt_box] = y;
        } else if (op == 2) {
            int pos;
            std::cin >> pos;
            merge(id[pos], ++cnt_ball);
        } else {
            int check;
            std::cin >> check;
            std::cout << ans[find(check)] << '\n';
        }
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