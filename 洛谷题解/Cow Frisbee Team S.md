# Cow Frisbee Team S

所有者: Zvezdy
标签: 动态规划, 组合数学

被黄题 组合数 吊打 了，无敌了。

这题是死在初始化，还有一心想开的滚动数组了，其实没必要。因为最后是需要把数字取模后录入，所以不能简单地想到让它们拿0位置转移过来。因为这个数字实际上可以从后面的地方”滚一圈“再回来，所以每次初始化的时候都应该把当前位置上直接取上来那个数的方案设为1。因为题目没说没有队员的时候算一个方案，所以f[0][0]不能设为1，以后遇到取模求方案数的时候一定得慎重考虑哪里是方案，在哪里初始化。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define endl '\n'
#define fi first
#define se second
#define dot pair<int,int>
const int MODE=100000000;
const int INF=0x7fffffffff;
int f[2001][1001],a[2001];
void solve(){
    int n,F; cin>>n>>F;
    for(int i=1;i<=n;++i) cin>>a[i],a[i]%=F;
    for(int i=1;i<=n;++i) f[i][a[i]]=1;
    for(int i=1;i<=n;++i)
        for(int j=0;j<F;++j){
            f[i][j]=f[i][j]+f[i-1][j]+f[i-1][(F+j-a[i])%F];
            f[i][j]%=MODE;
        }
    cout<<f[n][0];
}

signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int TTT=1;
    // cin>>TTT;
    while(TTT--){
        solve();
    }
    return 0;
}

```
