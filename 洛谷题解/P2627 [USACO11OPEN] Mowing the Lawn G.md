# P2627 [USACO11OPEN] Mowing the Lawn G

所有者: Zvezdy
标签: 动态规划, 单调队列, 数学

有趣的推式子题，包含了一个简单的trick：如果我们所求的值中含片段前缀和，那我们就可以考虑取这段前缀和的前半段作为静态结构，后半段动态的随着我们的遍历改变。这个思路在单调队列优化DP中尤为重要，因为我们希望我们单调队列中的元素都是静态的值，一开始就确定的。

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
    int n, k;
    cin >> n >> k;
    vector<int> a(n + 2, 0);
    for (int i = 1; i <= n; ++i) {
        cin >> a[i];
        a[i] += a[i - 1];
    }
    a[n + 1] = a[n];

    vector<int> dp(n + 1, 0);
    deque<PII> dq;
    dq.push_back({0, 0});
    for (int i = 1; i <= n; ++i) {
        if (dq.size() && i - dq.front().se > k) {
            dq.pop_front();
        }
        while (dq.size() && dq.back().fi < dp[i - 1] - a[i]) {
            dq.pop_back();
        }
        dq.push_back({dp[i - 1] - a[i], i});
        dp[i] = dq.front().fi + a[i];
    }
    cout << dp[n];
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