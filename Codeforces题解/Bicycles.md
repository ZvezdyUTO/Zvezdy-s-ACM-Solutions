# Bicycles

所有者: Zvezdy
标签: 分层图, 最短路
创建时间: 2024年5月9日 17:06

对于每辆不同的单车来说，它们的边长实际上是不一样的，所以这题是分层图。而且单车自然是越快越好，所以换到一个最快的单车的时候肯定就不用继续换单车了，也就是无“后效性”。那么就是经典排序了以后从后往前，也就是依次从最快到最慢的单车求最短路就好。求比较慢的单车的时候如果链接到了一个拥有更快单车的城市，就考虑两种情况：换车或者不换走到终点。那么我们就可以得出最优子结构。其实也不用求到最慢车的城市，求到起点就行了。

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
int n,m;
struct Edge{
    int to,dis,next; 
}edge[2*1005];
int head[1005];
int cnt=0;
void Add_edge(int from,int to,int w){//起点，终点，边权
    edge[++cnt].to=to;//记录终点
    edge[cnt].dis=w;//记录边权
    edge[cnt].next=head[from];//设置跳转点，跳到我们原来记录的头
    head[from]=cnt;//更新头
}
struct bike{int wh,v;}bik[1005];
int fast[1001];
int ans[1001];//答案存在这里面
//迪杰斯特拉板子
struct node{
    int id,dis;
    bool operator <(const node &a)const{return a.dis<dis;}
};//重载运算符自定义排序规则
int dist[1001]; bool vis[1001];
void Dijkstra(int s){//s为起点
    memset(dist,0,n+1);
    memset(vis,true,n+1);
    priority_queue<node>q;
    q.push(node{s,0});//默认构造函数
    for(int i=1;i<=n;i++) dist[i]=0x7fffffff;
    dist[s]=0;
    while(!q.empty()){
        node a=q.top(); q.pop();
        int now=a.id;
        if(!vis[now]) continue;
        vis[now]=1;
        for(int i=head[now]; i; i=edge[i].next){//遍历边
        //邻接表实际上可更快速地找到当前点的相邻边
            int j=edge[i].to;
            if(dist[now]+edge[i].dis<dist[j]){
                dist[j]=dist[now]+edge[i].dis;//到该点的最短边
                if(ans[j]!=maxll){//之前已经存有答案
                    ans[s]=min(ans[s],fast[s]*dist[j]+ans[j]);
                }
                q.push(node{j,dist[j]});

            }
        }
    }
    ans[s]=min(ans[s],dist[n]*fast[s]);
    // debug(dist[n]);
}
void solve(){
    r(n); r(m);
    FOR(i,1,n) ans[i]=maxll;
    FOR(i,1,m){
        cint(a);cint(b);cint(d);
        Add_edge(a,b,d);
        Add_edge(b,a,d);
    }
    FOR(i,1,n){cint(v);bik[i].wh=i;bik[i].v=v;}
    sort(bik+1,bik+n+1,[](bike x,bike y){
        return x.v<y.v;
    });
    FOR(i,1,n) fast[bik[i].wh]=bik[i].v;
    // FOR(i,1,n) s(ans[i])<<" "; endll;
    FOR(i,1,n){
        Dijkstra(bik[i].wh);
        // debug(bik[i].wh);
        if(bik[i].wh==1){
            s(ans[1]);
            endll;
            break;
        }
    }
    memset(edge,0,sizeof(edge));
    memset(head,0,sizeof(head));
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    cin>>TTT;
    while(TTT--){solve();}
    return 0;
}
//迪杰斯特拉只是跑最短路径，最终我们需要拿单车的速度去乘！
```