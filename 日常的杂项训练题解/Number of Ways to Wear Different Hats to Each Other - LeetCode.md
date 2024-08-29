# Number of Ways to Wear Different Hats to Each Other - LeetCode

所有者: Zvezdy
标签: 状态压缩动态规划
创建时间: 2024年8月27日 16:14

这题写的还是非常吃力，码力太差了，，一如既往地，使用记忆化搜索来实现组合数，当找到满足的方案的时候就返回1，这写起来还是非常简单的。观察这一题，发现如果枚举帽子的话状态会爆，但是枚举人就不会，所以考虑改为当前已经满足哪些人。那么每次就是找当前帽子能满足哪些人，然后把所有可能性都试一遍，包括这个帽子完全不用。如果发现状态满了就返回1，发现帽子用完了还没达成目标就返回0。我们打出二维的状态，因为我们总是从左到右扫描一遍帽子，这可以表现出我们有使用了哪些帽子而哪些还没使用，我们的一维状态就是我们当前满足人数的状态，另一维状态就是我们当前使用了哪些帽子。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#include <bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl
inline const auto optimize = []() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(0), std::cout.tie(0);
    return 0;
}();

const int N = 10;
const int M = 40;
const int MODE = 1e9 + 7;
array<int, M + 1> sat;
array<array<int, 1 << N>, M + 1> save;

class Solution {
   public:
    int numberWays(vector<vector<int>>& hats) {
        int n = hats.size();
        int m = 0;

        for (int i = 0; i <= M; ++i) {
            sat[i] = 0;
        }

        for (int i = 0; i < n; ++i) {
            for (auto col : hats[i]) {
                sat[col] |= 1 << i;
                m = max(m, col);
            }
        }

        for (int i = 0; i <= M; ++i) {
            for (int j = 0; j <= (1 << n) - 1; ++j) {
                save[i][j] = -1;
            }
        }

        auto f = [&](auto& self, int sta, int i) {
            if (sta == (1 << n) - 1) {
                return 1ll;
            }
            if (i > m) {
                return 0ll;
            }
            if (save[i][sta] != -1) {
                return (long long)save[i][sta];
            }

            long long res = self(self, sta, i + 1);
            int satis = sat[i];
            while (satis) {
                int cur = satis & -satis;
                if ((sta & cur) == 0) {
                    res = (res + self(self, sta | cur, i + 1)) % MODE;
                }
                satis ^= cur;
            }
            save[i][sta] = res;
            return res;
        };

        return (int)f(f, 0, 1);
    }
};

int main() {
    Solution solution;

    // 样例 1
    vector<vector<int>> hats1 = {{3, 4}, {4, 5}, {5}};
    cout << "★样例1★:" << endl;
    cout << solution.numberWays(hats1) << endl;
    if (solution.numberWays(hats1) == 1) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例 2
    vector<vector<int>> hats2 = {{3, 5, 1}, {3, 5}};
    cout << "★样例2★:" << endl;
    cout << solution.numberWays(hats2) << endl;
    if (solution.numberWays(hats2) == 4) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    return 0;
}

```
