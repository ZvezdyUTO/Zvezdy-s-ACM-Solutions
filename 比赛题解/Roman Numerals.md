# Roman Numerals

所有者: Zvezdy

解决这道题的关键就在于发现其数据量背后的秘密，按照题目中所说的组合方式，每一次我们都是填最后一位，同时有一些影响前面的选择。已知最多数字只有18位，而候选又只有17种，可以考虑剪枝爆搜，每次查看最后一位，如果不为0，就直接选1~9还有罗马数字1和5，如果最后一位为0，就从那些大于等于10的罗马数字来枚举，把我们目前的数字减去我们所选择的数，然后继续搜。

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
const int INF = 1e18;
PII number[15];
void solve(){
    int n; cin>>n;
    for(int i=0;i<=9;++i) cin>>number[i].se;
    int a; cin>>a; number[1].se=min(number[1].se,a);
    int b; cin>>b; number[5].se=min(number[5].se,b);
    for(int i=10;i<=14;++i) cin>>number[i].se;
    int ans=INF;
    function<void(int,int)>dfs=[&](int now,int cost)->void{
        if(now==0){
            ans=min(ans,cost);
            return;
        }
        if(now%10){
            dfs(now/10,cost+number[now%10].se);
        }
        else{
            dfs(now/10,cost+number[0].se);
            for(int i=10;i<=14;++i){
                if(number[i].fi<=now)
                    dfs((now-number[i].fi)/10,cost+number[i].se);
            }
        }
    };
    dfs(n,0);
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;

    for(int i=0;i<=9;++i)
        number[i].fi=i;

    number[10].fi=10;
    number[11].fi=50;
    number[12].fi=100;
    number[13].fi=500;
    number[14].fi=1000;

    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```