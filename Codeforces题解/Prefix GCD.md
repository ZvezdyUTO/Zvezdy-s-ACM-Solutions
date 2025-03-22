# Prefix GCD

所有者: Zvezdy
标签: 数学, 贪心
创建时间: 2024年10月3日 13:34

从势能的视角来思考这道题，几个数取gcd就是取它们被完全分解后的最高次共同质因子，这么挨个取下去，终有一天这个共同的gcd值会变为一个定值，也就是势能消减为0了。加上题目要求求的是最小值，所以势能消减这个过程肯定越快越好。再来一个贪心分析，如果前面的值本来就小，那么后面的值和它取完gcd之后一定更小，所以局部最优可以推出全局最优。根据gcd的性质，这东西消减会非常迅速，如果我们在开始就把所有数的共同gcd全部剔除，那么在暴力枚举的时候，gcd会在放完前10个最小的选项后变为1，剩余的就当1加上就行。

这里有一些关于gcd的trick：__gcd(a,0)=a，弄一个数组，保证每次取最小值，那么很快我们的目前gcd就会变为这个数组的公共gcd，说明公共gcd这个势能消减十分迅速，因为__gcd(a,a)=a，所以选最值的时候不用考虑去重的情况，因为自己和自己混合不能融出更小的gcd，而是只能融出公共gcd

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
    cin >> n;
    vector<int> a(n);

    int common_gcd = 0;
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
        common_gcd = __gcd(common_gcd, a[i]);
    }
    for (int i = 0; i < n; ++i) {
        a[i] /= common_gcd;
    }

    int ans = 0;
    for (int i = 0, current_gcd = 0; i < n; ++i) {
        int cur = 0x7fffffff;
        for (int j = 0; j < n; ++j) {
            cur = min(cur, __gcd(current_gcd, a[j]));
        }
        current_gcd = cur;
        ans += current_gcd;
        if (current_gcd == 1) {
            ans += n - i - 1;
            break;
        }
    }

    cout << common_gcd * ans << endl;
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