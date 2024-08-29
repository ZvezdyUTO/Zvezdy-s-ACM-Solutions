# Valid Permutations for DI Sequence - LeetCode

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年8月28日 23:37

依旧是利用了分析来转化问题，如果先打记忆化搜索来枚举就可以发现，其实我们实际上放了什么数字不重要，重要的是此时是第几位，以及比这个数字小的剩余数字还有哪些。然后我们就可以开始讨论，我们假设第0位前面有一个D以及一个无穷大数字，这样第0位我们确实就可以随便放，依据此时我们做出的选择更新状态然后继续递归直到填满数字，此时我们获得的大概就是一个n^3复杂度的处理结果。我们依旧这个打出严格位置依赖的动态规划，可以发现其实是可以使用前缀和和后缀和优化为n^2复杂度的，进行修改优化即可。

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

const int N = 200;
const int MODE = 1e9 + 7;
array<array<long long, N + 2>, N + 2> dp;
array<array<long long, N + 2>, N + 1> save;

class Solution {
   public:
    int numPermsDISequence(string s) {
        int n = s.size();

        for (int i = 0; i <= n; ++i) {
            fill(save[i].begin(), save[i].begin() + n + 2, -1);
        }
        
        auto f = [&](auto& self, int i, int down) {
            if (i > n) {
                return 1ll;
            }
            if (save[i][down] != -1) {
                return save[i][down];
            }
            long long res = 0;
            if (i == 0 || s[i - 1] == 'D') {
                for (int less = 0; less < down; ++less) {
                    res += self(self, i + 1, less);
                    res %= MODE;
                }
            } else {
                for (int less = down; less < n - i + 1; ++less) {
                    res += self(self, i + 1, less);
                    res %= MODE;
                }
            }
            save[i][down] = res;
            return res;
        };

        // return (int)f(f, 0, n + 1);

        for (int i = 0; i <= n; ++i) {
            fill(dp[i].begin(), dp[i].begin() + n + 2, 0);
        }
        // 放到n+1的时候刚好放完
        for (int i = 0; i <= n + 1; ++i) {
            dp[n + 1][i] = 1;
        }

        // 一共需要放n+1个数，一个一个放
        for (int i = n; i >= 0; --i) {
            if (i == 0 || s[i - 1] == 'D') {
                // 挨个枚举此时剩余的较小数
                // 无所谓j的枚举顺序，实际上我们依赖的是下一行的所有元素
                // 此处和记忆化搜索的环节一样
                for (int j = 1; j <= n + 1; ++j) {
                    // for (int k = 0; k < j; ++k) {
                    //     dp[i][j] += dp[i + 1][k];
                    //     dp[i][j] %= MODE;
                    // }
                    dp[i][j] += dp[i + 1][j - 1];
                    dp[i + 1][j] += dp[i + 1][j - 1];
                    dp[i][j] %= MODE;
                    dp[i + 1][j] %= MODE;
                }
            } else {
                // for (int j = 0; j <= n; ++j) {
                //     for (int k = j; k <= n - i; ++k) {
                //         dp[i][j] += dp[i + 1][k];
                //         dp[i][j] %= MODE;
                //     }
                // }
                for (int j = n - i; j >= 0; --j) {
                    dp[i][j] += dp[i + 1][j];
                    dp[i][j] %= MODE;
                    if (j) {
                        dp[i + 1][j - 1] += dp[i + 1][j];
                        dp[i + 1][j - 1] %= MODE;
                    }
                }
            }
        }
        return dp[0][n + 1];
    }
};

int main() {
    Solution solution;

    string s1 = "I";
    cout << "★样例1★:" << endl;
    cout << solution.numPermsDISequence(s1) << endl;
    if (solution.numPermsDISequence(s1) == 1)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```
