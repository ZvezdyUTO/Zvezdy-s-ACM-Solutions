# Chain Queries

所有者: Zvezdy
标签: 树上问题
创建时间: 2024年6月20日 21:00

根据最近两题摸索出了相邻元素的判断trick，用1和-1进行赋值后累加会对相邻元素的处理有意想不到的效果。这道树题还有一个trick，对于树上的所有节点，都只有唯一一个自己的父节点，所以从父节点找信息下手是不容易超时的。

再来就是链条的判断，既然是链条，可以想象每个单元一环扣一环地链接在一起，为了实现这个效果，就让每个黑色节点自己-1，其父节点+1，这样就能串成一条头为1，尾为-1的链条，拿set分别记录当前值为+1、-1的节点，每次操作后都更新信息并统计+1与-1的数量。当然有一个特殊情况：当根节点为黑的时候，我们算根节点的父节点编号为0（虚根），此时会有两个+1和两个-1，分析后可以发现如果两个+1是相连并且它们一黑一白的时候符合要求。

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
#define dot pair<int,int>
int MODE = 998244353;
const int INF = 1e15;
int cnt,head[200005];//链式前向星
struct Edge{
    int to,next;
}edge[400005];//记得双向边开双倍
void Add_edge(int from,int to){
    edge[++cnt].to=to;
    edge[cnt].next=head[from];
    head[from]=cnt;
}
int mark[200001],father[200001];
bool col[200001];
void solve(){
    mark[0]=0;
    int n,m; cin>>n>>m;
    memset(head,0,8*(n+1));
    for(int i=1;i<=n;++i){
        cin>>col[i];
        mark[i]=0-col[i];
    }
    for(int i=1;i<n;++i){
        int u,v; cin>>u>>v;
        Add_edge(u,v);
        Add_edge(v,u);
    }
    function<void(int,int)>init=[&](int now,int par)->void{
        father[now]=par;
        if(mark[now]==-1) ++mark[par];
        for(int i=head[now];i;i=edge[i].next){
            int to=edge[i].to;
            if(to==par) continue;
            init(to,now);
        }
    };init(1,0);
    set<int>f1,z1;
    for(int i=0;i<=n;++i){
        if(mark[i]>0) z1.insert(i);
        if(mark[i]<0) f1.insert(i);
    }
    for(int i=1;i<=m;++i){
        int now; cin>>now;
        int par=father[now];
        if(col[now]){ //黑变白
            ++mark[now];
            col[now]=false;
            if(mark[now]==0) f1.erase(now);
            else if(mark[now]==1)z1.insert(now);

            --mark[par];
            if(mark[par]==-1) f1.insert(par);
            else if(mark[par]==0)z1.erase(par);
        }
        else{ //白变黑
            --mark[now];
            col[now]=true;
            if(mark[now]==-1) f1.insert(now);
            else if(mark[now]==0)z1.erase(now);

            ++mark[par];
            if(mark[par]==0) f1.erase(par);
            else if(mark[par]==1)z1.insert(par);

           
        }
        //  debug(z1.size()); debug(f1.size());
        if((z1.size()==1 && f1.size()==1)){
            cout<<"Yes"<<endl;
            continue;
        }
        if(z1.size()==2 && f1.size()==2){
            int a=*z1.begin(),b=*next(z1.begin());
            if(col[a]!=col[b]
                && (father[a]==b || father[b]==a)){
                    cout<<"Yes"<<endl;
                    continue;
            }
        }
        cout<<"No"<<endl;
    }
    // debug(father[2]);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy = 1;
    cin >> Zvezdy;
    while (Zvezdy--) {
        solve();
    }
    return 0;
}
```
