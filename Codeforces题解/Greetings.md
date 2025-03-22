# Greetings

所有者: Zvezdy
标签: 思维, 树状数组
创建时间: 2024年4月24日 16:02

一个人在行进过程中经过了几个人的终点，他就会和几个人打招呼。

其实完全可以抛开行进这个过程，假如我们按每个人的起点从小到大排序，再按这个顺序遍历终点就可以达到效果。

比如5 1 2 3 6，可以发现终点为5的人经过了终点为1 2 3的人。并且因为我们是单向遍历所以防止了出现重复打招呼的情况，于是这题就变成了求逆序对的数量。

然后就是树状数组求逆序对了，套板子就行：

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
const int MAXN=200001;
class tree_list {
public:
    int lowbit(ll x){
	    return x & (-1 * x);
    }
	void add(ll index,ll num){//在index处添加num
		for (; index <MAXN; index += lowbit(index))
			arry[index]+=num;
	}
	ll ask(ll index){//查找元素
		ll ans = 0;
		for (; index ; index -= lowbit(index))
			ans += arry[index];
		return ans;
	}
	ll arry[MAXN]{0};
};
struct man{
    ll a,b;
}m[200001];
void solve(){
    cint(n);
    FOR(i,1,n){
        r(m[i].a);
        r(m[i].b);
    }
    sort(m+1,m+n+1,[](man x,man y){
        return x.b<y.b;
    });
    FOR(i,1,n) m[i].b=i;
    sort(m+1,m+n+1,[](man x,man y){
        return x.a<y.a;
    });
    ll ans=0;
    tree_list now;
    ROF(i,n,1){
        ans+=(now.ask(m[i].b));
        now.add(m[i].b,1);
    }
    s(ans); endll;
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