# Majority Element II

所有者: Zvezdy
标签: 摩尔投票
创建时间: 2024年8月6日 22:19

摩尔投票的性质，如果一个元素在一个容器中出现的次数有一半以上，那么在一对一的打靶抵消过程中，它一定可以生存下来。摩尔邮票的拓展就是找出数组中出现n/k次以上的元素，这时候我们就需要k-1个候选人列表，当列表满的时候出现一个不在列表上的候选人，我们就把列表上所有候选人的hp-1，如此我们只需要额外k的空间，且时间复杂度为O(n*k)

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

int main() {
    // 包信息：—————————————————————————————————————————————————————————————
    vector<int> nums;
    // 测试用例:
    nums = {4, 5, 3, 4, 4, 1, 0, -1, -2, 4, 6, 7, 8, 4};
    // 主程序：—————————————————————————————————————————————————————————————
    auto SolveProblem = [&]() {
        int n = nums.size();
        int k = 3;
        vector<pair<int, int>> goal(k - 1);
        for (int i = 0; i < n; ++i) {
            bool full = false;
            for (auto& [v, hp] : goal) {
                if (v == nums[i]) {
                    ++hp;
                    full = true;
                    break;
                }
            }
            if (!full)
                for (auto& [v, hp] : goal) {
                    if (hp == 0) {
                        ++hp;
                        v = nums[i];
                        full = true;
                        break;
                    }
                }
            if (!full) {
                for (auto& [v, hp] : goal) {
                    --hp;
                }
            }
        }
        for (auto& [v, hp] : goal) {
            hp = 0;
        }
        vector<int> ans;
        for (auto i : nums) {
            for (auto& [v, hp] : goal) {
                if (v == i) {
                    ++hp;
                    break;
                }
            }
        }
        for (auto& [v, hp] : goal) {
            // debug(v);
            if (hp > n / 3) {
                ans.push_back(v);
            }
        }
        return ans;
    };
    // 执行指令：———————————————————————————————————————————————————————————
    SolveProblem();
    return 0;
}

```
