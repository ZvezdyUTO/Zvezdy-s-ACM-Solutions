# K Inverse Pairs Array - LeetCode

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年8月29日 10:45

对于这种含有数字大小关系的题目，把数字从小到大枚举可能有奇效，比如如果我们把这题的状态设为考虑前i个数，能组成j个逆序对情况的话，我们就讨论最后一个数的插入位置即可，因为最后一个数字一定是当前最大，所以在某个地方插入，就可以和后面所有数字组成逆序对并且不影响前面的数字。那么转移方式自然就是dp[前一个数][我们目前所需要的逆序对数量-在当前位置插入能够多出的逆序对]，记得考虑边界情况。打出初代转移方程后观察可得，当i>j的时候，我们依赖上一层0~j的和，当i≤j的时候，我们依赖上一层j-i-i~j的和，那么就可以使用前缀和优化枚举。

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

const int N = 1000;
const int K = 1000;
const int MODE = 1e9 + 7;
array<array<long long, K + 1>, N + 1> dp;
// 考虑前i个数，此时有j个逆序对的插法

class Solution {
   public:
    int kInversePairs(int n, int k) {
        for (int i = 1; i <= n; ++i) {
            fill(dp[i].begin() + 1, dp[i].begin() + k + 1, 0);
        }
        dp[0][0] = 1;
        // 原本有的逆序对加上新增的逆序对
        // 考虑从小到大这么遍历数字，考察在每一处可能的位置插入我们当前考虑的数字
        // 怎么进行转移？
        for (int i = 1; i <= n; ++i) {
            dp[i][0] = 1;
            for (int j = 1; j <= k; ++j) {
                // 考虑i-1个数字的时候，原本已经有多少个逆序对？
                if (i > j) {
                    // 依赖从0加到j
                    // for (int k = 0; k <= j; ++k) {
                    //     dp[i][j] += dp[i - 1][k];
                    //     dp[i][j] %= MODE;
                    // }
                    dp[i][j] += dp[i - 1][j];
                    dp[i][j] %= MODE;
                } else {
                    // 依赖从j-i-1加到j
                    // for (int k = j - i + 1; k <= j; ++k) {
                    //     dp[i][j] += dp[i - 1][k];
                    //     dp[i][j] %= MODE;
                    // }
                    dp[i][j] += dp[i - 1][j] - dp[i - 1][j - i] + MODE;
                    dp[i][j] %= MODE;
                }
                dp[i][j] += dp[i][j - 1];
                dp[i][j] %= MODE;
            }
        }
        return dp[n][k];
    }
};
// 这种逆序对正序对插入的问题，把数字从小到大枚举有奇效
// 然后可以按照插入位置来进行状态转移

int main() {
    Solution solution;

    cout << "★样例1★:" << endl;
    int result1 = solution.kInversePairs(3, 0);
    cout << result1 << endl;
    if (result1 == 1)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例2★:" << endl;
    int result2 = solution.kInversePairs(3, 1);
    cout << result2 << endl;
    if (result2 == 2)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```