# G - Ultra-Meow

所有者: Zvezdy
标签: 组合数学
创建时间: 2024年7月13日 10:38

面对组合数学问题，我们有两种选择，一是dp，二就是暴力枚举了。对于这题找子数组来说我们可能会想到枚举子串长度从1~n，但是光靠这个很难计算出我们所需的组合数，仔细查看数据范围为n≤5000，n^2≤25*10^6，可以考虑O(n^2)的双重循环。这里有个小trick，因为mex是从1~n+n+1都有可能的，所以我们第二重循环可以枚举我们mex最终值在各种数组大小下会出现多少次就行。预打表杨辉三角求组合数，但是需要特别判断：当a>b或者b<0的时候需要返回0，因为我们暴力枚举过去可能会遇到求不出的mex，把特判放在外层会显得干净一些。再来说一下组合数计算方法：如果我们当前的mex最终值为x，此时我们的数组长度为k，那么前1~mex-1中一定有mex-k-1个数字，剩余的数字全部塞在mex以后，注意特判当mex大于n时候的位置，因为我们的数字不可能大于n。

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
const int MODE = 1e9+7;
const int INF = 1e18;
const int N = 1e6;
int c[5001][5001];
inline int C(int a, int b) {
    if (b > a || b < 0) return 0;
    return c[a][b];
}
void solve() {
    int n; cin >> n;
    int ans = 0;
    for (int sz = 0; sz <= n; ++sz) {
        for (int mex = sz + 1; mex <= n + sz + 1; ++mex) { //枚举mex
            ans += C(min(mex - 1, n), mex - sz - 1) % MODE 
                    * C(max(0ll, n - mex), sz - (mex - sz - 1)) % MODE 
                        * mex % MODE;
            ans %= MODE;
        }
    }
    cout << ans << '\n';
}
signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    c[0][0] = 1;
    for (int i = 1; i <= 5000; ++i) {
        c[i][0] = 1;
        for (int j = 1; j <= 5000; ++j) {
            c[i][j] = c[i-1][j-1] + c[i-1][j];
            if (c[i][j] >= MODE) c[i][j] -= MODE;
        }
    }
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```