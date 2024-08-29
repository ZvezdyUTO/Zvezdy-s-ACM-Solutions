# Microcycle

所有者: Zvezdy
标签: 克鲁斯卡尔重构树, 深度优先搜索
创建时间: 2024年6月17日 13:25

都评价这题比较板，但还是运用了一些技巧。首先题目要我们找存在最小边的那个环，找环要么使用拓补排序，要么使用并查集，考虑到这题是找存在最小边的环，完美符合使用克鲁斯卡尔重构树的条件。

如果两个点在拥有同一公共祖先，那么它们就可以构成一个环。为了让图尽可能的完整，我们将边从大到小排序，并且一边排序一边建图，记录最后出现的符合要求的一对点集以及边权即可找到答案。接下来使用dfs来输出环中的内容，记录vis数组以及父节点跑搜索，每次跑到一个新的点就记录在答案数组中，如果最后发现这个点不能跑到我们的目标点，就把它弹出答案。如果某条路径最终跑到了答案，那么就立刻输出答案数组。使用bool类型的dfs可以在最终找到答案返回true的时候，一路返回ture达到直接退出的效果。

写图论还是得多亲自手写，因为码量大。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \____|  \__  |★*/
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
const int MODE = 998244353;
const int INF = 1e15;
struct DSU {
    vector<int>f, siz;
    DSU() {}//记得创建的时候为打括号，n+1
    DSU(int n) {//初始化项目
        init(n);
    }
    void init(int n) {
        f.resize(n);
        iota(f.begin(), f.end(), 0);
        siz.assign(n, 1);
    }
    int find(int x) {//找祖宗，顺带路径压缩
        while (x != f[x]) {
            x = f[x] = f[f[x]];
        }
        return x;
    }
    bool same(int x, int y) {//看两个元素是否属于同一集合
        return find(x) == find(y);
    }
    bool merge(int x, int y) {//将两个元素的集合合并
        x = find(x);
        y = find(y);
        if (x == y) {
            return false;
        }
        siz[x] += siz[y];
        f[y] = x;
        return true;
    }
    int size(int x) {//获取某个元素所在集合的元素个数
        return siz[find(x)];
    }
};
int cnt,head[200005];//链式前向星
struct input{int u,v,w;}inp[200005];
struct Edge{
    int to,dis,next;
}edge[400005];//记得双向边开双倍
void Add_edge(int from,int to,int w){
    edge[++cnt].to=to;
    edge[cnt].dis=w;
    edge[cnt].next=head[from];
    head[from]=cnt;
}
int ans[200001];
void solve(){
    int n,m; cin>>n>>m;
    DSU dsu(n+1); memset(head,0,8*(n+1));
    for(int i=1;i<=m;++i) cin>>inp[i].u>>inp[i].v>>inp[i].w;
    sort(inp+1,inp+m+1,[&](input x,input y){return x.w>y.w;});
    //读入数据以及初始化
    //从大到小排序边，为了能在找到答案的时候保证图尽可能完全

    int a,b,dst;//最终结果
    for(int i=1;i<=m;++i){
        Add_edge(inp[i].u,inp[i].v,inp[i].w);
        Add_edge(inp[i].v,inp[i].u,inp[i].w);
        //建边

        if(dsu.same(inp[i].u,inp[i].v)){
            a=inp[i].u;
            b=inp[i].v;
            dst=inp[i].w;
        }//发现环，更新答案
        else dsu.merge(inp[i].u,inp[i].v);//构建不相交集合
    }

    int tot=0;
    bitset<200001>vis;
    function<bool(int,int)>dfs=[&](int now,int par)->bool{
        
        ans[++tot]=now; //每次搜索到新的点就立刻记录到答案数组中

        if(now==b){ //第一次走回起点，也就是找到环了
            cout<<dst<<" "<<tot<<endl;
            for(int i=1;i<=tot;++i) cout<<ans[i]<<" ";
            cout<<endl;
            return true;
        }

        vis[now]=true;
        for(int i=head[now];i;i=edge[i].next){
            int to=edge[i].to;
            if(to==par || vis[to]) continue; //发现走过或者为父节点
            if(dfs(to,now)) return true; //继续搜索，如果找到了就直接退出
        }
        --tot; //此处并不能连通最终边，回溯。
        return false;
    }; dfs(a,b);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    long Zvezdy=1;
    cin>>Zvezdy;
    while (Zvezdy--){
        solve();
    }
    return 0;
}

```
