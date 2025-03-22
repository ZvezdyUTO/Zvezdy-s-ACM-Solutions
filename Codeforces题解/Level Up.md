# Level Up

所有者: Zvezdy
标签: 二分答案, 树状数组
创建时间: 2024年10月4日 20:40

首先发现单调性，k大到一定程度的时候，某个位置的怪就一定会来打你，其次一个怪会不会被打由它左边的怪决定。假如我们知道目前为止所有怪的这个限制，那么当k为v的时候，小于等于v的怪都会被打。为了保证我们能正确取到这个值，我们需要保证计算的时候只考虑这个怪左边的怪，所以是我们计算完一个怪，就把这个值累加到我们的统计池中，然后求小于等于这个阈值的数，这个任务就由树状数组完成。同时基于这个阈值的单调性，可以考虑使用二分答案来求解，看当前这个怪会不会被打，就是看它前面打怪次数是否大于等于a[i]*k。

从这里可以挖掘出一些技巧：如果后面的值不会对当前计算造成影响，而当前计算需要用到我们之前遍历过的所有值的特性，就可以考虑动态数据结构。其次，观察某种条件是否成立，就看它到底需要什么因素，看看能不能从这些因素中找到利于我们判断的，最好是有单调性的因素，甚至动态且为止的因素也可以被我们考虑在内。 如果我们需要统计某些小于等于某个阈值的和，就可以使用树状数组。这题最重要的还是发现那个“界限”，然后就可以从这个界限中推导出更多的思路和可能性。

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

const int N = 2e5;
array<int, N + 5> BIT;
void add(int i, int v) {
    while (i <= N) {
        BIT[i] += v;
        i += (i & -i);
    }
}
int query(int i) {
    int res = 0;
    while (i > 0) {
        res += BIT[i];
        i -= (i & -i);
    }
    return res;
}

void solve() {
    int n, q;
    cin >> n >> q;
    vector<int> limit(n + 1);
    for (int i = 1, now; i <= n; ++i) {
        cin >> now;
        int l = 1, r = n;
        while (l < r) {
            int mid = l + (r - l) / 2;
            if (query(mid) >= now * mid) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        limit[i] = l;
        add(l, 1);
    }

    int i, x;
    while (q--) {
        cin >> i >> x;
        if (limit[i] > x) {
            cout << "NO" << endl;
        } else {
            cout << "YES" << endl;
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