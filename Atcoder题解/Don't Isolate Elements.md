# Don't Isolate Elements

所有者: Zvezdy
标签: 动态规划

我们需要一行一行地判断是否需要反转，在手玩一些性质以后发现此题没有trick也没有贪心策略，考虑使用动态规划进行求解。我们可以设状态是第 i 行被转换或者没有被转换的时候，前 i 行都处于合法状态的最小操作次数。因为我们转移的顺序，所以可以说前 i-1 行一定都是合法的。判断能否转移就是设第 i 行、第 i-1 行、第 i-2 行的状态，开一个三重循环暴力枚举它们两两的状态，合法就进行转移。

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

const int N = 1e3 + 5;
int n, m;

int map[N][N];

int f[N][2][2];

bool check(int cur, int last, int next) {
    for (int i = 1, now; i <= m; ++i) {
        now = map[cur][i];
        if (now != map[cur][i + 1] && now != map[cur][i - 1] && now != (map[cur - 1][i] ^ last) && now != (map[cur + 1][i] ^ next)) {
            return false;
        }
    }
    return true;
}

inline int DP() {
    for (int i = 1; i <= n + 1; ++i) {
        for (int j = 0; j < 2; ++j) {
            for (int k = 0; k < 2; ++k) {
                f[i][j][k] = n + 1;
            }
        }
    }

    f[1][0][0] = 0, f[1][1][0] = 1;
    for (int i = 2; i <= n + 1; ++i) {
        // 当前行换、不换
        // 前面的行换、不换
        // 再前面的行换、不换
        for (int cur = 0; cur <= 1; ++cur) {
            for (int chk = 0; chk <= 1; ++chk) {
                for (int lst = 0; lst <= 1; ++lst) {
                    if (check(i - 1, chk ^ lst, cur ^ chk)) {
                        f[i][cur][chk] = std::min(f[i][cur][chk], f[i - 1][chk][lst] + cur);
                    }
                }
            }
        }
    }

    int ans = std::min(f[n + 1][0][0], f[n + 1][0][1]);
    if (ans > n) {
        return -1;
    } else {
        return ans;
    }
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 0; i <= n + 1; ++i) {
        for (int j = 0; j <= m + 1; ++j) {
            map[i][j] = 15;
        }
    }
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            std::cin >> map[i][j];
        }
    }
    std::cout << DP();
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