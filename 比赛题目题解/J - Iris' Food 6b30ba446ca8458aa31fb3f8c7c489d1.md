# J - Iris' Food

所有者: Zvezdy

填数字，难点在取模的部分，把前两位特判的处理好以后就看后面的。易知每次都填连续k个相同的数字，因为k太大所以采用高精度十分麻烦，考虑其它方法，将这些数拆解以后可以发现它们是 11111…11*i ，而11111…111=1+10+100+1000+…+1000000，是一个等比数列前n项和。所以可以使用自带取模的快速幂方便快速地求解。

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
#define ll long long
#define debug(x) cout<<#x<<" = "<<x<<endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int,int>
int MODE = 1e9+7;
const int INF = 1e18;
int qmi(int m,int k){
    int res=1%MODE,t=m;
    while(k){
        if(k&1) res=res*t%MODE;
        t=t*t%MODE;
        k>>=1;
    }
    return res;
}
int num[10];
void solve(){
    int n; cin>>n;
    for(int i=0;i<10;++i) cin>>num[i];
    if(n==1){
        for(int i=0;i<=9;++i){
            if(num[i]){
                cout<<i<<endl;
                return;
            }
        }
    }
    int ans=0;
    for(int i=1;i<=9;++i){
        if(num[i]){
            --num[i];
            --n;
            ans=i;
            break;
        }
    }
    for(int i=0;i<=9 && n;++i){
        if(num[i]){
            int need=min(n,num[i]);
            n-=need;
            ans*=qmi(10,need);
            ans%=MODE;
            if(i){
                ans+=i*(qmi(10ll,need)-1)*111111112ll%MODE;
                ans%=MODE;
            }
        }
    }
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```