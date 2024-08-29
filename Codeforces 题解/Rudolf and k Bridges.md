# Rudolf and k Bridges

所有者: Zvezdy
标签: 动态规划, 单调队列
创建时间: 2024年4月11日 11:19

其实还是看错题了，这题很简单，k的意思是要在连续k行上建桥，也就是建宽为k的桥。

那么接下来就是dp了，桥墩间不超过d，我们可以把这个条件理解为滑动窗口问题，那么就使用单调队列来优化它。

单调队列可以用deque写，也可以用multiset模拟，但无论是哪种，都别忘了在合适的时候清空容器。。。因为这个卡了好久

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
//#pragma GCC optimize(2)
//#pragma GCC optimize(3,"Ofast","inline")
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
#define cll(x) ll x; cin>>x
#define cld(x) ld x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
ll a[200005];
ll dp[200005];
ll f[101];
multiset<ll>dq;
void solve(){
    cint(n);cint(m);cint(k);cint(d);
    FOR(i,1,n){//分行操作
        dq.clear();
        FOR(ii,1,m){r(a[ii]);++a[ii];}//读入数据        
        dq.insert(a[1]);
        dp[1]=a[1];
        FOR(j,2,m){//从2开始DP
            dp[j]=*dq.begin()+a[j];
            if(j>d+1){
               dq.extract(dp[j-d-1]);
               //dq.extract(dq.find(dp[j-d-1]));
            }
            dq.insert(dp[j]);
//            s(*dq.begin());s(",");s(dp[j]);__;
//            s(dp[j]);__;
//            if(j>d+1){s(dp[j-d-1]);__;}
        }
        f[i]=dp[m];
//        endll;
    }

    ll ans=0,anss=2000000000000000ll;
    FOR(i,1,k-1) ans+=f[i];
    FOR(i,k,n){
        ans+=f[i];
        anss=min(ans,anss);
        ans-=f[i-k+1];
    }
    s(anss);endll;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT; cin>>TTT;
//    int TTT=1;
    while(TTT--){solve();}
    return 0;
}
```
