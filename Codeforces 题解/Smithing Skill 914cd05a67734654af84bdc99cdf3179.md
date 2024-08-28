# Smithing Skill

所有者: Zvezdy
标签: 动态规划, 贪心
创建时间: 2024年6月28日 19:54

很容易想出贪心的策略：优先锻造目前消耗最少且能够锻造的武器。对于一些消耗更大且所需原材料更多的劣质方案可以舍弃它们。在构造新的容器以后可以得到一系列的方案：原材料消耗由多到少，锻造损耗由少到多。

然后就是优化贪心，可以观察到锻造花费最大为1e6，刚好在可用空间内，可以考虑预处理出1~1e6块铁所能提供的最大经验值，使用双指针从1和备选方案末尾开始遍历，并采用背包优化使得预处理的时间复杂度为O(n)。最后分别对超过最大花费的原料和小于最大花费的原料处理贡献后累入答案中即可。

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
int n,m;
struct weapon{
    int a,b,lose;
}a[1000005];
int iron[1000005];
int f[1000005];
void solve(){
    int n,m; cin>>n>>m;
    int maxn=0;
    for(int i=1;i<=n;++i){
        cin>>a[i].a;
        maxn=max(a[i].a,maxn);
    }
    for(int i=1;i<=n;++i){
        cin>>a[i].b;
        a[i].lose=a[i].a-a[i].b;
    }
    for(int i=1;i<=m;++i) cin>>iron[i];
    
    sort(a+1,a+n+1,[](weapon x,weapon y){
        if(x.lose==y.lose) return x.a<y.a;
        else return x.lose<y.lose;
    });
    vector<weapon>a2(1);
    for(int i=1;i<=n;++i){
        if(a2.size()>1){
            if(a[i].a<a2.back().a){
                a2.push_back(a[i]);
            }
        }
        else{
            a2.push_back(a[i]);
        }
    }
    
    for(int i=1,j=a2.size()-1;i<=maxn;++i){
        while(j>1 && i>=a2[j-1].a){
            --j;
        }
        if(i>=a2[j].a){
            f[i]=f[i-a2[j].lose]+1;
        }
    }
    
    int ans=0;
    for(int i=1;i<=m;++i){
        if(iron[i]>maxn){
            int get=(iron[i]-maxn)/a2[1].lose;
            ans+=get;
            iron[i]-=get*a2[1].lose;
            ans+=1+f[iron[i]-a2[1].lose];
        }
        else{
            ans+=f[iron[i]];
        }
    }
    cout<<2ll*ans;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    // cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}

```