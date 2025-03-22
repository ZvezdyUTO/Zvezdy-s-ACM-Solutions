# Penchick and Desert Rabbit

所有者: Zvezdy
标签: 思维, 树状数组
创建时间: 2024年11月16日 08:57

题意是往右只能跳更低的，往左能跳更高的，首先敏锐地发现它们的单调性：假如不能往右跳，那么能让一个数变大的可能性就是它往左跳到一个更高的，而且因为它的跳跃路径是一个从左到右严格递减的子序列，那么能够保证，越往右一定就是越优的。因为如果它本身的值很大，那么它就是优的，如果它的值很小，那么它就会尽可能地享有左边所有的大值。分这些不同的情况讨论出来以后，我们可以发现它们背后的一致性。那如果我们让所有数都能跳到最右处，再从最右处往左跳一定是优的，这里有第二个单调性：一个数越大，它往右跳的距离一定越远。而一个数的变大过程只能有两种可能，一是它不往右跳，只往左跳收货最大值，二是它现往左跳了一个最大值，然后借助这个最大值往右跳最远，以此蹦到最大值，一个数往左能跳到的最高处我们是可以从左到右扫描一遍得出的，现在是如何求它们从左往右能跳到的最远处。我们这里依赖两个指标：1.它只能往比自己低的地方跳，2.它只能往右边跳，如果它不只能往右边跳，这种动态维护区间最值然后单点插入我们可以使用BIT实现。

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

const int N = 5e5 + 5;
int n;

std::array<int, N> arr;

std::array<int, N> ans;
std::array<int, N> BIT;
void add(int i, int rank) {
    while (i <= n) {
        BIT[i] = std::max(BIT[i], rank);
        i += i & -i;
    }
}
int get_max(int i) {
    int res = -1;
    while (i > 0) {
        res = std::max(res, BIT[i]);
        i -= i & -i;
    }
    return res;
}

inline void scan() {
    // 能往高处跳的只能是从右往左
    // 能往低处跳的只能是从左往右
    // 所以实际上先从左往右递推处理一遍就拿到初始的大小
    for (int i = 1, max = arr[1]; i <= n; ++i) {
        max = std::max(max, arr[i]);
        ans[i] = max;
    }
    // 然后就是第二次跳转
    // 因为大数可以往右跳，然后再从右往左跳
    // 单调性，如果一个数能往右跳到另一个数上面
    // 然后那个数能继续往右跳，那么上个数也能往右跳
    // 越是右边的数，拿到最大值可能性就越大
    // 所以有一个重要的贪心策略：尽可能地往右边跳
    std::fill(BIT.begin(), BIT.begin() + n + 1, 0);
    for (int i = n, far = n, min = arr[n]; i >= 1; --i) {
        // 怎么才能知道自己能跳多远？
        // 如果右边的数组有序，那么就可以知道
        // 1.在自己右边
        // 2.比自己小
        // 3.树状数组求最大值
        // 一个数可以往自己左边跳了以后往右跳
        // 所以是拿一个数能弄到的最大值来判断
        add(arr[i], i);
        int cur = get_max(ans[i] - 1);
        ans[i] = std::max(ans[i], ans[cur]);
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    scan();
    for (int i = 1; i <= n; ++i) {
        std::cout << ans[i] << ' ';
    }
    std::cout << '\n';
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