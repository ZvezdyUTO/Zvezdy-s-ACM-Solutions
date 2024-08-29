# Distribute Repeating Integers - LeetCode

所有者: Zvezdy
标签: 位运算, 状态压缩动态规划
创建时间: 2024年8月28日 09:09

可以参考帽子那一题，如果我们有两个状态，那么我们只需要在遍历一个状态的时候扫描另一个状态的所有可能变化情况就能完成讨论。而这个可以成为状压DP选择状态的关键。再看回这一题，稍作分析之后发现真正关键的就是词频以及顾客所需的数量，因此我们对数组做处理以后就可以把不需要的信息丢弃，直接来处理关键的信息。

用户数量就只有10个，那我们就可以从此处下手，因为我们每次都是看使用当前这个数字能不能完成某些操作，所以我们就预先计算出同时满足某些用户需要多少相同数字，然后我们就可以拿这个信息来进行状态转移。

这里涉及到了两个技巧：1是枚举同时满足某些用户要多少相同数字，我们采用叠加的方法来处理这个数据，如果我们能从以前的数据加上当前我们所需要加入的新用户的数据，我们就可以生成出所有状况的数据。外层循环枚举用户，内层循环枚举小于1<<该用户编号的所有状况，这样可以有效避免重复。2是快速枚举一个状态的所有子集，这也是为什么我们需要用1来表示还未满足。使用公式`for (int j = sta; j; j = j - 1 & sta)` 可以完成这个任务。

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

const int M = 10;
const int N = 50;
array<int, N> freq;
array<int, 1 << M> need;
array<array<int, 1 << M>, N> save;

class Solution {
   public:
    bool canDistribute(vector<int>& nums, vector<int>& quantity) {
        sort(nums.begin(), nums.end());
        int m = -1;
        for (int i = 0, last = -1; i < nums.size(); ++i) {
            if (nums[i] != last) {
                ++m;
                last = nums[i];
                freq[m] = 0;
            }
            ++freq[m];
        }

        fill(need.begin(), need.begin() + (1 << quantity.size()), 0);
        for (int i = 0; i < quantity.size(); ++i) {  // 独立枚举每一个人
            for (int j = 0; j < (1 << i); ++j) {     // 为了防止重复，枚举的是小于等于他的集合
                need[(1 << i) | j] = need[j] + quantity[i];
            }
        }

        for (int i = 0; i <= m; ++i) {
            fill(save[i].begin(), save[i].begin() + (1 << quantity.size()), -1);
        }
        auto f = [&](auto& self, int sta, int i) {
            if (sta == 0) {
                return true;
            }
            if (i > m) {
                return false;
            }
            if (save[i][sta] == -1) {
                save[i][sta] = false;
                for (int j = sta; j; j = j - 1 & sta) {
                    if (need[j] <= freq[i] && self(self, sta ^ j, i + 1)) {
                        save[i][sta] = true;
                        break;
                    }
                }
                if (!save[i][sta]) {
                    save[i][sta] = self(self, sta, i + 1);
                }
            }
            return (bool)save[i][sta];
        };

        return f(f, (1 << quantity.size()) - 1, 0);
    }
};

int main() {
    Solution solution;

    // 样例1
    vector<int> nums1 = {1, 2, 3, 4};
    vector<int> quantity1 = {2};
    cout << "★样例1★:" << endl;
    cout << solution.canDistribute(nums1, quantity1) << endl;
    cout << (solution.canDistribute(nums1, quantity1) == false ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    // 样例2
    vector<int> nums2 = {1, 2, 3, 3};
    vector<int> quantity2 = {2};
    cout << "★样例2★:" << endl;
    cout << solution.canDistribute(nums2, quantity2) << endl;
    cout << (solution.canDistribute(nums2, quantity2) == true ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    // 样例3
    vector<int> nums3 = {1, 1, 2, 2};
    vector<int> quantity3 = {2, 2};
    cout << "★样例3★:" << endl;
    cout << solution.canDistribute(nums3, quantity3) << endl;
    cout << (solution.canDistribute(nums3, quantity3) == true ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    return 0;
}

```
