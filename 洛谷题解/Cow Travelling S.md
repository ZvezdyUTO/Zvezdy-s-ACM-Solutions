# Cow Travelling S

所有者: Zvezdy
标签: 记忆化搜索

看到求某步到达某处的题，第一时间想到分层图的可能，既然是分层图，那状态肯定就不只是其坐标，还需要考虑它的步数。先试着采用dfs进行求解。

dfs求解的一大问题是时间复杂度，解决方式可以是剪枝和挂缓存表，dfs和bfs的不同之处在于，dfs一定会有“回溯”这个操作，可以想象，在搜到某个点的时候它不仅会在当前点上进行操作，再别的地方搜回来的时候也会经过这个点，也可以再操作一次。这么就说明dfs可以把该点的后面所有步骤的答案一起“携带“回来，因此，将函数类型改为int后，就可以记录该点后面的答案数量。

如何将我们的答案以整形的方式携带回来？这需要看我们这题在求解什么，在规定步骤内到达终点的方案数。按朴素的思想来说，我们通过某种步骤到达终点，那么ans就+1，到达其它点则直接return，既然return那么就是原路一级一级返回回来，所以我们如果走到了终点那么就返回一个函数值+1，否则返回0。dfs还有一个特点就是它在经过某个点的时候，一定会把其后续的所有点全部搜干净，所以我们在从其它地方返回到某处的时候，证明该处的后续答案已经被搜干净了，那么下次再来到这个点就不用继续走老路而是直接返回其答案值就可以。这就是记忆化搜索。

那么还有另外一个优化手段就是剪枝。假如我们到某个点后可以提前预知，该点绝不可能通往终点了，那么就可以提前cut掉这个点以及其后续所有的点，手段则是直接从这个点挂缓存表并返回，那么其后续所有无用点自然不会被搜索到。

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
#define fi first
#define se second
#define dot pair<int,int>
char mp[105][105];
int save[105][105][16];
int dx[]{1,0,-1,0},dy[]{0,1,0,-1};
// bitset<108>vis[108];
dot st,ed; int n,m,k;
int dfs(int x,int y,int step){
    // cout<<x<<" "<<y<<endl;
    if(save[x][y][step]!=-1) return save[x][y][step];
    if(abs(ed.fi-x)+abs(ed.se-y)>k-step) return save[x][y][step]=0;
    if(step>k) return save[x][y][step]=0;
    if(step==k) if(x==ed.fi && y==ed.se) return save[x][y][step]=1;
    else return save[x][y][step]=0;
    int ans=0;
    for(int i=0;i<4;++i){
        if(mp[x+dx[i]][y+dy[i]]=='*') continue;
        ans+=dfs(x+dx[i],y+dy[i],step+1);
    }
    return save[x][y][step]=ans;
}
void solve(){
    memset(mp,'*',sizeof(mp));
    memset(save,-1,sizeof(save));
    cin>>n>>m>>k;
    for(int i =1;i<=n;++i) for(int j=1;j<=m;++j) cin>>mp[i][j];
    cin>>st.fi>>st.se>>ed.fi>>ed.se;
    cout<<dfs(st.fi,st.se,0);
}
signed main() {
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
    int t=1;
    // cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}

```
