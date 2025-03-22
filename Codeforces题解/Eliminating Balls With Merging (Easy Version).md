# Eliminating Balls With Merging (Easy Version)

所有者: Zvezdy
标签: 区间和, 思维
创建时间: 2024年10月3日 21:57

这里依旧是从一个极端且被确定的状态，推导出那些很难被确定并直接计算的状态，主要是依靠这么个条件：如果有一个数字能最终获胜，那么我们吃掉这个数字就一定能获胜。首先最大的数字一定能获胜，那么我们就看倒数第二大的数字能不能吃掉最大的数字。倒数第二大的数字能吃掉他周围除了最大数的所有数字，那么我们就用区间和求出它吃掉其它所有数字后的总和，看看现在能不能吃掉最大的数字，如果能，那么这个数字也获胜了。使用数学归纳法以此类推，就能求出哪些数字能获胜。现在有一个小trick，就是怎么拿到一个数周围所有比它小的数字之和，区间和肯定是使用前缀和，那怎么获得这个区间的位置？我们使用一个动态的数据结构来维护数字下标，当我们从大到小遍历元素的时候，我们只把大的元素下标插入到有序表中，这样我们就可以”跳过“那些小的元素。

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
    int n;
    cin >> n >> n;

    vector<int> a(n + 5);
    vector<int> prefix(n + 5, 0);
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
        prefix[i] = prefix[i - 1] + a[i];
    }

    vector<int> ord(2 * n + 1);
    iota(ord.begin() + n, ord.end(), 0);
    sort(ord.begin(), ord.end(), [&](int i, int j) {
        return a[i] > a[j];
    });

    set<int> maxn{0, n + 1};
    vector<int> ans(n + 5, false);
    for (auto i : ord) {
        int l = *(--maxn.lower_bound(i));
        int r = *maxn.lower_bound(i);
        int sum = prefix[r - 1] - prefix[l];

        if (i == ord[0]) {
            ans[i] = true;
        }
        if (sum >= a[l]) {
            ans[i] |= ans[l];
        }
        if (sum >= a[r]) {
            ans[i] |= ans[r];
        }
        maxn.insert(i);
    }
    cout << accumulate(ans.begin(), ans.end(), 0) << endl;
}

void init() {
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0), cout.tie(0);
    init();
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```