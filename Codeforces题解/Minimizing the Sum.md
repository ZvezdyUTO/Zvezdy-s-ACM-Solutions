# Minimizing the Sum

所有者: Zvezdy
标签: 动态规划
创建时间: 2024年4月30日 10:59

实际上就是以某些数字为中心覆盖掉周围所有的数字，求最后能得出的最小数字和。题目给出k≤10，可以考虑一位一位暴力枚举。

既然每个数都只能从自己本身出发，那会不会有这么一种情况，前面的数字往左覆写了三个数字，它右边的数字又往左覆写了三位数字，导致前面那个数字出现“断层”？不可能，因为既然后面的数字能做到覆盖前面的数字，说明它一定比前面的数字大，所以它会覆盖前面数字覆盖的所有地方。而覆盖这个操作只需要做一次，所以后面的操作可以代替前面的操作，于是使用DP求解。

覆写是怎么样一种状态？是简单的减去它和其他数的差值吗？一般而言想到的应该是数组从左往右推导，当到某个地方的时候已经保证它前面是最佳状态，但是在这题中，元素还可以向右覆写造成影响，所以我们也需要考虑某个元素向右拓展的情况。在每次拓展中，我们不知道还能不能继续拓展也就是说我们不知道当前k值还剩多少，那我们就可以把这个状态加入到我们的方程中。

由前面推导的条件可知，我们区间修改只要把某个连续区间全部变成里面最小值就好。因为是连续区间所以不存在中间被掐断的情况。我们需要往左推导，又需要往右推导，种种考虑下，我们可以将方程的另一个状态定义为：当前点的最小前缀和。

状态转移方程，只要有前置状态就能转移，有时候不用管数组的位置（区间dp和背包又不一样），求出状态转移方程就可以解决问题啦~这场刚好上1400，纪念一下❤

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
int a[300001];
void solve(){
    cint(n); cint(k);
    FOR(i,1,n) r(a[i]);
    int dp[n+1][k+1];
    FOR(i,0,n) FOR(j,0,k) dp[i][j]=1e16;
	dp[0][0]=0; dp[1][0]=a[1];
	FOR(i,2,n){FOR(j,0,k){
		int now=a[i];
		dp[i][j]=dp[i-1][j]+a[i];//做一个前缀和
    //看能否用i前面的某个小的数将从l开始的这个区间填满； 
		//左端最多能到i-j这个点，i - j， i = 3， j = 2，
    //将1，2，3都用其中最小的数填满，操作两次
        ROF(l,i-1,max(1,i-j)){
			now=min(now,a[l]);
			dp[i][j]=min(
                dp[i][j],
                //从前面的已经操作了几次转移过来
                dp[l-1][j-(i-l)]+now*(i-l+1)
            );}
	    }
	}
	int ans=1e16;
    FOR(i,0,k) ans = min(ans,dp[n][i]);
	s(ans);endll;
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