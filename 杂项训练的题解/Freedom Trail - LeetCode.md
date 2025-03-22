# Freedom Trail - LeetCode

所有者: Zvezdy
标签: 二分查找, 动态规划
创建时间: 2024年8月29日 19:22

很容易想到初步的状态转移以及枚举讨论，优化的思路也很显而易见：我们并不用每次都把每个字符的所有位置都填上，而是只要讨论离当前位置最近的左右两个字符位置就行，而实现最好就是打递归完成。并使用二分查找来找到我们所需的位置。这里涉及到另一种二分查找的思路：使用l≤r来终止while循环，如果是使用l<r的话，我们是在不符合条件那一端打上+1，但在l≤r这里我们是在我们符合条件这一端多打一个res=mid，并且左右两端我们都打+1。这样处理我们就可以知道最后我们有没有在里面找到符合要求的元素，而另一种方法则是我们已经默认符合要求的元素一定存在于数组中。

这题的细节部分很麻烦，依旧要小心。。。

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

const int N = 100;
array<array<int, N + 1>, N + 1> save;

class Solution {
   public:
    int findRotateSteps(string ring, string key) {
        int n = ring.size(), m = key.size();
        unordered_map<char, vector<int>> mp;
        for (int i = 0; i < n; ++i) {
            mp[ring[i]].push_back(i);
        }
        for (int i = 0; i < n; ++i) {
            fill(save[i].begin(), save[i].begin() + m, -1);
        }

        auto f = [&](auto& self, int i, int wh) {
            if (i == m) {
                return 0;
            }
            if (save[wh][i] == -1) {
                auto& res = save[wh][i];
                if (ring[wh] == key[i]) {
                    res = 1 + self(self, i + 1, wh);
                } else {
                    auto& arr = mp[key[i]];
                    auto check_l = [&]() {
                        int l = 0, r = arr.size() - 1;
                        int found = -1;
                        while (l <= r) {
                            int mid = l + (r - l) / 2;
                            if (arr[mid] > wh) {
                                found = mid;
                                r = mid - 1;
                            } else {
                                l = mid + 1;
                            }
                        }
                        return found != -1 ? arr[found] : arr[0];
                    };
                    int jump_l = check_l();
                    int dis_l = min(abs(wh - jump_l), n - abs(wh - jump_l));

                    auto check_r = [&]() {
                        int l = 0, r = arr.size() - 1;
                        int found = -1;
                        while (l <= r) {
                            int mid = l + (r - l) / 2;
                            if (arr[mid] < wh) {
                                found = mid;
                                l = mid + 1;
                            } else {
                                r = mid - 1;
                            }
                        }
                        return found != -1 ? arr[found] : *arr.rbegin();
                    };
                    int jump_r = check_r();
                    int dis_r = min(abs(wh - jump_r), n - abs(wh - jump_r));

                    res = min(dis_l + self(self, i + 1, jump_l), dis_r + self(self, i + 1, jump_r)) + 1;
                }
            }
            return save[wh][i];
        };
        return f(f, 0, 0);
    }
};

int main() {
    Solution solution;

    cout << "★样例1★:" << endl;
    int result1 = solution.findRotateSteps("godding", "gd");
    cout << result1 << endl;
    if (result1 == 4)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```