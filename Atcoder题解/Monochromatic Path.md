# Monochromatic Path

所有者: Zvezdy
标签: 动态规划

遇到一路过来只能挨个试，一般就是DP，想到使用DP的话这一题的转移就非常好想了。设状态为到第i j格的位置时，有无翻转的最小代价，转移方程很好想。

重要的trick是遇到挨个试的格子题直接想到dp模拟。

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

const int N = 2e3 + 5;
int n, m;

int arr[N][N];
int r[N], c[N];
int f[N][N][2][2];

void Main_work() {
    std::cin >> n >> m;
    for (int i = 1; i <= n; ++i) std::cin >> r[i];
    for (int i = 1; i <= m; ++i) std::cin >> c[i];
    for (int i = 1; i <= n; ++i) {
        std::string s;
        std::cin >> s;
        for (int j = 0; j < m; ++j) {
            arr[i][j + 1] = s[j] == '1';
        }
    }
    for (int i = 0; i <= n; ++i) {
        for (int j = 0; j <= m; ++j) {
            for (int k = 0; k < 2; ++k) {
                for (int l = 0; l < 2; ++l) {
                    f[i][j][k][l] = 1e17;
                }
            }
        }
    }

    f[1][1][0][0] = 0;
    f[1][1][0][1] = c[1];
    f[1][1][1][0] = r[1];
    f[1][1][1][1] = r[1] + c[1];
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            for (int rc = 0; rc < 2; ++rc) {
                for (int cc = 0; cc < 2; ++cc) {
                    int cur = (arr[i][j] ^ rc ^ cc);
                    if ((arr[i - 1][j] ^ cc) == cur) {
                        f[i][j][rc][cc] = std::min(f[i][j][rc][cc], f[i - 1][j][0][cc] + rc * r[i]);
                    } else {
                        f[i][j][rc][cc] = std::min(f[i][j][rc][cc], f[i - 1][j][1][cc] + rc * r[i]);
                    }

                    if ((arr[i][j - 1] ^ rc) == cur) {
                        f[i][j][rc][cc] = std::min(f[i][j][rc][cc], f[i][j - 1][rc][0] + cc * c[j]);
                    } else {
                        f[i][j][rc][cc] = std::min(f[i][j][rc][cc], f[i][j - 1][rc][1] + cc * c[j]);
                    }
                }
            }
        }
    }
    int ans = 1e17;
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 2; ++j) {
            ans = std::min(ans, f[n][m][i][j]);
        }
    }
    std::cout << ans << '\n';
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