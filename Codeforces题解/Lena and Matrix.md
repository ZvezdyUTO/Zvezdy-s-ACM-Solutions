# Lena and Matrix

所有者: Zvezdy
标签: 几何
创建时间: 2025年2月27日 09:54

这题让我们找到一个平均曼哈顿距离最短的点，如果按照暴力的方法，那就是筛选出所有黑色的点，并在遍历矩阵时挨个比对。现在考虑更优的做法，如果我们要求的不是曼哈顿距离的最值而是切比雪夫距离的最值，那么我们就不是比对双配合变量而是只用比对单变量，就可以减少一维的枚举代价。由这个条件我们可以使用坐标变换讲曼哈顿距离变换为切比雪夫距离，变换方式是(x, y) → (x+y, x-y)，已知这样做变换后的切比雪夫距离就是原来的曼哈顿距离，那么我们进行比对的时候就可以严格减少一维的枚举量。于是我们只用求出新坐标下x和y的两个极端最值并进行枚举pk即可。

以后遇到曼哈顿距离最大半径匹配的时候，就可以使用该思路转换为切比雪夫距离匹配优化。

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

std::array<std::string, N> map;

int max_x, min_x, max_y, min_y;

void Get_limit() {
    max_x = max_y = -1e15;
    min_x = min_y = 1e15;
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            if (map[i][j - 1] == 'B') {
                int x = i + j, y = i - j;
                max_x = std::max(max_x, x);
                min_x = std::min(min_x, x);
                max_y = std::max(max_y, y);
                min_y = std::min(min_y, y);
            }
        }
    }
}

std::array<int, 2> Find_ans() {
    int min = 1e15;
    std::array<int, 2> ans;
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            int x = i + j, y = i - j;
            int cur = std::max({max_x - x, x - min_x, max_y - y, y - min_y});
            if (cur < min) {
                min = cur;
                ans = {i, j};
            }
        }
    }
    return ans;
}

void Main_work() {
    std::cin >> n >> m;
    for (int i = 1; i <= n; ++i) {
        std::cin >> map[i];
    }
    Get_limit();
    auto [x, y] = Find_ans();
    std::cout << x << ' ' << y << '\n';
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