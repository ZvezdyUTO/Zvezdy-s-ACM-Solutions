# Maximum Set

所有者: Zvezdy
标签: 位掩码, 数学
创建时间: 2024年4月19日 09:12

其实是一开始没读懂题目，题目所描述的是：要我们求一个集合，满足集合内各数都可以整除彼此，然后第二点是，有多少个这么大的不同集合。

根据因数来看，只要我们满足后面的每个数都是前面的数乘上什么就能构造出集合，对于最大的集合，肯定是最左边的数不停x2直到结尾。其中乘上的数不可能超过3，因为没办法达到最大集合的要求，我们需要保证集合最大。那这么看来，也只有可能乘上1个3，因为乘两个就变成9了。。。                                      

有两个比较方便的运算语句：`log(r/l)` 快速求对数，以及位运算中的`1<<n` 这个式子可以快速求出2的n次幂。

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

void solve(){
    ll maxn=0,num=0;
    cll(l);cll(r);
    maxn=(ll)log2(r/l)+1;
    ll ii=maxn-1;
    num+=(r/(1<<ii)-l+1);
//    debug(num);
    if(ii){
        ll g=r/((1<<ii-1)*3)-l+1;
//        s(1<<0);endll;
        if(g>0) num+=(ii*g);
    }
    s(maxn);__;s(num); endll;
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
//n+x-2=?(2k-2)
//13 37
//37/2=18
//13 14 15 16 17 18
//37/3=12

//4 100
//4 5 6 7
//5 6 7
//中间不能有x4
//l ~ 2l-1
//x2x2x2x2x2x2x3?

//l->r/n2
//l->r/n2*2/3
//i*n2/2*3<=r
```
