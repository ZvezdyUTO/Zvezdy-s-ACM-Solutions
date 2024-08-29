# Triangle Construction

所有者: Zvezdy
标签: 思维
创建时间: 2024年5月10日 12:20

一道很难绷的思维题。。。其实如果多模拟几遍就会发现，只要有三个点，不是在同一条边上面的，就可直接构成一个三角形，或者说找到一种拼法使出来的三角形绝对不相交，所以考虑sum of n/3。

但有一种特殊情况，假如把所有其它边的顶点用完了，但还剩三个以上的点在一条边上，就无法继续弄成三角形了。考虑最优的情况，其它边上的每个点都用来当做顶点，然后最长那条边上的点都拿来做底，刚好完全匹配的时候可得知：其它边上的顶点*2=最多顶点的边上的点数。最后得出结论，如果其它所有边上点的数量*2≤最多点的边上的点数量，那就是所有点数量/3，不然就是除最长边上所有顶点的数量。

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
int a[200001];
void solve(){
    cint(n); FOR(i,1,n) r(a[i]);
    sort(a+1,a+n+1);
    int sum=0;
    FOR(i,1,n-1) sum+=a[i];
    if(sum*2<a[n]) s(sum);
    else s((sum+a[n])/3);
}

signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int TTT=1; 
    // cin>>TTT;
    while(TTT--){solve();}
    return 0;
}

```
