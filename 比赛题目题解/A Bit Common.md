# A Bit Common

所有者: Zvezdy

组合数里面有很多种情况感觉都可以暴力地覆盖并且统计掉，我们假设在一个序列中，有k个奇数，那么这些奇数就有C(n,k)种放法，而偶数则不参与按位与的运算，所以除了最低位为0以外其它位都可以随便放。接下来考虑奇数的部分，首先奇数最低位一定都为1，其次，为了保证这里面的奇数有一个或者多个按位与起来以后剩1，它们除了最后一位以外其它位都至少有一个0存在，我们直接容斥掉那个某一位全部为1的部分就好。记得预先把2的次幂全打出来，这题会卡。。。

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
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
int MODE = 998244353;
const int N = 300005;
const int INF = 1e18;
int c[5001][5001];
int qqmi[5001];
inline int C(int a, int b) {
    if (b > a || b < 0) return 0;
    return c[a][b];
}
int qmi(int m,int k){
    int res=1%MODE,t=m;
    while(k){
        if(k&1) res=res*t%MODE;
        t=t*t%MODE;
        k>>=1;
    }
    return res;
}
void solve() {
    int n,m; cin>>n>>m>>MODE;
    for(int i=0;i<=5000;++i){
        qqmi[i]=qmi(2ll,i);
    }
    c[0][0] = 1;
    for (int i = 1; i <= 5000; ++i) {
        c[i][0] = 1;
        for (int j = 1; j <= 5000; ++j) {
            c[i][j] = c[i-1][j-1] + c[i-1][j];
            if (c[i][j] >= MODE) c[i][j] -= MODE;
        }
    }
    int ans=0;
    for(int i=1;i<=n;++i){
        int res=C(n,i);
        for(int j=2;j<=m;++j){
            res*=(qqmi[i]-1)%MODE*qqmi[n-i]%MODE;
            res%=MODE;
        }
        ans+=res;
        ans%=MODE;
    }
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    // freopen("test.out","w",stdout);
    
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```
