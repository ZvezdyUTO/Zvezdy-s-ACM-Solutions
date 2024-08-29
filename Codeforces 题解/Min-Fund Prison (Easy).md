# Min-Fund Prison (Easy)

所有者: Zvezdy
标签: 树形DP, 计数原理
创建时间: 2024年6月12日 10:16

写的比较沟槽，必须再回顾一下计数原理，如果有m个和为n的数，那么求出m-1个数以后就可以通过减法求出最后一个数。这题想找到的是把树分为差值尽可能小的两部分，那么就可以找出其中一半部分，然后算出另外一半部分。因为要找的两部分要求是其节点数差值尽可能小，所以可以以任意一个位置为根来求其子树节点数。

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
int cnt;//链式前向星
struct Edge{
    int to,next;
}edge[2*200005];//记得双向边开双倍
void Add_edge(int from,int to,int* head){
    edge[++cnt].to=to;
    edge[cnt].next=head[from];
    head[from]=cnt;
}
int anss[200005];
void solve(){
    int n,m,c; cin>>n>>m>>c;
    int head[200005]{0};
    for(int i=1;i<=m;++i){
        int u,v; cin>>u>>v;
        Add_edge(v,u,head);
        Add_edge(u,v,head);
    }
    function<int(int,int)>dfs=[&](int now,int par)->int{
        int ans=1;
        for(int i=head[now];i;i=edge[i].next){
            int to=edge[i].to;
            if(to==par) continue;
            ans+=dfs(to,now);
        }
        anss[now]=ans;
        return ans;
    };
    dfs(1,1); int ans=INF;
    for(int i=1;i<=n;++i)
        ans=min(ans,anss[i]*anss[i]+(n-anss[i])*(n-anss[i]));
    cout<<ans<<endl;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int TTT = 1;
    cin>>TTT;
    while (TTT--){
        // cout<<TTT<<" ";
        solve();
    }
    return 0;
}

```
