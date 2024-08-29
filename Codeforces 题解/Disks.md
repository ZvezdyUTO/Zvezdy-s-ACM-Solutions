# Disks

所有者: Zvezdy
标签: 二分图, 几何
创建时间: 2024年5月7日 20:09

看假题了，实际上这题非常简单。。。意思是给了一堆不相交但是有可能相切或者相离的圆，问能不能找到一种方案使得在减小所有半径之和的情况下保证原来相切的圆还是相切。

如果几个圆相切，那么某个圆变大的时候，和它相切的那些圆就要变小，依次类推，一个相切的链就应该是：变大 变小 变大 变小。。。交错进行。如果出现了两个相邻的都要求变大，那一定是否。我们将所有相切的圆连成图，判断有没有奇数环就行。还得统计一下变大和变小的数目，必须不一样，用图的染色来完成这个过程：

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
#define int long long
#define ld double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define ddbug(x) cout<<x<<" "
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(int word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(int word=begin;word>=endd;--word)
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
constexpr int maxn=1005;

int n,x[maxn],y[maxn],r[maxn];
vector<int> e[maxn];//邻接表
inline ll sq(ll x){return x*x;}
int f,cnt[2],vis[maxn];//黑白点的数量、每个点的初始染色状态
void dfs(int p,int w){
    if(~vis[p]) return f&=(vis[p]==w),void();//已经被染色
    vis[p]=w,cnt[w]++;//染色
    for(auto x:e[p]) dfs(x,!w);//根据邻接表继续dfs
}
void solve(){
    cin>>n;for(int i=1;i<=n;i++) cin>>x[i]>>y[i]>>r[i];
    for(int i=1;i<=n;i++)
    for(int j=i+1;j<=n;j++){
        if(sq(x[i]-x[j])+sq(y[i]-y[j])<=sq(r[i]+r[j])){
            e[i].push_back(j);
            e[j].push_back(i);
        }
    }
    memset(vis,-1,sizeof vis);
    for(int i=1;i<=n;i++) if(!~vis[i]){
        f=1;cnt[0]=cnt[1]=0;
        dfs(i,0);
        if(f && cnt[0]!=cnt[1]){
            s("YES");
            return;
        }
    }
    s("NO");
}

signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    // cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```
