# Minimum Score Triangulation of Polygon - LeetCode

所有者: Zvezdy
标签: 区间动态规划
创建时间: 2024年8月26日 10:05

也算是一个比较好的实例来说明依据实际例子进行手玩来推导抽象的动态规划过程的重要性。在枚举划分点后可以发现，对于这一题来说只要是相邻的点一定是会被纳入同一个三角形的，并且划分点和原来的左右端点都会被用于接下来的计算中。我们据此可以打出一个暴力的搜索版本，接着画出缓存表，从头开始一个个模拟依赖关系，就能打出最终的递推过程。

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

const int N = 100;
array<array<int, N>, N> dp;

class Solution {
   public:
    int minScoreTriangulation(vector<int>& values) {
        int n = values.size();
        auto f = [&](auto& self, int l, int r) {
            if (r - l < 2) {
                return 0;
            }
            int res = 0x7fffffff;
            for (int i = l + 1; i < r; ++i) {
                res = min(res, values[l] * values[r] * values[i] + self(self, l, i) + self(self, i, r));
                // 在每个l,r里面枚举i，同时依赖l,i和i,r
            }
            return res;
        };
        // return f(f, 0, n - 1);

        for (int i = n - 2; i >= 0; --i) {
            for (int j = i + 2; j < n; ++j) {
                dp[i][j] = 0x7fffffff;
                for (int l = i + 1; l < j; ++l) {
                    dp[i][j] = min(dp[i][j], dp[i][l] + dp[l][j] + values[i] * values[j] * values[l]);
                }
            }
        }
        return dp[0][n - 1];
    }
};

int main() {
    Solution solution;

    // 样例1
    vector<int> values1 = {1, 2, 3};
    cout << "★样例1★:" << endl;
    int result1 = solution.minScoreTriangulation(values1);
    cout << result1 << endl;
    if (result1 == 6) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例2
    vector<int> values2 = {3, 7, 4, 5};
    cout << "★样例2★:" << endl;
    int result2 = solution.minScoreTriangulation(values2);
    cout << result2 << endl;
    if (result2 == 144) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例3
    vector<int> values3 = {1, 3, 1, 4, 1, 5};
    cout << "★样例3★:" << endl;
    int result3 = solution.minScoreTriangulation(values3);
    cout << result3 << endl;
    if (result3 == 13) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    return 0;
}

```