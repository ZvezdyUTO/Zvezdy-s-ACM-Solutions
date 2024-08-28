# Scramble String

所有者: Zvezdy
标签: 动态规划, 字符串
创建时间: 2024年8月11日 08:39

这题可以精妙地体现出递归的思想对DP方案的重要性，初见这题可能觉得无从下手，但如果从base case开始思考就会发现：如果两个串都只有一个字符，那么它们一定互为扰乱字符串。问题就是这个扰乱字符串的关系涉及到交换这个重要步骤，我们可以通过递归枚举的过程来实现这个步骤。

那么现在就可以打出记忆化搜索，我们把状态设置为A串的l1~r1与B串的l2~r2互为扰乱字符串，当我们递归到两个串都各只剩单个字符的时候就返回true。不考虑交换的情况下，我们就枚举两个字符串的共同分割点，当分割点左边互为扰乱字符串且分割点右边互为扰乱字符串的时候直接返回true。最后就是考虑如何判断交错下的情况了，这时我们可以通过调整校对区间来实现交换。依然是枚举A串的划分点，但这次不同的是，B串的划分点和A串是关于它们中点对称的，所以我们枚举好划分点之后，就按长度分别判断两个对应串是否互为扰乱串即可。

最后是状态压缩的问题，可以发现我们正在判断的两个串长度相同，所以我们可以只拿A串左端点、B串左端点和它们的长度作为参数传递。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include <bits/stdc++.h>
using namespace std;
#define debug(x) cout << #x << " = " << x << endl

class Solution {
   public:
    bool isScramble(string s1, string s2) {
        int n = s1.size();
        vector<vector<vector<int>>> save(n, vector<vector<int>>(n, vector<int>(n + 1, -1)));
        auto f = [&](auto& self, int l1, int l2, int len) {
            if (len == 1) {
                return s1[l1] == s2[l2];
            }
            if (save[l1][l2][len] != -1) {
                return (bool)save[l1][l2][len];
            }
            for (int k = 1; k < len; ++k) {
                if (self(self, l1, l2, k) && self(self, l1 + k, l2 + k, len - k)) {
                    save[l1][l2][len] = true;
                    return true;
                }
            }
            for (int i = l1 + 1, j = l2 + len - 1, k = 1; k < len; ++i, --j, ++k) {
                if (self(self, l1, j, k) && self(self, i, l2, len - k)) {
                    save[l1][l2][len] = true;
                    return true;
                }
            }
            save[l1][l2][len] = false;
            return false;
        };
        return f(f, 0, 0, n);
    }
};

int main() {
    Solution solution;

    cout << "★样例1★:" << endl;
    cout << solution.isScramble("great", "rgeat") << endl;
    if (solution.isScramble("great", "rgeat") == true)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例2★:" << endl;
    cout << solution.isScramble("abcde", "caebd") << endl;
    if (solution.isScramble("abcde", "caebd") == false)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    cout << "★样例3★:" << endl;
    cout << solution.isScramble("a", "a") << endl;
    if (solution.isScramble("a", "a") == true)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}
// 条件：长度相同
```