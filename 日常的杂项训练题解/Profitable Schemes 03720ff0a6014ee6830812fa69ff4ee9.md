# Profitable Schemes

所有者: Zvezdy
标签: 动态规划, 组合数学
创建时间: 2024年8月10日 19:35

看上去很一眼很板的二维费用01背包求方案数，当然也比较典。先从记忆化搜索来分析这一题的思路：对于每一种方案，我们都可以选择做或者不选择做。假如我们的人耗尽了，或者方案数遍历到头了，代表此时我们得到了一种方案，此时我们再检查利润是否达到预期，如果达到了预期，我们就可以返回1代表找到一个合法方案。每次我们都把选择 / 不选择的方案加起来，就是我们最终的答案。

然后根据这个信息我们就可以推导出严格位置依赖的动态规划，并且压缩一维空间，考虑到我们已经压缩了方案种类这个维度，我们直接在剩余利润需求为0处全部打上1就好。最后死板地跑完01背包的滚动数组优化。

求合法方案组合数这一块，只要我们把每个必合法方案的base case打为1，剩余的就在方案的选择之中转移累加就好。

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
    int profitableSchemes(int n, int minProfit, vector<int>& group, vector<int>& profit) {
        int m = group.size();
        int MODE = 1e9 + 7;

        // 记忆化搜索
        vector<vector<vector<long long>>>
            save(n + 1, vector<vector<long long>>(m + 1, vector<long long>(minProfit + 1, -1)));
        auto f = [&](auto& self, int it, int men, int need) {
            if (men == 0) {
                return need <= 0 ? 1ll : 0ll;
            }
            if (it == m) {
                return need <= 0 ? 1ll : 0ll;
            }
            if (save[men][it][need] != -1) {
                cout << men << " " << it << " " << need << endl;
                return save[men][it][need];
            }
            long long res = self(self, it + 1, men, need) % MODE;
            if (men >= group[it]) {
                res += self(self, it + 1, men - group[it], max(need - profit[it], 0));
            }
            save[men][it][need] = res % MODE;
            return res % MODE;
        };
        return (int)f(f, 0, n, minProfit);

        // 背包动态规划
        vector<vector<int>> dp(n + 1, vector<int>(minProfit + 1, 0));
        for (int i = 0; i <= n; ++i) {
            dp[i][0] = 1;
        }
        for (int i = 0; i < m; ++i) {
            for (int men = n; men >= group[i]; --men) {
                for (int need = minProfit; need >= 0; --need) {
                    dp[men][need] += dp[men - group[i]][max(0, need - profit[i])];
                    dp[men][need] %= MODE;
                }
            }
        }
        return dp[n][minProfit];
    }
};

int main() {
    Solution solution;

    int n1 = 5, minProfit1 = 3;
    vector<int> group1 = {2, 2}, profit1 = {2, 3};
    cout << "★样例1★:" << endl;
    cout << solution.profitableSchemes(n1, minProfit1, group1, profit1) << endl;
    if (solution.profitableSchemes(n1, minProfit1, group1, profit1) == 2)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    int n2 = 10, minProfit2 = 5;
    vector<int> group2 = {2, 3, 5}, profit2 = {6, 7, 8};
    cout << "★样例2★:" << endl;
    cout << solution.profitableSchemes(n2, minProfit2, group2, profit2) << endl;
    if (solution.profitableSchemes(n2, minProfit2, group2, profit2) == 7)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```