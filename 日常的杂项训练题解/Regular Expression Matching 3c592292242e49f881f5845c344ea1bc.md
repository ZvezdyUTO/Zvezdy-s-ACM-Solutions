# Regular Expression Matching

所有者: Zvezdy
标签: 动态规划, 完全背包
创建时间: 2024年8月14日 20:26

分类讨论处理问题的又一个典范，这回如果再嗯想状态转移，基本就是G了，但如果从记忆化搜索入手改位置依赖的动态规划会好下手很多。先推导一下base case：我们拿两个索引做下标遍历字符串，当两个下标都共同越界的时候，一定是我们找到了一个合法的字符串。如果是s字符串先到头，那么我们就可以考虑p字符串后面剩余的字符是不是x*y*z*这种形式，因为可以相消，如果是p字符串先到头，那就不可能完成匹配。接着来看中间的情况，因为有星号存在的时候匹配比较特殊，可以被延长，并且星号起作用必须依赖其前面一个的字符，所以我们每次判断的时候都是看当前下标的下一个字符是不是星号，如果不是星号或者到了字符串尽头，那么我们就只能匹配当前字符串，如果当前字符相等就继续下去，否则失败。如果有星号存在那么这一题就变成了完全背包问题，我么就可以如此讨论：此处直接跳过，不比了，或者往后比1个、2个、3个。。。这样一来我们记忆化搜索的解也就打好了。

最后是改为严格位置依赖的动态规划递推解。首先观察二维DP表可预打出base case的几种情况，接下从递推关系分析这些操作如何位置依赖，以此发现我们DP表需要从下往上、从右往左推。此处的枚举讨论和空间分析非常重要，也比较复杂。

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

class Solution {
   public:
    bool isMatch(string s, string p) {
        vector<vector<int>> save(s.size() + 1, vector<int>(p.size() + 1, -1));
        auto f = [&](auto& self, int i, int j) {
            if (save[i][j] != -1) {
                return (bool)save[i][j];
            }

            // Base case
            if (i == s.size()) {
                if (j == p.size()) {
                    save[i][j] = true;
                    return true;
                } else {
                    bool check = (j + 1 < p.size() && p[j + 1] == '*' && self(self, i, j + 2));
                    save[i][j] = check;
                    return check;
                }
            } else if (j == p.size()) {
                save[i][j] = false;
                return false;
            }

            if (j + 1 == p.size() || p[j + 1] != '*') {
                // 依赖i+1 j+1
                bool check = ((s[i] == p[j] || p[j] == '.') && self(self, i + 1, j + 1));
                save[i][j] = check;
                return check;
            } else {
                // 依赖 i j+2
                bool jup = self(self, i, j + 2);  // 跳过
                if (s[i] == p[j] || p[j] == '.') {
                    // 依赖i+1 j
                    jup |= self(self, i + 1, j);
                }
                save[i][j] = jup;
                return jup;
            }
        };

        int n = s.size();
        int m = p.size();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));
        dp[n][m] = true;
        for (int j = m - 1; j >= 0; --j) {
            dp[n][j] = (j + 1 < m && p[j + 1] == '*' && dp[n][j + 2]);
        }

        for (int i = n - 1; i >= 0; --i) {
            for (int j = m - 1; j >= 0; --j) {
                if (j + 1 == m || p[j + 1] != '*') {
                    dp[i][j] = (dp[i + 1][j + 1] && (s[i] == p[j] || p[j] == '.'));
                } else {
                    dp[i][j] = (dp[i][j + 2] || ((s[i] == p[j] || p[j] == '.') && dp[i + 1][j]));
                }
            }
        }

        return f(f, 0, 0);
        return dp[0][0];
    }
};

int main() {
    Solution solution;

    cout << "★样例1★:" << endl;
    string s1 = "ab";
    string p1 = "a.";
    cout << solution.isMatch(s1, p1) << endl;
    if (solution.isMatch(s1, p1) == false)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例2★:" << endl;
    string s2 = "aa";
    string p2 = "a*";
    cout << solution.isMatch(s2, p2) << endl;
    if (solution.isMatch(s2, p2) == true)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例3★:" << endl;
    string s3 = "ab";
    string p3 = ".*";
    cout << solution.isMatch(s3, p3) << endl;
    if (solution.isMatch(s3, p3) == true)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例4★:" << endl;
    string s4 = "aab";
    string p4 = "c*a*b";
    cout << solution.isMatch(s4, p4) << endl;
    if (solution.isMatch(s4, p4) == true)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例5★:" << endl;
    string s5 = "mississippi";
    string p5 = "mis*is*p*.";
    cout << solution.isMatch(s5, p5) << endl;
    if (solution.isMatch(s5, p5) == false)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```