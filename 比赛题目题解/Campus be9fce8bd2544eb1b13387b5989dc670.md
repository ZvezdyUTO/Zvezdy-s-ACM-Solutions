# Campus

所有者: Zvezdy

看到特殊的数据范围不难想到暴力跑多次最短路，重点在于如何实现这个操作。

分时间段划分的部分我们使用左闭右开区间存储，先在数组中插入起始时间1和终止时间T+1，然后对于每一个时间段，都做左闭右开处理后push_back入时间数组中。最后sort后采用u.erase(unique(v.begin(),v.end()),v.end())进行去重处理，获得我们的时间条。

然后就是分时间段跑迪杰斯特拉了，我们以区间左端点为下标，循环处理区间，所以最终是跑到终点下标-1处。对于每一个时间段，暴力判断有哪些门是处于开放状态的，然后用它们来跑多源最短路。具体实现就是把他们都当做起点插入迪杰斯特拉的优先队列中，这样我们最后跑出来的每个dis就都是那个点离最近出口的距离。因为优先队列和迪杰斯特拉的性质，所以第一个被选中的路径一定为最短路，只要我们把dist数组一开始都设为-1，后面只更新那些没被更新过的dis就好。

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
int head[100005],cnt;
struct Star{
    int to,next,w;
}edge[200005];
void Add_edge(int u,int v,int w){
    auto& it=edge[++cnt];
    it.to=v,
    it.w=w;
    it.next=head[u];
    head[u]=cnt;
}
int man[100005];
void solve(){
    int n,m,k,T; cin>>n>>m>>k>>T;
    for(int i=1;i<=n;++i) cin>>man[i];

    vector<int>p(k+1),l(k+1),r(k+1);
    vector<int>v{1,T+1}; //起始，结束
    for(int i=1;i<=k;++i){
        cin>>p[i]>>l[i]>>r[i];
        ++r[i];
        v.push_back(l[i]);
        v.push_back(r[i]);
    }
    sort(v.begin(),v.end());
    v.erase(unique(v.begin(),v.end()),v.end());
    for(int i=1;i<=m;++i){
        int u,v,w;
        cin>>u>>v>>w;
        Add_edge(u,v,w);
        Add_edge(v,u,w);
    }

    for(int i=0;i<v.size()-1;++i){
        vector<int>dis(n+1,-1);
        priority_queue<PII,vector<PII>,greater<>>pq;
        for(int j=1;j<=k;++j){
            if(l[j]<=v[i] && v[i]<r[j]){
                pq.emplace(0,p[j]);
            }
        }
        while(pq.size()){
            auto [d,x]=pq.top();
            pq.pop();
            if(dis[x]!=-1){
                continue;
            }
            dis[x]=d;
            for(int i=head[x];i;i=edge[i].next){
                pq.emplace(d+edge[i].w,edge[i].to);
            }
        }
        int ans=0;
        if(find(dis.begin()+1,dis.end(),-1)!=dis.end()) ans=-1;
        else{
            for(int j=1;j<=n;++j){
                ans+=man[j]*dis[j];
            }
        }
        for(int j=v[i];j<v[i+1];++j){
            cout<<ans<<endl;
        }
    }
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