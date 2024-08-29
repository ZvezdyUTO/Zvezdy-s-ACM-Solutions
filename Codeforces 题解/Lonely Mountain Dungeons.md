# Lonely Mountain Dungeons

所有者: Zvezdy
标签: 组合数学
创建时间: 2024年6月17日 09:34

其实在看到所有ci之和小于等于2e5的时候，就可以发现这题是暴力枚举求解了。而答案计算并不是按照分组数量单调递增，所以枚举组数即可。

重点在于计算组合数，已知题目是说每一对增加b战斗力，那么就是一堆里面选两个的Cn2，当然这是最优的方案，但是我们可以使用容斥去减去每次多算的代价，已知平均分（数学结论）最好，如果平均分为了5组，每组4个，那么就要减去5*C42，因为每个小队里的不能算。如果不能平均分就算前半组和后半组多余的贡献就好。最后如果我们分的组已经超过某一个种族的总人数了，那么那个种族就是严格的Ca[i]2，就可以直接加到已经求过的和里，不用再计算了，所以这题是需要排个序的。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \____|  \__  |★*/
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
#define dot pair<int,int>
const int MODE = 998244353;
const int INF = 1e15;
int a[200001];
void solve(){
    int n,b,x,maxn=0; cin>>n>>b>>x;
    for(int i=1;i<=n;++i) cin>>a[i],maxn=max(maxn,a[i]);
    sort(a+1,a+n+1);
    int sum=0,it=1,ans=0;
    for(int i=1;i<=maxn;++i){
        int now=0;
        for(int j=it;j<=n;++j){
            if(a[j]<=i){
                sum+=b*(a[j]*(a[j]-1))/2;
                ++it;
                continue;
            }
            int ave=a[j]/i; //平均数
            int fir=i-a[j]%i,sec=a[j]%i; //前半组 后半组
            now+=b*a[j]*(a[j]-1)/2; //最大贡献
            now-=b*fir*ave*(ave-1)/2; //容斥
            now-=b*sec*ave*(ave+1)/2; //容斥
        }
        now+=sum;
        now-=x*(i-1);
        ans=max(now,ans);
    }
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy=1;
    cin>>Zvezdy;
    while (Zvezdy--){
        solve();
    }
    return 0;
}

```
