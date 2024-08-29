# The Number of Good Subsets - LeetCode

所有者: Zvezdy
标签: 状态压缩动态规划
创建时间: 2024年8月27日 22:33

在熟悉组合数对这题计数的影响之后，就会发现其实数字小于等于30的用处。因为我们如果要求这个数组里面每个质因子只出现一次，那么有的数是不能选的，而且每个数一次最多只能取一个，再考虑到30以内质数就只有10个，那么妥妥的状压dp结合组合数。我们用状态压缩的方式表示我们目前需要取出的集合包含哪些质因数，然后再尝试达到这个条件有多少种组合，最后将它们累加。至于在搜索的时候，我们就从30枚举到1看拿不拿当前这个数，也同时判断能不能拿当前这个数。可以预处理出每一个数的质因子有哪些，存在一个状态中，这样会方便许多。

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

const int N = 1e5;
const int M = 10;
const int MODE = 1e9 + 7;
array<array<long long, 1 << M>, 31> save;
array<int, 31> nums;
array<int, 31> primes = {
    0b0000000000,  // 0
    0b0000000000,  // 1
    0b0000000001,  // 2
    0b0000000010,  // 3
    0b0000000000,  // 4
    0b0000000100,  // 5
    0b0000000011,  // 6
    0b0000001000,  // 7
    0b0000000000,  // 8
    0b0000000000,  // 9
    0b0000000101,  // 10
    0b0000010000,  // 11
    0b0000000000,  // 12
    0b0000100000,  // 13
    0b0000001001,  // 14
    0b0000000110,  // 15
    0b0000000000,  // 16
    0b0001000000,  // 17
    0b0000000000,  // 18
    0b0010000000,  // 19
    0b0000000000,  // 20
    0b0000001010,  // 21
    0b0000010001,  // 22
    0b0100000000,  // 23
    0b0000000000,  // 24
    0b0000000000,  // 25
    0b0000100001,  // 26
    0b0000000000,  // 27
    0b0000000000,  // 28
    0b1000000000,  // 29
    0b0000000111   // 30
};
// 2 3 5 7 11 13 17 19 23 29
int qmi(int m, int k) {
    int res = 1 % MODE, t = m;
    while (k) {
        if (k & 1) res = res * t % MODE;
        t = t * t % MODE;
        k >>= 1;
    }
    return res;
}
class Solution {
   public:
    int numberOfGoodSubsets(vector<int>& a) {
        int n = a.size();
        fill(nums.begin(), nums.end(), 0);
        for (auto i : a) {
            ++nums[i];
        }
        for (int i = 1; i <= 30; ++i) {
            for (int j = 0; j < 1 << M; ++j) {
                save[i][j] = -1;
            }
        }

        auto f = [&](auto& self, int sta, int i) -> long long {
            if (save[i][sta] != -1) {
                return save[i][sta];
            }
            long long ans = 0;
            if (i == 1) {
                if (sta == 0) {
                    ans = qmi(2, nums[1]);
                }
            } else {
                ans = self(self, sta, i - 1);  // 不取
                if (primes[i] && nums[i] && (primes[i] & sta) == primes[i]) {
                    ans += nums[i] * self(self, sta ^ primes[i], i - 1);
                    ans %= MODE;
                }
            }
            save[i][sta] = ans;
            return ans;
        };
        long long ans = 0;
        for (int i = 1; i < (1 << 10); ++i) {
            ans = (ans + f(f, i, 30)) % MODE;
        }
        return (int)ans;
    }
};
// 先统计数目
// 使用二进制状态代表有哪些质因子
// 有一些数字是不能选的，不选
// 因为是子集，并且重要的是位置独立所以不用去重
// 找数字，一个一个找。
// 1可以随便拿，所以是2的？次方，但是其他不行

int main() {
    Solution solution;

    // 样例1
    vector<int> nums1 = {1, 2, 3, 4};
    cout << "★样例1★:" << endl;
    cout << solution.numberOfGoodSubsets(nums1) << endl;
    if (solution.numberOfGoodSubsets(nums1) == 6)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    // 样例2
    vector<int> nums2 = {4, 2, 3, 15};
    cout << "★样例2★:" << endl;
    cout << solution.numberOfGoodSubsets(nums2) << endl;
    if (solution.numberOfGoodSubsets(nums2) == 5)
        cout << "Accepted" << endl;
    else
        cout << "Wrong Answer" << endl;
    cout << endl;

    return 0;
}

```
