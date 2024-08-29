# Game on Tree (Hard)

所有者: Zvezdy
标签: 博弈论, 树形DP, 重新根
创建时间: 2024年6月11日 18:45

普通的话就树形dp就好，但这题不大一样，因为要判断根不同的情况。根不同的时候和根就一个的时候有什么区别？按平时来说，就是在悬挂处往左、往右走，所以一些节点的输或者赢是按照一种单向路径来走的，但如果将它变成了根，他就有往回走的机会。如果它的父节点是通过往它走才拿到必胜的，那么当其父节点不能重复路径的时候就已经沦为必败，此时该节点往回走可以拿到必胜，如此更新信息以计算所有节点的最终状态。

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
#define dot pair<int, int>
const int MODE = 1e9+7;
const int INF = 1e15;
int cnt,head[200005];//链式前向星
struct Edge{
    int to,next;
}edge[2*200005];//记得双向边开双倍
void Add_edge(int from,int to){
    edge[++cnt].to=to;
    edge[cnt].next=head[from];
    head[from]=cnt;
}
int ans[200001]; bool finalans[200001];
bool dfs(int now,int par){//true则必胜，否则必败
    for(int i=head[now];i;i=edge[i].next){
        int next=edge[i].to;
        if(next==par) continue;
        ans[now]+=(!dfs(next,now));
    }
    return (bool)ans[now];
}
void dfs2(int now,int par){
    finalans[now]=ans[now]>0;
    for(int i=head[now];i;i=edge[i].next){
        int next=edge[i].to;
        if(next==par) continue;

        bool cut=(!ans[next]);
        ans[now]-=cut;//切掉的代价
        if(!ans[now]) ++ans[next];//如果变为必败则修改下方

        dfs2(next,now);//向下搜索
        
        if(!ans[now]) --ans[next];
        ans[now]+=cut;
    }
}
void solve(){
    int n,t; cin>>n>>t;
    for(int i=1;i<n;++i){
        int u,v; cin>>u>>v;
        Add_edge(u,v);
        Add_edge(v,u);
    }
    dfs(1,1); dfs2(1,1);
    while(t--){
        int now; cin>>now;
        if(finalans[now]) cout<<"Ron"<<endl;
        else cout<<"Hermione"<<endl;
    }
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int TTT = 1;
    // cin>>TTT;
    while (TTT--){
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}

```
