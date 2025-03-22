# F - Hammer 2

所有者: Zvezdy
标签: 区间动态规划

经过推敲不难发现状态是有一个左端点和右端点，为了方便转移以及判断，我们还需要多一个状态是：此时是在左端点还是在右端点上。结合数据量为1.5e3，容易判断这是一个n^2的区间DP。

使用循环进行区间DP的简单转移方式：因为该题是从小区间转移到大区间，所以外层优先枚举区间长度，内层枚举左端点，然后根据左端点推导右端点。此时枚举已经完成·。

接下来是状态，因为该题已经进行离散化，我们枚举的就是相对坐标，所以如果我们需要向左拓展，应该就是l-1，向右拓展应该就是r+1，进行状态转移的时候多判断是否越界。状态转移可以枚举被转移的状态然后看怎么转移过来，也可以枚举现在的状态然后看能转移到哪里去，因为这题中我们想进行转移必须拿到钥匙，而钥匙是否拿到我们就看我们已经走完的区间中是否包含我们所需的钥匙，所以转移应该是立足于我们已走完的区间，然后枚举我们能转移到的位置。

枚举的话直接遍历就行，从左扫到右，关键是优先枚举小区间。

```jsx
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

const int N = 1.5e3 + 5;
int n, x;

int m;
std::array<std::array<int, 2>, N> arr;
std::vector<std::array<int, 2>> pos(1);

int idx_x, idx_0;
void Prework() {
    m = pos.size() - 1;
    std::sort(pos.begin() + 1, pos.end());
    for (int i = 1; i <= m; ++i) {
        if (pos[i][0] == 0) {
            idx_0 = i;
        }
        if (pos[i][0] == x) {
            idx_x = i;
        }
    }
}

ll f[2 * N][2 * N][2];

void DP() {
    for (int i = 0; i <= m; ++i) {
        for (int j = 0; j <= m; ++j) {
            f[i][j][0] = f[i][j][1] = 1e15;
        }
    }
    f[idx_0][idx_0][0] = f[idx_0][idx_0][1] = 0;

    for (int len = 1; len < m; ++len) {
        for (int l = 1; l + len - 1 <= m; ++l) {
            int r = l + len - 1;

            if (l > 1 && !(pos[l - 1][1] > 0 && (arr[pos[l - 1][1]][1] < pos[l][0] || arr[pos[l - 1][1]][1] > pos[r][0]))) {
                f[l - 1][r][0] = std::min(f[l - 1][r][0], f[l][r][0] + pos[l][0] - pos[l - 1][0]);
                f[l - 1][r][0] = std::min(f[l - 1][r][0], f[l][r][1] + pos[r][0] - pos[l - 1][0]);
            }

            if (r < m && !(pos[r + 1][1] > 0 && (arr[pos[r + 1][1]][1] < pos[l][0] || arr[pos[r + 1][1]][1] > pos[r][0]))) {
                f[l][r + 1][1] = std::min(f[l][r + 1][1], f[l][r][0] + pos[r + 1][0] - pos[l][0]);
                f[l][r + 1][1] = std::min(f[l][r + 1][1], f[l][r][1] + pos[r + 1][0] - pos[r][0]);
            }
        }
    }

    ll ans = 1e15;
    for (int i = 1; i <= idx_x; ++i) {
        for (int j = idx_x; j <= m; ++j) {
            ans = std::min({ans, f[i][j][0], f[i][j][1]});
        }
    }
    if (ans == 1e15) {
        std::cout << "-1\n";
    } else {
        std::cout << ans << '\n';
    }
}

void Main_work() {
    std::cin >> n >> x;
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i][0];
        pos.push_back({arr[i][0], i});
    }
    for (int i = 1; i <= n; ++i) {
        std::cin >> arr[i][1];
        pos.push_back({arr[i][1], 0});
    }
    pos.push_back({x, 0});
    pos.push_back({0, 0});
    Prework();
    DP();
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