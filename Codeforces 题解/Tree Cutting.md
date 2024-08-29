# Tree Cutting

所有者: Zvezdy
标签: dfs, 二分答案, 图论
创建时间: 2024年4月1日 19:54

求最小的最大，很明显的一道二分答案问题。而更大的问题是我们怎么check.

因为这题是一棵树，可以采用vector构建二维数组的方式实现邻接表存储。

接着就是模拟切割，这题的单调性在于，如果我们能切割得至少有长为n的子树，那么我们就一定能切割出至少长为n-1的子树

重点在于怎么实现切割，已知我们可以在dfs回溯的时候统计某个节点下面一共有多少个子节点，我们就可以在这个上面做文章，当我们回溯到某个子节点的时候，假如它的点已经大于等于mid，那我们就令当前的回溯值为0达到“切割”的效果，然后统计一共切割了几次。

至于树的dfs，求实没必要在意从哪作为起点，因为折叠一下就会发现，无论从哪个点悬挂这棵树，那个点都可以成为一个合格的父节点，建树是无向边，并且不能重新搜索父节点。

```cpp
/* ★ _____                           _         ★*/
/* ★|__  / __   __   ___   ____   __| |  _   _ ★*/
/* ★  / /  \ \ / /  / _ \ |_  /  / _  | | | | |★*/
/* ★ / /_   \ V /  |  __/  / /  | (_| | | |_| |★*/
/* ★/____|   \_/    \___| /___|  \__._|  \__, |★*/
/* ★                                     |___/ ★*/
//#pragma GCC optimize(2)
//#pragma GCC optimize(3,"Ofast","inline")
#include<bits/stdc++.h>
using namespace std;
#define ld long double
#define ll long long
#define fi first
#define se second
#define maxint 0x7fffffff
#define maxll 9223372036854775807
#define all(v) v.begin(), v.end()
#define debug(x) cout<<#x<<"="<<x; endll
#define save(x) std::cout << std::fixed << std::setprecision(x)
#define FOR(word,begin,endd) for(auto word=begin;word<=endd;++word)
#define ROF(word,begin,endd) for(auto word=begin;word>=endd;--word)
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
int n,k;
vector<int>tree[200001];
int siz[200001],cnt=0;
void dfs(int u,int fa,int x){
	siz[u]=1;
	for(auto v:tree[u]) if(v!=fa){
		dfs(v,u,x);
		siz[u]+=siz[v];
	}
	if(siz[u]>=x){
		cnt++;
		siz[u]=0;
	}
}
int check(int x){
	cnt=0;
	dfs(1,0,x);
	return cnt-1;
}
void solve(){
    r(n); r(k);
    FOR(i,1,n-1){
        cint(a); cint(b);
        //无向边
        tree[a].push_back(b);
        tree[b].push_back(a);
    }
    int l=1,r=n,mid;
	while(l<r){
		mid=l+r+1>>1;
		if(check(mid)>=k) l=mid;
		else r=mid-1;
	}
	s(l); endll;
    FOR(i,1,n) tree[i].clear();
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT; cin>>TTT;
//    int TTT=1;
    while(TTT--){solve();}
    return 0;
}
```
