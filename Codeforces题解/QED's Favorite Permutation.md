# QED's Favorite Permutation

所有者: Zvezdy
标签: 前缀和&差分, 思维
创建时间: 2024年11月29日 21:01

手玩后可以发现LR是绝对分割点，也就是左边的过不去右边的过不来。而我们原来要做的就是把数字退回它们该在的位置移动到它们应该在的位置。我们可以把移动路径看成线段，如果所有线段都没有被分割点分割，那么我们就可以完成任务。

但是枚举线段代价有点大，注意到询问都是关于分割点的改变，那我们可以枚举记录场上有哪些分割点是有效的，当且仅当分割点分割了有效的线段才会生效，线段这里使用差分数组记录每个位置的线段数目就好，因为我们只用知道那个位置处有没有线段。

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

void Main_work() {
    int n, q;
    std::cin >> n >> q;

    std::vector<int> p(n + 1), invp(n + 1);
    for (int i = 1; i <= n; ++i) {
        std::cin >> p[i];
        invp[p[i]] = i;
    }

    // 把路径看成线段
    std::vector<int> seg(n + 1, 0);
    for (int i = 1; i <= n; ++i) {
        int l = std::min(p[i], invp[p[i]]);
        int r = std::max(p[i], invp[p[i]]);
        ++seg[l], --seg[r];
    }
    for (int i = 1; i <= n; ++i) {
        seg[i] += seg[i - 1];
    }

    std::vector<char> bound(n + 2, ' ');
    for (int i = 1; i <= n; ++i) {
        std::cin >> bound[i];
    }

    // 一个线段有很多个分割点，如果要想一个线段完全合法，那么就必须解决掉所有的分割点
    std::set<int> bad;
    for (int i = 1; i < n; ++i) {
        if (bound[i] == 'L' && bound[i + 1] == 'R' && seg[i]) {
            bad.insert(i);
        }
    }

    // 每次都会改变一个分割点，无论如何
    // 如果增加了分割点，那么就改变
    // 如果没有，就不管
    // 因为每次的改变都是位置级别的，即使真正被作用的是线段也要按位置来看
    while (q--) {
        int index;
        std::cin >> index;
        bound[index] = (bound[index] == 'L' ? 'R' : 'L');
        if (bound[index - 1] == 'L' && bound[index] == 'R' && seg[index - 1]) {
            bad.insert(index - 1);
        } else {
            bad.erase(index - 1);
        }
        if (bound[index] == 'L' && bound[index + 1] == 'R' && seg[index]) {
            bad.insert(index);
        } else {
            bad.erase(index);
        }
        if (bad.size()) {
            std::cout << "NO\n";
        } else {
            std::cout << "YES\n";
        }
    }
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