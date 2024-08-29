# Weights Distributing

所有者: Zvezdy
标签: 广度优先搜索, 思维
创建时间: 2024年7月14日 14:50

很容易陷入找最少路程的误区，但是在推导以后发现在处理相同路程的选择方面非常麻烦，所以抛弃该方案。

我们来模拟一下这个人行进的路程，首先它先从a走到b，再从b走到c，这其中a→b→c可能不用走重复路线，也可能要走重复路线，我们设走重复路线那个路口为d，那么路径就变成了a→d→b→d→c，再考虑到d可能和b重合，那么我们就枚举d就行。具体做法就是跑三遍bfs求a、b、c到每个点的最短距离，将路价排序后打前缀和，重复部分放最前面，最后是跑pirce[ad+bd+cd]+price[bd]的最小值就好。

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
#define debug(x) cout << #x << " = " << x << endl
#define endl '\n'
#define fi first
#define se second
#define PII pair<int, int>
const int MODE = 1e9+7;
const int INF = 1e18;
int price[200001];
int head[200005],cnt;
struct Star{
    int to,next;
}edge[400005];
void Add_edge(int u,int v){
    auto& it=edge[++cnt];
    it.to=v,
    it.next=head[u];
    head[u]=cnt;
}
void solve() {
    int n,m; cin>>n>>m;
    cnt=0;
    memset(head,0,8*(n+1));
    int start[3];
    for(int i=0;i<3;++i){
        cin>>start[i];
    }
    for(int i=1;i<=m;++i){
        cin>>price[i];
    }
    sort(price+1,price+m+1);
    for(int i=1;i<=m;++i){
        price[i]+=price[i-1];
    }
    for(int i=1;i<=m;++i){
        int u,v; cin>>u>>v;
        Add_edge(u,v);
        Add_edge(v,u);
    }
    vector<vector<int>>dist(3,vector<int>(n+1,INF));
    function<void(int,int)>bfs=[&](int s,int ID){
        queue<PII>que;
        que.push({s,0});
        dist[ID][s]=0;
        while(que.size()){
            auto [id,dis]=que.front();
            que.pop();
            for(int i=head[id];i;i=edge[i].next){
                int to=edge[i].to;
                if(dist[ID][to]>dis+1){
                    dist[ID][to]=dis+1;
                    que.push({to,dis+1});
                }
            }
        }
    };for(int i=0;i<3;++i) bfs(start[i],i);

    int ans=INF;
    for(int i=1;i<=n;++i){
        int ad=dist[0][i];
        int bd=dist[1][i];
        int cd=dist[2][i];
        if(ad+bd+cd<=m){
            ans=min(ans,price[ad+bd+cd]+price[bd]);
        }
    }
    cout<<ans<<endl;
}
signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
//  A跑所有点，到它们最短要多少，B跑所有点，最短要多少，C跑所有点，最短要多少
```
