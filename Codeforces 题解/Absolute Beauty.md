# Absolute Beauty

所有者: Zvezdy
标签: 数学
创建时间: 2024年5月10日 22:27

绝对值，看到这个可以把一组绝对值看作线段，值自然是线段的长度，那么可以联想到线段的三种关系：相交、相离、包含。在草稿手推完这几种情况后可以发现，只有相离的情况下交换顶点有用，得出来的值是两个线段空隙的两倍，排序两遍贪心一下就可以写出来。

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
struct line{
    int a,b;
}l[300001];
void solve(){
    int ans=0;
    cint(n);
    FOR(i,1,n) r(l[i].a);
    FOR(i,1,n) r(l[i].b);
    FOR(i,1,n){
        if(l[i].b>l[i].a) swap(l[i].b,l[i].a);
        ans+=(l[i].a-l[i].b);
    }
    sort(l+1,l+n+1,[](line x,line y){
        return x.a>y.a;
    });
    int bb=l[n].a;
    sort(l+1,l+n+1,[](line x,line y){
        return x.b>y.b;
    });
    int aa=l[1].b;
    if(aa>=bb) ans+=abs(2*(aa-bb));
    s(ans); endll;
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
