# Predict the Winner - LeetCode

所有者: Zvezdy
标签: 区间动态规划, 博弈论
创建时间: 2024年8月26日 09:01

可能是数据范围太小，不然不止medium。按左右端点可能性讨论并且展开，是典型的区间DP特征，但这题还需要注意的是它是一道博弈论，也就是两个玩家都需要做出最佳的抉择。这里有一个trick，既然是零和游戏，那么对于玩家2来说，只要玩家1拿的足够少，一定是优的，基于此结论，我们就可以同时讨论玩家1和玩家2的最优决策，那就是在玩家1拿左、右的情况下，玩家2拿左、拿右，留给玩家1最少，同时玩家1需要在拿左拿右中选出最优策略。

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

const int N = 20;
array<array<int, N + 1>, N + 1> dp;

class Solution {
   public:
    bool PredictTheWinner(vector<int>& nums) {
        int n = nums.size();
        int sum = accumulate(nums.begin(), nums.end(), 0);
        auto f = [&](auto& self, int l, int r) {
            if (l == r) {
                return nums[l];
            }
            if (l == r - 1) {
                return max(nums[l], nums[r]);
            }
            int res = 0;
            int p1 = nums[l] + min(self(self, l + 2, r), self(self, l + 1, r - 1));  // 依赖l+2,r；l+1,r-1
            int p2 = nums[r] + min(self(self, l + 1, r - 1), self(self, l, r - 2));  // 依赖l+1,r-1；l,r-2
            res += max(p1, p2);
            return res;
        };
        /*
        int p = f(f, 0, n - 1);
        if (2 * p >= sum) {
            return true;
        } else {
            return false;
        }
        */
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                dp[i][j] = 0;
            }
        }
        dp[n - 1][n - 1] = nums[n - 1];
        for (int i = 0; i < n - 1; ++i) {
            dp[i][i] = nums[i];
            dp[i][i + 1] = max(nums[i], nums[i + 1]);
        }
        for (int i = n - 3; i >= 0; --i) {
            for (int j = i + 2; j < n; ++j) {
                dp[i][j] += max(min(dp[i + 2][j], dp[i + 1][j - 1]) + nums[i], min(dp[i][j - 2], dp[i + 1][j - 1]) + nums[j]);
            }
        }
        debug(dp[0][n - 1]);
        // debug(sum);
        if (2 * dp[0][n - 1] >= sum) {
            return true;
        } else {
            return false;
        }
    }
};

int main() {
    Solution solution;

    // 样例1
    vector<int> nums1 = {1, 567, 1, 1, 99, 100};
    cout << "★样例1★:" << endl;
    bool result1 = solution.PredictTheWinner(nums1);
    cout << result1 << endl;
    if (result1 == true) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例2
    vector<int> nums2 = {1, 5, 233, 7};
    cout << "★样例2★:" << endl;
    bool result2 = solution.PredictTheWinner(nums2);
    cout << result2 << endl;
    if (result2 == true) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    return 0;
}

```