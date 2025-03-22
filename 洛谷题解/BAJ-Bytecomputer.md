# BAJ-Bytecomputer

所有者: Zvezdy
标签: 动态规划

很容易找状态，就是遍历到第i个元素的时候，以某个数字结尾的时候所需的最小代价。在研究状态转移方程以后发现其实只会从前面一位转移过来，所以可以开一个滚动数组来优化空间。

当前值为-1的时候，不能把它变成0，因为只有它前面有1才能把它变成0，但我们需要的是非递减数组。或许可以考虑是从前面的1转移过来后又从更前面的-1把1磨平，但那样做根本没有必要，那还不如-1直接把中间所有的数全抹为-1。所以当结尾为-1的时候一定不能将其转为结尾为0的数组。设为INF。其它的很简单，直接考虑就行。

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
const int MODE=1000000007;
const int INF=0x7fffffffff;
int f[3]{INF,INF,INF};
int a[1000005];
void solve(){
    int n; cin>>n;
    for(int i=1;i<=n;++i) cin>>a[i];
    f[a[1]+1]=0;
    int f1=1e10,z1=1e10;
    for(int i=2;i<=n;++i){
        int now;
        if(a[i]==-1){
            f[1]=INF;//不能从之前的f[0]滚过来
            f[2]+=2;
        }
        if(a[i]==0){
            f[1]=min(f[0],f[1]);//可以直接拼接
            ++f[0];//-1转移过来要+1
            ++f[2];//变成1要+2
        }
        if(a[i]==1){
            f[2]=min({f[0],f[1],f[2]});//直接拼接，三条路里面选最短的
            f[1]=f[0]+1;//变成0，要+1
            f[0]+=2;//变成-1要+2
        }
    }
    int ans=min({f[0],f[1],f[2]});
    if(ans<INF) cout<<ans;
    else cout<<"BRAK";
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int t=1;
    // cin >> t;
    while(t--){
        solve();
    }
    return 0;
}

```