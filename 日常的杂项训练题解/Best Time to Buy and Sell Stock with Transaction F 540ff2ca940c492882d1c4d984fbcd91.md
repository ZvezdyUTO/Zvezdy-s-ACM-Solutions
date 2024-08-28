# Best Time to Buy and Sell Stock with Transaction Fee - LeetCode

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年8月28日 20:59

一个简单的小题，把我折磨住了。这题如果嗯想枚举可能卡半天，但是如果要看我们怎么从已经打出的状态进行转移，那么就会明了。首先我们可以假设我们在某一步需要卖出股票，那么一定是之前有一个时刻我们买入了股票，并且已经支付了手续费，这样在卖出的时候我们就可以拿它加上卖出的收益变为我们当前的真实收益，那么我们如何找到这个买入的时刻？唯一可以确定的就是买入这支股票之前我们一定做出了所有最优的决策，那么我们肯定需要一个状态来代表此时的最优结果。我们用之前的最好结果减去手续费与当前买入的代价，如果发现比之前的买入所获得的收益更好，我们就暂且选择在此时买入它，买入点只需要评价当前买入是否比前面要好就行，拍板就交给判断卖出，只要拿当前这个买入收益加上当前卖出收益就可以PK真实收益。

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
    int maxProfit(vector<int>& a, int fee) {
        int n = a.size();
        int ans = 0;
        int buy = -a[0] - fee;
        for (int i = 1; i < n; ++i) {
            ans = max(ans, a[i] + buy); // 挑选最好的卖出点
            buy = max(buy, ans - fee - a[i]); // 挑选最好的买入点
        }
        return ans;
    }
};

int main() {
    Solution solution;

    // 样例1
    vector<int> prices1 = {1, 3, 2, 8, 4, 9};
    int fee1 = 2;
    cout << "★样例1★:" << endl;
    cout << solution.maxProfit(prices1, fee1) << endl;
    cout << (solution.maxProfit(prices1, fee1) == 8 ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    // 样例2
    vector<int> prices2 = {1, 3, 7, 5, 10, 3};
    int fee2 = 3;
    cout << "★样例2★:" << endl;
    cout << solution.maxProfit(prices2, fee2) << endl;
    cout << (solution.maxProfit(prices2, fee2) == 6 ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    return 0;
}
```