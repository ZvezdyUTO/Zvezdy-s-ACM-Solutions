# Island Tour

所有者: Zvezdy
标签: 差分

重点在于区间操作，而该题区间操作的重点在于环形区间操作

分别求出每座桥如果不通畅的代价

对于每一段路我们都有两种选择，顺时针或者逆时针，选择两种走法我们都会经过某些桥

所以我们并不用求出原始全联通状态下我们怎么走，我们只需要在每次路径更新的时候找到哪些桥是按顺时针走要经过的，哪些桥是按逆时针走要经过的，接着在它们上面分别更新反方向走的路径。

至于这个环形区间的差分，我们只需要在 首~起始点 和 中止点~终点 更新，即可实现环形上的差分更新。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
#pragma GCC optimize(2)
#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define ld long double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(auto word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(auto word=begin;word>=endd;--word)
#define cmp(what_type) function<bool(what_type,what_type)>
#define r(x) cin>>x
#define s(x) cout<<x
#define cint(x) int x;cin>>x
#define cchar(x) char x;cin>>x
#define cstring(x) string x;cin>>x
#define cll(x) ll x cin>>x
#define cld(x) ld x cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>

ll a[200001];
ll f[200002];//第一个元素代表n到1之间的桥
void solve(){
    cint(n);cint(m);
    FOR(i,1,m) r(a[i]);
    FOR(i,2,m){
        int x=a[i-1],y=a[i];
        if(x>y) swap(x,y);
        ll r=y-x;//顺时针走法
        //分两种走法，一种是顺时针走法，一种是逆时针走法
        //因为在桥断掉的情况下要么顺时针走，要么逆时针走
        //因此不用判断原本走哪，只用在每个桥的值上更新不经过那个桥的路径
        f[1]+=r; f[x]-=r;//在1~x-1上更新顺时针
        f[x]+=(n-r); f[y]-=(n-r);//在x~y-1上更新逆时针
        f[y]+=r; f[n+1]-=r;//在y到n上更新顺时针
    }
    FOR(i,1,n) f[i]+=f[i-1];
    ll ans=maxll;
    FOR(i,1,n) ans=min(f[i],ans);
    s(ans);
}
int main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
//    int T; cin>>T;
    int T=1;
    while(T--){solve();}
    return 0;
}
```