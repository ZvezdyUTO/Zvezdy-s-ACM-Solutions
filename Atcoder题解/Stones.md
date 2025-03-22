# Stones

所有者: Zvezdy
标签: 动态规划, 博弈论

带博弈的动态规划题，和之前左神写的那道零和区间dp博弈不一样，这个实际上是背包（有限资源，消耗的大小不一），所以两个人的决策都应该使用动态规划进行。模拟一下两个人的策略就能写出转移方程：第一个人选择拿了arr[j]个石头以后，会剩余i-arr[j]个石头给下一个人，此时换为下一个人先手，那么我们可以记录dp[i]是还剩i个石头的时候，先手最多能获得多少石头，所以有转移方程dp[i]=std::max(dp[i], i-dp[i-arr[j]])，意思是当前i个，拿了剩i-arr[j]个石头，下个人先手会拿最多。

关键在于这个嵌套的思路，首先要想到双方都按最优策略来走，它们所能拿到的最终石头都是能用一个状态进行表示的。而在当前步骤、当前选择下，一个人能拿到的石头是自己的选择-另个人所能拿到的最多石头。由于我们的状态是由下往上构建的，所以我们一定能在下方取到答案。

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

const int N = 1e4 + 5;
const int K = 1e2 + 5;
int n, k;

int arr[K];

int f[N];

void Main_work() {
    std::cin >> n >> k;
    for (int i = 1; i <= k; ++i) {
        std::cin >> arr[i];
    }
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= k; ++j) {
            if (arr[j] > i) break;
            f[i] = std::max(f[i], i - f[i - arr[j]]);
        }
    }
    std::cout << f[n] << '\n';
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
    // std::cin >> Zvezdy;
    while (Zvezdy--) {
        Main_work();
    }
    return 0;
}
```