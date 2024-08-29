# Shop Game

所有者: Zvezdy
标签: 前缀和&差分, 贪心
创建时间: 2024年5月4日 00:10

其实这题可以总结为，alice买了一堆东西，bob会按另一套价钱买下所有物品，但bob可以选k个物品让它们免费。其实bob的选择是具有单调性的，他会选择前k大的b，那后面的商品我们自然是让他们能赚到就赚到，如果是买了就算亏的商品就不选了。可以考虑使用后缀和维护这些区间。

然后就是贪心了，已知我们只能赚到后半段的钱，并且后半段其实怎么赚都不关前半段的事。我们也需要尽可能消除那些无关条件，最后无论前面的东西无论是卖价高于买价还是什么的，我们最后都得送给bob，所以是不关差价的事的。那前半段我们可以选择买入最便宜的k个物品给bob。使用优先队列维护它。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
const int mode=998244353;
const int MAXN=200001;
struct good{
    int a,b;
}m[MAXN];
int money[MAXN];
void solve(){
    cint(n); cint(k);
    FOR(i,1,n) r(m[i].a);
    FOR(i,1,n) r(m[i].b);
    sort(m+1,m+n+1,[](good x,good y){
        return x.b>y.b;
    });
    money[n+1]=0; pque<int>mm;
    ROF(i,n,1) money[i]=money[i+1]+max(m[i].b-m[i].a,0ll);
    int dcre=0,ans=0;
    FOR(i,1,n){
        if(i-1>=k) ans=max(ans,money[i]-dcre);
        if(k && (mm.size()<k || m[i].a<mm.top())){
            if(mm.size()==k) dcre-=mm.top(),mm.pop();
            dcre+=m[i].a; mm.push(m[i].a);
        }
    }
    s(ans);endll;
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
