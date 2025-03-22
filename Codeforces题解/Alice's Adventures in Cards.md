# Alice's Adventures in Cards

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年11月16日 21:26

特殊限制：alice不能让自己的牌变小，凭借这一点就可以使用动态规划求解，因为没有后效性。设dp表为：第i个数可以被alic在xxx手中用?牌换到。接下来从左到右开始转移。一位一位看爱丽丝能从谁的手里面换到这张牌，一旦我们拥有这张牌，我们就可以继续进行转移，已知我们拿到喜好值更高的牌一定是最优的，所以我们依次从左到右寻找能拿到的喜好值最大牌。然后在看我们目前拥有最大的喜好牌能换到哪些牌。

把这些全部记录在dp表里面后，我们就可以用dp表进行跳跃，从n到1提取答案。这个dp转移方式就是一张图，因为该图每个点入度唯一，所以保证过程可逆。

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

const int N = 2e5 + 5;
int n;

std::array<std::array<int, N>, 3> arr;

std::array<std::array<int, N>, 3> rank;
std::array<int, 3> max;
std::array<std::array<int, 2>, N> jump;

inline void prework() {
    for (int i = 0; i < 3; ++i) {
        for (int j = 1; j <= n; ++j) {
            rank[i][arr[i][j]] = j;
        }
    }
    max = {arr[0][1], arr[1][1], arr[2][1]};  // 喜好最大值
    std::fill(jump.begin() + 1, jump.begin() + n + 1, std::array<int, 2>{-1, -1});
    jump[1] = {0, 0};

    for (int j = 2; j <= n; ++j) {
        for (int i = 0; i < 3; ++i) {
            // 如果有能换的，就记录一下
            if (max[i] > arr[i][j]) {
                jump[j] = {i, rank[i][max[i]]};
            }
        }
        // 换了以后每一位就不用回退了
        if (jump[j][0] != -1) {
            for (int i = 0; i < 3; ++i) {
                max[i] = std::max(max[i], arr[i][j]);
            }
        }
    }
}

std::vector<std::array<int, 2>> ans;

inline void check() {
    if (jump[n][0] == -1) {
        std::cout << "NO\n";
        return;
    }

    ans.clear();
    for (int i = n; i > 1;) {
        auto [j, x] = jump[i];
        ans.push_back({j, i});
        i = x;
    }
    std::reverse(ans.begin(), ans.end());
    std::cout << "YES\n";
    std::cout << ans.size() << '\n';
    for (auto [x, y] : ans) {
        std::cout << "qkj"[x] << ' ' << y << '\n';
    }
}

void Main_work() {
    std::cin >> n;
    for (int i = 0; i < 3; ++i) {
        for (int j = 1; j <= n; ++j) {
            std::cin >> arr[i][j];
        }
    }
    prework();
    check();
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