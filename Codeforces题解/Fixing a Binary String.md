# Fixing a Binary String

所有者: Zvezdy
标签: 字符串哈希
创建时间: 2024年6月11日 10:48

通过题意可知，最终符合要求的要么就是111000111000…或者就是000111000111….（假如k=3）。一眼模拟，写个哈希就能秒。主要再稍微学一下字符串哈希的写法，不用unordred_map就是怕被卡。

先弄一个随机数生成引擎：`mt19937 rnd(static_cast<int>(time(0)));`

然后就可以找到哈希函数对应值 `const int P=rnd()%MODE;`

在main函数中预处理出pw数组，存储P的幂次：`for(int i=1;i<=200000;++i) pw[i]=pw[i-1]*P%MODE;`

由字符串哈希的生成原理：则是：a*P+b*P*P+c*P*P*P+….

考虑到题目中的数组反转，以及我们需要多次判断是否相同，可以先预处理出从开头到某个部分的哈希值，当然反向的是，用两个for循环像前缀和一样打出来就行。至于拼接部分，则是像前缀和一样切出某一段的哈希值，再除去次幂，前半段后半段都这么做，然后乘上次幂拼上来就行。

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
#define dot pair<int, int>
const int MODE = 1e9 + 7;
const int INF = 1e15;

mt19937 rnd(static_cast<int>(time(0)));
const int P = rnd() % MODE;
int pw[200001]{1}, hs[200001], rhs[200001];
int get_hash(int* arr, int l, int r) {
    return (arr[r] - arr[l - 1] * pw[r - l + 1] % MODE + MODE) % MODE;
}
string ss, s;
void solve() {
    int n, k;
    cin >> n >> k >> ss;
    s = " ";
    s += ss;
    for (int i = 1; i <= n; ++i) hs[i] = (hs[i - 1] * P + s[i] - '0') % MODE;
    rhs[n + 1] = hs[n + 1] = 0;
    for (int i = 1; i <= n; ++i) rhs[i] = (rhs[i - 1] * P + s[n - i + 1] - '0') % MODE;
    int g1 = 0, g2 = 0;
    for (int i = 0; i < n; ++i) {
        g1 = (g1 * P + (i / k) % 2) % MODE;
        g2 = (g2 * P + (1 - (i / k) % 2)) % MODE;
    }
    for (int p = 1; p <= n; ++p) {
        int now = (get_hash(hs, p + 1, n) * pw[p] + get_hash(rhs, n + 1 - p, n)) % MODE;
        if (now == g1 || now == g2) {
            cout << p << endl;
            return;
        }
    }
    cout << -1 << endl;
}
signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);
    int TTT = 1;
    cin >> TTT;
    for (int i = 1; i <= 200000; ++i) pw[i] = pw[i - 1] * P % MODE;
    while (TTT--) {
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}

```