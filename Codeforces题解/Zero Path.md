# Zero Path

所有者: Zvezdy
标签: 动态规划, 思维
创建时间: 2025年2月25日 16:43

有意思的小计数题，其实可以用bitset草过去，但是它背后蕴含的证明很有意思。这题给的矩阵中只有1或者-1出现，而且我们的路径严格就是走n+m-1个点，所以如果n+m-1为奇数一定不可能有解。另外，我们把我们路径步骤抽象出来，可以发现一定有n个D和m个R，对于每条独特的路径，我们可以通过一点一点的修改将它们变成任何一条其它路径，如果仔细观察的话，可以发现每次修改只会有如下几种变化：-2, 0, +2，不可能有其它的了，这里同时意味着，如果我们求出了一个我们能拿到的最大值和最小值，只要最终答案包含在这个区间中，我们就一定能拿到解。

这里同时给出了一种全新的证明思路，我们在一堆选择中做出了一个选择，这些不同的选择可以通过单位性的变化进行互换，根据每次单位性变化带来的影响，可以揭示一些规律，或者发现只要在一个有效区间中的值我们都可以取到。

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

const int N = 1e3 + 5;
int n, m;

int arr[N][N];

int f1[N][N], f2[N][N];  // max min

void Main_work() {
    std::cin >> n >> m;
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            std::cin >> arr[i][j];
            f1[i][j] = -1e15;
            f2[i][j] = 1e15;
        }
    }
    for (int i = 1; i <= n; ++i) {
        f1[i][1] = f2[i][1] = f1[i - 1][1] + arr[i][1];
    }
    for (int i = 1; i <= m; ++i) {
        f1[1][i] = f2[1][i] = f1[1][i - 1] + arr[1][i];
    }

    for (int i = 2; i <= n; ++i) {
        for (int j = 2; j <= m; ++j) {
            f1[i][j] = std::max(f1[i - 1][j], f1[i][j - 1]) + arr[i][j];
            f2[i][j] = std::min(f2[i - 1][j], f2[i][j - 1]) + arr[i][j];
        }
    }

    if ((n + m) % 2 && f1[n][m] >= 0 && f2[n][m] <= 0) {
        std::cout << "YES\n";
    } else {
        std::cout << "NO\n";
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