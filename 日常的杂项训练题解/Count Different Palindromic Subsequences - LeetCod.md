# Count Different Palindromic Subsequences - LeetCode

所有者: Zvezdy
标签: 区间动态规划, 字符串
创建时间: 2024年8月26日 15:52

在初步分析以后很容易想到两个相同字符可以套在它们之间任何一个回文子序列上组成一个全新的回文子序列，但这题有特殊的要求：去重，那么就来思考一下什么时候会重复，如果我们总是遵循讨论最外两个字符相等再链接里面的子序列的话，被算重复的就是里面有和我们最外层字符一样的字符，此时又分两种情况，一是里面只有一个字符，那么我们就多算了，一个单个的字符，二是里面有不止一个字符，那么我们就多算了单个、双个以及包围的部分，我们只需要用容斥原理去除包围的部分即可，为此我们需要打出一张表来记录离当前字符最近的相同字符的左边、右边位置。这里是对于最外层两个字符相同的情况，如果是最外层字符不同的情况，我们就看他们往左缩一格、往右缩一格能不能变为情况1，使用容斥可以简化这个讨论的过程。

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
const int MODE = 1e9 + 7;
array<array<long long, N>, N> dp;
array<pair<int, int>, N> beh;

class Solution {
   public:
    int countPalindromicSubsequences(string s) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }
        int last[] = {-1, -1, -1, -1};
        for (int i = 0; i < n; ++i) {
            beh[i].first = last[s[i] - 'a'];
            last[s[i] - 'a'] = i;
        }
        last[0] = last[1] = last[2] = last[3] = -1;
        for (int i = n - 1; i >= 0; --i) {
            beh[i].second = last[s[i] - 'a'];
            last[s[i] - 'a'] = i;
        }

        for (int l = n - 2; l >= 0; --l) {
            for (int r = l + 1; r < n; ++r) {
                if (s[l] != s[r]) {
                    dp[l][r] = dp[l + 1][r] + dp[l][r - 1] - dp[l + 1][r - 1] + MODE;
                    dp[l][r] %= MODE;
                } else {
                    int L = beh[l].second;
                    int R = beh[r].first;
                    if (L >= R) {
                        dp[l][r] = 2 * dp[l + 1][r - 1] + 1 + (L != R);
                        dp[l][r] %= MODE;
                    } else {
                        dp[l][r] = 2 * dp[l + 1][r - 1] - dp[L + 1][R - 1] + MODE;
                        dp[l][r] %= MODE;
                    }
                }
            }
        }
        return dp[0][n - 1];
    }
};

int main() {
    Solution solution;

    // 样例1
    string s1 = "cc";
    cout << "★样例1★:" << endl;
    int result1 = solution.countPalindromicSubsequences(s1);
    cout << result1 << endl;
    if (result1 == 6) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例2
    string s2 = "abcd";
    cout << "★样例2★:" << endl;
    int result2 = solution.countPalindromicSubsequences(s2);
    cout << result2 << endl;
    if (result2 == 4) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    // 样例3
    string s3 = "abcdabcdabcdabcdabcdabcdabcdabcddcbadcbadcbadcbadcbadcbadcbadcba";
    cout << "★样例3★:" << endl;
    int result3 = solution.countPalindromicSubsequences(s3);
    cout << result3 << endl;
    if (result3 == 104860361) {
        cout << "Accepted" << endl;
    } else {
        cout << "Wrong Answer" << endl;
    }
    cout << endl;

    return 0;
}

```
