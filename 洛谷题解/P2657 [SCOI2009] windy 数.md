# P2657 [SCOI2009] windy 数 - 洛谷

所有者: Zvezdy
标签: 数位动态规划

很典很典的数位DP了，最好还是按位枚举数字打记忆化搜索然后枚举到尽头后返回1，组合数用记忆化搜索写还是非常方便的，这里有一些比较通用的技巧以及细节需要注意：

1. 我们是计算两个数之间的所有可能数字，那么为了避免讨论上界的同时还要讨论下界，我们可以计算0~a-1之间的windy数，和0~b之间的windy数，再容斥相减就能很方便地拿到我们的答案。
2. 我们从高到低位枚举数字，可以使用offset辅助数来取出最高位的数字， **`int cur = num / offset % 10;`** 这么看来我们的offset就得比当前数字位数小一位，那我们在初始计算offset的时候就拿tmp = num / 10计算就好。
3. 我们此时需要几个参数，len代表剩余多少位没有填，len==0的时候代表我们发现了一个方案。free代表我们现在是否可以任意填，如果我们前面一直按照最高最大数走的话，我们后面就不能填大于等于当前数的数字。pre代表前面填的数是什么数，其中比较特殊的就是pre=10的时候代表我们前面不选择数字，再来一个特判就是当!free以及pre==10的时候代表我们在开头，还没有选择任何数字。
4. 最后就是根据题目要求一位一位讨论可能性展开就行，注意分类讨论的时候free和pre的先后顺序，不要吝啬分类讨论的代码量，尽可能概括全面的情况。

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
#define int long long
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int MODE = 998244353;

array<array<array<int, 2>, 11>, 11> save;

void solve() {
    int a, b;
    cin >> a >> b;

    auto serch = [&](int num) {
        if (num == 0) {
            return 1ll;
        }
        int len = 1, offset = 1, tmp = num / 10;
        while (tmp) {
            ++len;
            offset *= 10;
            tmp /= 10;
        }
        for (int i = 0; i < 11; ++i) {
            for (int j = 0; j < 11; ++j) {
                fill(save[i][j].begin(), save[i][j].end(), -1);
            }
        }

        // pre之前是否选择过数字
        // free是否可以任意选择
        // offset取出当前这一位的数字
        // len还剩多少位没有选择
        auto f = [&](auto& self, int offset, int len, int pre, bool free) {
            if (len == 0) {
                return 1ll;
            }
            if (save[len][pre][free] != -1) {
                return save[len][pre][free];
            }
            int cur = num / offset % 10;
            int res = 0;
            if (!free) {          // 是否可以任选
                if (pre == 10) {  // 之前没选过数字，代表是第一位
                    res += self(self, offset / 10, len - 1, 10, true);
                    for (int i = 1; i < cur; ++i) {  // 第一位不可能为0
                        res += self(self, offset / 10, len - 1, i, true);
                    }
                    res += self(self, offset / 10, len - 1, cur, false);
                } else {  // 选过了数字
                    for (int i = 0; i <= 9; i++) {
                        if (i <= pre - 2 || i >= pre + 2) {
                            if (i < cur) {
                                res += self(self, offset / 10, len - 1, i, true);
                            } else if (i == cur) {
                                res += self(self, offset / 10, len - 1, cur, false);
                            }
                        }
                    }
                }
            } else {
                if (pre == 10) {
                    for (int i = 1; i <= 10; ++i) {
                        res += self(self, offset / 10, len - 1, i, true);
                    }
                } else {
                    for (int i = 0; i <= 9; ++i) {
                        if (abs(i - pre) >= 2) {
                            res += self(self, offset / 10, len - 1, i, true);
                        }
                    }
                }
            }
            save[len][pre][free] = res;
            return res;
        };
        return f(f, offset, len, 10, false);
    };

    cout << serch(b) - serch(a - 1) << endl;
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    // freopen("test.in", "r", stdin);
    // freopen("test.out", "w", stdout);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
