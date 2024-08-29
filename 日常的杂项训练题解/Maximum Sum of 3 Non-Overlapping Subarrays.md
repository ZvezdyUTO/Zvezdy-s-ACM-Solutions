# Maximum Sum of 3 Non-Overlapping Subarrays

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年8月12日 09:52

这题的思路和某一道叫魔法卷轴的题很像，那一题是说可以让我们消除数组上两段连续区间，问我们最后能得到的最大累加和是多少。最后那一题是使用分段的方式实现，分前后两段，在此之前我们需要枚举并处理出一些信息。比如在 0 ~ i 这个区间中使用一次魔法卷轴能得到的最大和，以及在 i ~ n-1 这个区间使用一次魔法卷轴能得到的最大和，这么处理出来以后我们就可以枚举分割点然后求前半段和后半段各使用一次魔法卷轴所得到的最大和。

而求某个段中间挖一个空的最大和有一个技巧就是，记录当前所能得到的最大前缀和，然后对于当前状态，要么是直接从前一个状态直接加上自己，要么就是从最大前缀和直接加上自己，要么就是直接取最大前缀和。这个技巧也可以用到一个环形数组求最大前缀和上，如果我们拆环成链，那么结果就是原本环的累加和减去中间最小的一段累加和，或者直接是取链上最大的累加和。

再回到这一题，我们如果可以把数组分为两段，那么就可以把数组分为三段。为了能使用前缀和后缀信息优化DP，我们选择让中间那段长度就等于k，而求出中间那段的左边 / 右边的长度为K的最大子数组。如此一来我们需要预处理的信息就很明了了：以每个下标开头往后k个元素的和、0~i范围内的最大最靠左子数组和的下标，i~n-1范围内最大最靠左子数组和的下标。最后跑一遍0~n-2*k的枚举就好，这题因为下标从0开始，所以需要注意一些区间的细节。

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
class Solution {
   public:
    vector<int> maxSumOfThreeSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> presum(n - k + 1);
        vector<int> suffix(n - k + 1);
        for (int i = n - 1, sum = 0, maxn = 0, index; i >= 0; --i) {
            sum += nums[i];
            if (i <= n - k) {
                if (sum >= maxn) {
                    maxn = sum;
                    index = i;
                }
                suffix[i] = index;
                presum[i] = sum;
                sum -= nums[i + k - 1];
            }
        }
        vector<int> prefix(n - k);
        for (int i = 0, index, maxn = -1; i < n - k; ++i) {
            if (presum[i] > maxn) {
                maxn = presum[i];
                index = i;
            }
            prefix[i] = index;
        }

        vector<int> ans(3, 0);
        int maxn = -1;
        for (int i = k; i < n - 2 * k + 1; ++i) {
            int now = presum[prefix[i - k]] + presum[i] + presum[suffix[i + k]];
            if (now > maxn) {
                maxn = now;
                ans[0] = prefix[i - k], ans[1] = i, ans[2] = suffix[i + k];
            }
        }
        return ans;
    }
};

int main() {
    Solution solution;

    vector<int> nums1 = {1, 2, 1, 2, 6, 7, 5, 1};
    int k1 = 2;
    cout << "★样例1★:" << endl;
    vector<int> result1 = solution.maxSumOfThreeSubarrays(nums1, k1);
    for (int i : result1) cout << i << " ";
    cout << endl;
    vector<int> expected1 = {0, 3, 5};
    cout << (result1 == expected1 ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    vector<int> nums2 = {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1};
    int k2 = 2;
    cout << "★样例2★:" << endl;
    vector<int> result2 = solution.maxSumOfThreeSubarrays(nums2, k2);
    for (int i : result2) cout << i << " ";
    cout << endl;
    vector<int> expected2 = {0, 2, 4};
    cout << (result2 == expected2 ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    vector<int> nums3 = {7, 13, 20, 19, 19, 2, 10, 1, 1, 19};
    int k3 = 3;
    cout << "★样例3★:" << endl;
    vector<int> result3 = solution.maxSumOfThreeSubarrays(nums3, k3);
    for (int i : result3) cout << i << " ";
    cout << endl;
    vector<int> expected3 = {1, 4, 7};
    cout << (result3 == expected3 ? "Accepted" : "Wrong Answer") << endl;
    cout << endl;

    return 0;
}
```
