# Super Takahashi Bros.

所有者: Zvezdy
标签: 图论, 最短路

长个心眼，其实这玩意是一个图，它的实际内核就是点，边权。

既然是一张图，那我们就可以构建后弄最短路。

```cpp
/*  _____                           _         */
/* |__  / __   __   ___   ____   __| |  _   _ */
/*   / /  \ \ / /  / _ \ |_  /  / _  | | | | |*/
/*  / /_   \ V /  |  __/  / /  | (_| | | |_| |*/
/* /____|   \_/    \___| /___|  \__._|  \__, |*/
/*                                      |___/ */
#include<bits/stdc++.h>
using namespace std;
#define ld long double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x;endl;
#define FOR(word,endd) for(int word=1;word<=endd;++word)
#define ROF(word,endd) for(int word=endd;word>=1;--word)
#define cmp(what_type) function<bool(what_type,what_type)>
#define read(x); cin>>x;
#define say(x); cout<<x;
#define putin(x); int x;cin>>x;
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endl; cout<<endl;
#define dot pair<int,int>
int cnt=0;
struct star{
    ll to,dis,next; 
}edge[400005];
int head[200005];
void Add_edge(int from,int to,int w){//起点，终点，边权
    edge[++cnt].to=to;//记录终点
    edge[cnt].dis=w;//记录边权
    edge[cnt].next=head[from];//设置跳转点，跳到我们原来记录的头
    head[from]=cnt;//更新头
}
struct node{
    ll id,dis;
    bool operator<(const node &a)const{return a.dis<dis;}
};
int n;
int vis[200001];
ll dist[200001];

void dijstra(int begin){
    pque<node>q;
    q.push(node{begin,0});
    FOR(i,n) dist[i]=maxll;
    dist[begin]=0;
    while(!q.empty()){
        node a=q.top();
        q.pop();
        int now=a.id;
        if(vis[now]) continue;
        vis[now]=1;
        for(int i=head[now];i;i=edge[i].next){
            int j=edge[i].to;
            if(dist[now]+edge[i].dis<dist[j]){
                dist[j]=dist[now]+edge[i].dis;
                q.push(node{j,dist[j]});
            }
        }
    }
}
void solve(){
    read(n); FOR(i,n){
        putin(a);putin(b);putin(x);
        Add_edge(i,i+1,a);
        Add_edge(i,x,b);
    }
    dijstra(1);
    say(dist[n]);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    int T; cin>>T;
    int T=1;
    while(T--){solve();}
    return 0;
}
```
