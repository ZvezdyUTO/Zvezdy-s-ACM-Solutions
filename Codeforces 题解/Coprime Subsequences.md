# Coprime Subsequences

所有者: Zvezdy
标签: 同余原理, 组合数学
创建时间: 2024年9月9日 14:48

一个数的最大公因数一定是唯一确定的，根据这个条件，我们可以知道，以当前这个数为最大公因数子序列的数量等于 (2^因子包含当前这个数的所有数字个数) 容斥掉最大公约数不为当前这个数的子序列数量。根据这个公式可以看出我们每一步都会依赖后面的位置，所以考虑倒序递推求解。

这一题除了容斥还有一个trick就是，我们所求的是子序列，而且符合要求的条件是看最大公约数，那么我们就不用关心原数组中的顺序关心，这时我们要么选择排序，要么选择统计词频并从中求解。考虑到子序列是往里面塞多少多少数字，所以我们用词频搭配非空子序列个数为2^n-1来求解。复杂度为调和级数nlogn

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
const int MODE = 1e9 + 7;

const int N = 1e5;
array<int, N + 1> a;
array<int, N + 1> dp;
array<int, N + 1> qqmi;

void solve() {
    int n;
    cin >> n;
    qqmi[0] = 1;
    for (int i = 1; i <= N; ++i) {
        qqmi[i] = qqmi[i - 1] * 2ll % MODE;
    }
    for (int i = 1; i <= n; ++i) {
        int now;
        cin >> now;
        ++a[now];
    }
    for (int i = N; i >= 1; --i) {
        int cnt = 0;
        for (int j = i; j <= N; j += i) {
            cnt += a[j];
        }
        dp[i] = (qqmi[cnt] - 1 + MODE) % MODE;
        for (int j = 2 * i; j <= N; j += i) {
            dp[i] = (dp[i] - dp[j] + MODE) % MODE;
        }
    }
    cout << dp[1] << endl;
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
// 12 -> 2^a
// 8 -> 2^(a+b) - 2^b
// 4 -> 2^(a+b+c) - (2^(a+b)-2^b) - 2^a
```