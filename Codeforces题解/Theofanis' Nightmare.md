# Theofanis' Nightmare

所有者: Zvezdy
标签: 数学, 贪心
创建时间: 2024年4月25日 22:36

分解数组，第几段就乘几。表面上是这么说，但可以考虑一下乘法的实质其实是加法，所以可以看成是越后面的小段累加的就越多。那么这么算来，其实我们就可以从后往前累加模拟了。只要是正的，那自然是加的越多越好，如果是负的就往前弄成正的再加。

而且考虑这个累加的状态，加入我们有数组{1,2,3}，那么1*1+2*2+3*3=(1+2+3)+(2+3)+3 发现其实是阶梯式地相加，从后往前遍历算后缀和，只要是正的就加到sum里面，循环结束后再特判一下边界情况就完事了。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
ll a[200001];
void solve(){
    cint(n);
    FOR(i,1,n) r(a[i]);
    ll now=0,ans=0;
    ROF(i,n,1){
        now+=a[i];
        if(now>0) ans+=now;
    }
    if(now<0) ans+=now;
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