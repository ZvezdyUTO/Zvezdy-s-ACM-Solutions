# Triangle Formation

所有者: Zvezdy
标签: 数学, 暴力枚举
创建时间: 2024年10月5日 13:52

终极无敌大诈骗，如果我们刚好构不成一个三角形，那么一定是a+b=c，多个边组成的数组，每个都构不成三角形，排完序以后发现就是斐波那契数列，而斐波那契数列的第四十多项就大于1e9了，所以数组大小如果为45，那么一定存在一个合法三角形，当为48的时候，一定有两个合法三角形。所以超过48长度的部分就直接输出YES，否则就暴力判断是否存在两个合法三角形。把区间内元素从小到大排列，可证明一直从小开始选最相邻一定是优的，但也有一种特殊情况就是2 5 5 4 6 10 10 这混在一起的，所以也需要暴力判断+循环选相邻判断。

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
#define int long long
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int INF = 1e18;

void solve() {
    int n, q;
    cin >> n >> q;
    vector<int> edge(n);
    for (int i = 0; i < n; ++i) {
        cin >> edge[i];
    }
    while (q--) {
        int l, r;
        cin >> l >> r;
        if (r - l + 1 >= 48) {
            cout << "YES" << endl;
        } else {
            int m = r - l + 1;
            vector<int> cur(m);
            for (int i = l - 1, it = 0; i < r; ++i, ++it) {
                cur[it] = edge[i];
            }
            sort(cur.begin(), cur.end());

            auto check = [&]() {
                for (int i = 0; i < m - 5; ++i) {
                    for (int j = i + 1; j <= i + 5; ++j) {
                        for (int k = j + 1; k <= i + 5; ++k) {
                            vector<int> another(3);
                            for (int it = i + 1, cnt = 0; it <= i + 5; ++it) {
                                if (it != j && it != k) {
                                    another[cnt++] = cur[it];
                                }
                            }
                            if (cur[i] + cur[j] > cur[k] && another[0] + another[1] > another[2]) {
                                return true;
                            }
                        }
                    }
                }
                int count = 0;
                for (int i = 0; i < m - 2; ++i) {
                    if (cur[i] + cur[i + 1] > cur[i + 2]) {
                        ++count;
                        i += 2;
                    }
                }
                return count >= 2;
            };

            if (check()) {
                cout << "YES" << endl;
            } else {
                cout << "NO" << endl;
            }
        }
    }
}

void init() {}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```