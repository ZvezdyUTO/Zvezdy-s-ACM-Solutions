# Trick or Treat on the Farm

所有者: Zvezdy
标签: 深度优先搜索

信息传递的升级版，不同的是，这次我们需要寻找每个节点到走完各自对应环的所需时间。在观察此类数据范围后可发现，实际上这种n个点n条边的图不仅对应着有且只有简单环，还对应着每个点所走的路线实际上是固定的，也就是没有岔路口。

另外使用dfs更新数据有几种方式，一种是通过上层返回回来的值来更新自身，另一种就是在遍历的过程中更新自身。想象这题的dfs，一直沿着一条路走走到终点然后返回。其中我们会走过单链以及环，其中环上的答案固定，而单链上的答案则需要累加，那么很显然这并不适合用某个答案累加下一层dfs来实现。

当我们dfs返回的时候，我们前方的数据一定可以被标记为：扫描过。那么如果我们在扫描单链的时候一边扫描一边更新自身答案，那么我们在递归回溯的时候，下一层的答案一定已经算好了，我们直接拿下一层的答案+1作为自身答案即可。那么现在就只剩下判环了，只要我们走到的地方已经被搜索过且没有被记录过答案，那么这里一定是一个环。记录此时的起点，计算这个环上的答案，然后回溯的时候修改答案直到回溯到这个环的起点。接着就是老样子修改答案。

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
#define dot pair<int,int>
int n,ans;
int gra[100001];
int len[100001],s[100001];
bool vis[100001];
int flag=0;
int dfs(int now,int nowc){//当前点，当前距离
    if(len[now]) return nowc-1+len[now]; //如果在环上，或者已经搜过，直接返回
    if(vis[now]==true){//不在环上，且已经搜过，说明找到了新的环
        len[now]=nowc-s[now];//当前答案值
        flag=now;//记录环点在哪里
        return nowc-1;//走了一圈环所用的时间以及累加回去是如何
    }
    vis[now]=true;s[now]=nowc;
    int ans=dfs(gra[now],nowc+1);
    if(flag!=0){//不为0说明现在手头上有一个环
        if(now==flag) flag=0;//环已经遍历完毕
        else len[now]=len[flag];//环上所有点的答案值都一样
    }
    else len[now]=len[gra[now]]+1; //如果不在环上就记录下一个房间的糖果数加1
    return ans;//返回答案值
}
void solve(){
    cin>>n; for(int i=1;i<=n;++i) cin>>gra[i];
    for(int i=1;i<=n;++i){
        if(!vis[i]) dfs(i,0);
    }
    for(int i=1;i<=n;++i) cout<<len[i]<<endl;
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