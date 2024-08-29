# Maze

所有者: Zvezdy

终极无敌超级大模拟题，分层图的BFS，当我们走到某一点的时候，我们拥有着不同的状态。因此BFS的vis数组不能简单地设置为2维，而应该是4维，分别记录：当前坐标、已走步数、方向如何。因为BFS的特性，所以只要某个点被搜索过以后，绝对能保证当前状态必定为最优路径，也就是最快到达。这样也可以完美解决绕环的问题。

由于我们开够了状态，并且保证了边界情况，就可以模拟更多的可能性，保证某些特例能被我们也考虑在内。实际BFS的搜索可以等跑到那个点上的时候再特判那些地方来没来过，合不合法，甚至可以通过覆盖更优操作来消除，然后再判断是否有效。如此统一操作判断可以让代码更好维护，写的时候也不容易出错。

还有一个技巧就是，我们可以使用一个数组来记录分别向不同方向行动时坐标的变化情况。然后我们就可以在bfs的时候通过for循环来模拟行走而不是每个方向都单独写一次。

三阶行列式优化代码结构还是挺美观的~

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
const int MAXN=107;
const int mode=1e9+7;
struct node{int x,y,stp,tot,d;};
int n,m,vis[MAXN][MAXN][5][2],ans;
char mp[MAXN][MAXN];
queue<node>q;
const int xx[]={-1,1,0,0},yy[]={0,0,-1,1};//上下左右 
void solve(){
	cin>>n>>m;
	
	ans=maxint; //初始化 
	for(int i=1;i<=n;++i)
		for(int j=1;j<=n;++j)
			for(int d=0;d<4;++d)
				vis[i][j][d][0]=vis[i][j][d][1]=maxint;
				
	for(int i=1;i<=n;++i)
		for(int j=1;j<=n;++j)
			cin>>mp[i][j];
			
	q.push((node){1,1,0,0,5});
	while(q.size()){
        
		node fro=q.front();
		q.pop();
        
		if(fro.stp>m||fro.tot>=ans) continue;
		if(fro.stp>=vis[fro.x][fro.y][fro.d][0] &&
				fro.tot>=vis[fro.x][fro.y][fro.d][1]) 
					continue;
        
		vis[fro.x][fro.y][fro.d][0]=min(fro.stp,vis[fro.x][fro.y][fro.d][0]);
		vis[fro.x][fro.y][fro.d][1]=min(fro.tot,vis[fro.x][fro.y][fro.d][1]);
        
		if(fro.x==n&&fro.y==n){
			ans=min(ans,fro.tot);
			continue; 
		}
        
		for(int i=0;i<4;++i){
			int nx=fro.x+xx[i],ny=fro.y+yy[i];
			if(nx<1||nx>n||ny<1||ny>n||mp[nx][ny]=='*') continue;
			q.push((node){nx,ny,(i==fro.d)?fro.stp+1:1,fro.tot+1,i});
		}
        
	}
	if(ans>=maxint) cout<<"-1\n";
	else cout<<ans<<"\n";
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

```
