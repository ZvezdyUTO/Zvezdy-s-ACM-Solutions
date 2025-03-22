# Ardent Flames

所有者: Zvezdy
标签: 二分答案, 扫描线
创建时间: 2024年11月18日 11:21

除非挨个枚举地点并对比，不然很难判断在何处能用最少次数干掉k个敌人。当求解非常困难的时候，就想想能不能转化为求证，观察发现这个所需攻击次数具有明显的单调性，于是考虑二分答案进行枚举验证。

我们对攻击次数进行枚举，对于每一个敌人，影响它所需攻击次数的是我们选择的地点，离敌人越近，所需攻击次数越少，所以我们可以使用公式加工计算出在actn次攻击内消灭每个敌人的合法范围，这些范围就是一条一条不同的线段，只要找得到k条不同线段的交汇处，就能解决这道问题。使用std::map离散化前缀和跑扫描线处理。

除了正难则反，还有不好求解就求证，这两个转换思维都挺重要的，这题的关键在于发现单调性，或者说两段性，而这就是二分答案的关键。

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
int n, atk, k;

std::array<int, N> hp, pos;

std::map<int, int> ranges;

bool check(int actn) {
    ranges.clear();
    for (int i = 1; i <= n; ++i) {
        // atk-dist=(hp[i]+actn-1)/actn
        int dist = atk - (hp[i] + actn - 1) / actn;
        if (dist >= 0) {
            ++ranges[pos[i] - dist];
            --ranges[pos[i] + dist + 1];
        }
    }
    int cur = 0;
    for (auto &[_, it] : ranges) {
        cur += it;
        if (cur >= k) {
            return true;
        }
    }
    return false;
}

inline ll binary_answer() {
    int l = 1, r = 1e9, ans = -1;
    while (l <= r) {
        int mid = (l + r) / 2;
        if (check(mid)) {
            ans = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }
    return ans;
}

void Main_work() {
    std::cin >> n >> atk >> k;
    for (int i = 1; i <= n; ++i) {
        std::cin >> hp[i];
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> pos[i];
    }
    // 发现击败敌人次数具有单调性
    // 我们如果想在q次攻击中击败一个敌人
    // 就会产生一个距离
    std::cout << binary_answer() << '\n';
}

void init() {
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