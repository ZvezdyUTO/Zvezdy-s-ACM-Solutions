# Erase Subarrays

所有者: Zvezdy
标签: 动态规划

朴素的状态转移好题。对于这种尝试类型的动态规划题目，我门首先要从它的操作方式下手，这个题目给出的操作方式就是挖空，然后不停地挖空，每个空是一段区间，区间的特征就是它的左右端点，我们根据这个左右端点进行枚举。一般来说对于区间都是固定右端点枚举左端点，我们固定右端点删除左端点区间的时候会发现我们删除区间的左边那个小区间是不会受到影响的，那么就可以继承那个小区间的答案，此时可以发现我们的状态 f(i, j) 就是对前i个数进行处理后变为j的最小代价。

我们可以选择不删，保留当前右端点，或者删除，这两个操作结合起来的转移方程就是：f[i][j]=min(f[i][j-arr[i]], min(f[i-k][j])+1)，枚举代价为O(n^2 m)，考虑优化。进行优化的时候我们仅在当前抽象层面上进行，这样可以减少无关信息干扰，发现后续f[i-k][j]实际上是前面取到 j 的最小操作次数，可以一次性存储完毕，于是优化掉一维，得出答案。

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

const int N = 3e3 + 5;
int n, m;

int arr[N];

int f[N][N];
int min[N];

void DP() {
    // 每次操作就是删除区间，这个区间有什么特征？
    // 小操作的特征：区间操作->端点
    // 如何讨论这些操作？枚举端点，枚举右端点
    // 枚举右端点讨论左端点，删除左右端点后，左边是什么？全取吗？或者利用之前的答案
    // 要想找到转移的方向，必须是目前的操作对转移前的操作没有任何影响，并且可以继承它
    // 继承自然是：我们目前考虑到1~i的子数组，取得j的最小代价。
    // 转移方程：1.不删这个右端点，直接继承arr[i] -> f[i][j]=f[i-1][j-arr[i]]
    // 2.考虑删除，那么就是一个个删并且从左边继承 -> f[i][j]=min(f[i-k][j])+1
    // 时间复杂度为O(n^2 m)，考虑进行优化
    // 考虑优化方程的时候，仅在当前的抽象层面上进行思考
    for (int i = 0; i <= n; ++i) {
        for (int j = 0; j <= m; ++j) {
            f[i][j] = N;
            min[j] = N;
        }
    }
    f[0][0] = 0;
    min[0] = 0;
    for (int i = 1; i <= n; ++i) {
        for (int j = 0; j <= m; ++j) {
            if (j >= arr[i]) f[i][j] = std::min(f[i][j], f[i - 1][j - arr[i]]);
            // for (int k = 0; k < i; ++k) {
            //     f[i][j] = std::min(f[i][j], f[k][j] + 1);
            // }
            f[i][j] = std::min(f[i][j], min[j] + 1);
            min[j] = std::min(min[j], f[i][j]);
        }
    }
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i];
    }
    DP();
    for (int i = 1; i <= m; ++i) {
        std::cout << (f[n][i] == N ? -1 : f[n][i]) << '\n';
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