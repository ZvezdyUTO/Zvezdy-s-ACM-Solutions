# Empty Graph

所有者: Zvezdy
标签: 二分答案, 思维
创建时间: 2025年1月19日 20:14

纯纯思维题，题目给出的最重要性质就是完全图，以及两点之间距离为原数组中两点之间最小值。已知一张图中的直径是最长的两点之间最短路，这题又是完全图，那么直径一定存在于某两点的连边之间。我们随机假设两个点，可以发现它最短路有两种：1是直接取原数组两点之间最小值，2是从外面走，随便找一个点中转然后再从那个点走到另个点，易知此代价为2*整个数组最小值，因为我们的路长是一段区间的最小值。据此得到公式：dist=max(min(arr[i]~arr[j], 2*minst(arr)))

因为取的是区间最小值或者双倍全局最小值，所以让两点之间的元素数量越小一定越好，所以永远选取相邻两点，发现此题贪心比较麻烦，并且我们想贪心求出的元素具有明显的正反性，所以考虑二分答案求解。

根据公式，我们首先要排除的就是数组中小于dist/2的部分，当排除这些部分之后，根据我们手头剩余的操作次数来进行判断。因为要保证公式的前半部分是满足的，分类讨论就好。

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
    int n, k;
    std::cin >> n >> k;
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> arr[i];
    }
    int l = 0, r = 1e9;
    auto check = [&](int goal) {
        int cur = k;
        int maxn = 0;
        std::vector<int> tmp = arr;
        for (int i = 0; i < n; ++i) {
            if (2 * tmp[i] < goal) {
                tmp[i] = 1e9;
                --cur;
            }
            maxn = std::max(maxn, tmp[i]);
        }
        if (cur < 0) return false;
        int maxp = 0;
        for (int i = 0; i + 1 < n; ++i) {
            maxp = std::max(maxp, std::min(tmp[i], tmp[i + 1]));
        }
        if (maxp < goal && cur <= 1) {
            if (cur == 1) {
                return maxn >= goal;
            } else {
                return false;
            }
        }
        return true;
    };
    while (l < r) {
        int mid = (l + r + 1) / 2;
        if (check(mid)) {
            l = mid;
        } else {
            r = mid - 1;
        }
    }
    std::cout << l << '\n';
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