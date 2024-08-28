# Cow Tours

所有者: Zvezdy
标签: floyd, 图的染色

一般来说floyd用于邻接矩阵比较适合。这题给出的数据也是邻接矩阵。对于邻接矩阵来说，其中的值存储的就是边权。看到不相交集合不一定是并查集，也可以是图的染色。染色是针对点来染色的，具体就是通过搜索遍历所关联的点，然后染色，每染一次更改一次颜色。同时，染色也可以达到一种分组的目的。

跑floyd就直接拿邻接矩阵的dist数组跑就行，可以得每个点到每个点的最短距离。每次遍历某个点的时候都把它所走的最长路求解出来，并以此更新该点所属颜色的最大最短路。因为在后面查找最大值的时候我们需要比较三个点：牧场A的最大值、牧场B的最大值、加上这条路后新牧场的最大值。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
// #pragma GCC optimize(2)
// #pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define endl '\n'
#define fi first
#define se second
#define dot pair<double,double>
int n; dot a[151];
double ojld(dot a, dot b){
    return sqrt((a.fi-b.fi)*(a.fi-b.fi)+(a.se-b.se)*(a.se-b.se));
}
double dist[151][151];
int col[151];//染色最后染的应该是点，因为是点的集合
double maxdis[151]; 
void dfs(int wh,int id){//dfs染色
    col[wh]=id;
    for(int i=1;i<=n;++i)//邻接矩阵使用元素代表边权，也代表联通
        if(!col[i] && dist[wh][i]<1e20)//没被访问过且联通
            dfs(i,id);
}
void floyd(){
    for(int k=1;k<=n;++k)//最终点一定在最外层
	    for(int i=1;i<=n;++i)
		    for(int j=1;j<=n;++j)
			    if(dist[i][j]>dist[i][k]+dist[k][j])
				    dist[i][j]=dist[i][k]+dist[k][j];
}
void solve(){
    cin>>n; for(int i=1;i<=n;++i) cin>>a[i].fi>>a[i].se;
    char now[151][151];
    for(int i=1;i<=n;++i){
        for(int j=1;j<=n;++j){
            cin>>now[i][j];
            if(now[i][j]=='1' || i==j){
                double len=ojld(a[i],a[j]);
                dist[i][j]=len;
                dist[j][i]=len;
            }
            else{
                dist[i][j]=1e20;
                dist[j][i]=1e20;
            }
        }
    }
    floyd();
    int colour=0;
    for(int i=1;i<=n;++i) if(!col[i]) dfs(i,++colour);
    double maxlen[151]{0};
    for(int i=1;i<=n;++i){//当前点 i
        maxlen[i]=0.0;//将i的通路初始化为0，并计算其所有通路
        for(int j=1;j<=n;++j)
            if(dist[i][j]<1e20)//i和j有通路
                maxlen[i]=max(maxlen[i],dist[i][j]);//i所属的最长路
        maxdis[col[i]]=max(maxdis[col[i]],maxlen[i]);//更新i所属颜色上的最长路
    }
    double ans=1e20;
    for(int i=1;i<=n;++i)
        for(int j=i+1;j<=n;++j){
            if(col[i]==col[j]) continue;
            double len=max({maxdis[col[i]],maxdis[col[j]],
                maxlen[i]+ojld(a[i],a[j])+maxlen[j]});//要么已有，要么新增
            ans=min(ans,len);
        }
    printf("%.6lf",ans);
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int t=1;
    // cin >> t;
    while(t--){
        solve();
    }
    return 0;
}

```