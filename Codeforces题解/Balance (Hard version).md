# Balance (Hard version)

所有者: Zvezdy
标签: 位运算, 数学
创建时间: 2024年12月12日 09:15

如果不带修改操作，那么我们只需要记录每个k原来所跑到的答案，以后遇到相同的k一律暴力跳转就行了。因为这题有一个非常特殊的性质，它加的每一个数都是在它操作中加上去的，所以我们暴力进行跳转后附带记录消除实际上就是在消耗它的势能。如果加入了删除操作，那我们就不能继续使用原来的方式记录答案了，想象我们的mex是一条连续的线段，然后我们在中间挖掉了一个点，我们就记录那些被我们挖掉的点（右端点也算）。同时为了为了删除方便，我们还需要记录那些被删除的数会影响到哪些数。原本我们记录的答案就是按谁被查找过就在查找的时候记录它，现在我们也可以按照这个方式，谁被查找了就记录它会受到那些数字删除的影响，具体就是在它遍历的路上反向记录那些数字，等删除那些数字的时候再掏出那个数字特有的集合删除就行。

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

std::set<ll> S;

// 未出现数的候选集合、哪些k被分配到了x上
std::map<ll, std::set<ll>> disaper, factor;
void add(ll x) {
    S.insert(x);
}
void del(ll x) {
    S.erase(x);
    for (auto it : factor[x]) {
        disaper[it].insert(x);
    }
}

ll check(ll k) {
    // 现在要找k倍的mex
    disaper[k].insert(k);
    ll u = *disaper[k].begin();
    factor[u].insert(k);
    while (S.count(u)) {
        // 表示u是k的倍数
        // 实际上disaper里面是候选方案
        // 一个一个暴力跳转
        // 把k所拥有的所有因子打出来，直到第一个mex出现为止
        disaper[k].erase(u);
        if (disaper[k].size() == 0) {
            disaper[k].insert(u + k);
        }
        // 同时记录删除后可能会被影响的位置
        u = *disaper[k].begin();
        factor[u].insert(k);
    }
    return *disaper[k].begin();
}

void Main_work() {
    int q;
    std::cin >> q;
    while (q--) {
        char op;
        std::cin >> op;
        ll input;
        std::cin >> input;
        if (op == '+') {
            add(input);
        } else if (op == '-') {
            del(input);
        } else {
            std::cout << check(input) << '\n';
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```