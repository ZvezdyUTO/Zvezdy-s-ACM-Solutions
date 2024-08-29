# Sasha and a Walk in the City

所有者: Zvezdy
标签: 树形DP, 组合数学
创建时间: 2024年6月14日 18:21

一道不错的组合数学题目，不过想的有些复杂了，其实分析情况很简单。组合数的状态表示的自然是当前节点以及其子树的信息，下面分析问题来讨论我们需要什么，如何转移：

我们可以这么选：要么什么也不选，要么我们这颗树目前只有一个危险节点，要么已经有两个危险节点了。那么重点就是如何转移了：

首先什么也不选肯定只有一种情况；

然后，如果是只有一个危险节点的话，就是选择或者不选择部分子树的方案之积。因为是简单路，所以各个不同的同根子树中的节点是互不影响的，可以选部分，也可以不选部分，+1就是表示不选的那个，最后这样乘出来会多出一个什么也不选的多余方案，记得减掉；

最后，是该子树选两个的情况，首先是把下面子树选两个的方案累加上来，然后再加上下方只选1个+选目前根节点的方案。

往回返回dp[1][now]信息的时候，我们在原来的时候多统计了全部不选的方案，以及少统计了只选根节点的方案，+1-1完抵消了，所以直接返回就好。

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
int cnt,head[300005];//链式前向星
struct Edge{
    int to,next;
}edge[600005];//记得双向边开双倍
int dp[3][300005];//0 1 2
void Add_edge(int from,int to){
    edge[++cnt].to=to;
    edge[cnt].next=head[from];
    head[from]=cnt;
}
void solve(){
    int n; cin>>n; cnt=0;
    memset(head,0,8*(n+1));
    for(int i=1;i<n;++i){
        int u,v; cin>>u>>v;
        Add_edge(u,v);
        Add_edge(v,u);
    }

    function<int(int,int)>dfs=[&](int now,int par)->int{ //不同节点选1个的方案
        dp[0][now]=1; dp[1][now]=1; dp[2][now]=0; //初始化
        for(int i=head[now];i;i=edge[i].next){
            int to=edge[i].to;
            if(to==par) continue;

            dp[1][now]*=(dfs(to,now)+dp[0][to]);
            //乘法原理计算方案，+1是为了表示不选的方案
            dp[2][now]+=dp[1][to]+dp[2][to];
            //收集下方的答案，更新自己的答案
            dp[1][now]%=MODE;
            dp[2][now]%=MODE;
        }
        return dp[1][now];
    }; dp[1][1]=dfs(1,1);

    cout<<(dp[0][1]+dp[1][1]+dp[2][1])%MODE<<endl;
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
