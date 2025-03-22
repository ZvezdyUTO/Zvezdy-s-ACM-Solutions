# Good Triples

所有者: Zvezdy
标签: 数学
创建时间: 2024年4月24日 20:43

无意中摸索出了这题的条件，如果想弄出满足题目条件的三元组那必须保证这三元组相加没有进位。
一开始想的是按位数拆数，然后排列组合，但发现这么讨论非常麻烦，其实可以从另一外一面想，这个数毕竟是还要三个相加变为原来那个数的。所以并不是真正的拆解位数，而是把某些位上的数分给了其他两个格子。

这是什么意思？举个例子，假设有一个数n，那么 n，0，0这个配置就是合法的，所以说拆数是把n上某一位拆给其他两位。

已知把某一位数上的数用隔板法拆入两个格子中是不会发生进位的，如果我们按位数模拟，个位拆，然后十位也拆，高位拆完加到低位永远不会有进位发生。所以各位数是互不干扰的。

一般使用排列组合中隔板法是不允许有两个隔板中间为空的情况存在的，也不允许两个隔板都放在同一边外侧，因此我们可以通过把原来两个格子左右各添一个格子，中间插一个格子的方式让隔板法能在特殊情况下成立，因此公式为C(NUM+3-1)(2)

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
    cll(n);
    ll ans=1;
    while(n){
        ll now=n%10;
        ans*=((now+2)*(now+1)/2);
        n/=10;
    }
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

重点还是在于没搞清楚哪些是可以相互影响的，哪些是不会相互影响的。还有就是数字的分解还有位数的问题，因为十就是十，百就是百，在有些时候不能单纯看成几个拼凑在一起的数字。另外在别的位数上做文章，比如分解或者啥啥的时候，要看有没有对其他位产生影响就得看有没有进位，而有没有进位还是得再三确认。卡了一晚上，真是被数学拷打了。