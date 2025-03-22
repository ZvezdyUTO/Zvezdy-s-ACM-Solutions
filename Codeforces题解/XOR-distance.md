# XOR-distance

所有者: Zvezdy
标签: 位运算, 数学
创建时间: 2024年4月22日 19:28

和某次d2那个挠蝉C有异曲同工之妙，都是让两个数相近。根据异或运算的性质，两个位数不同直接让大的数切割就好了。。可惜位运算的操作不熟悉导致没有切出这道题。

来看一下如何通过位运算来取某个数在二进制下的某一位：

1ll<<i 可以求出2的 i 次方，在这种情况下使用&运算符，就可以取出某一位的二进制数。

跟之前那题一样，保留最高位的不同，然后在后面的所有位数都尽可能让大数变小，让小数变大，请注意有 l 的范围，所以在进行操作的时候随时检查当前异或数是否合法。异或操作也很简单，依旧是取出2的 i 次方进行异或，因为其它地方都是0只有关键位为1，所以可以只操作我们想操作的位数。

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

void solve(){
    cll(a);cll(b);cll(r);
    if(a>b) swap(a,b);
    bool firs=true;
    ll x=0;
    ROF(i,60ll,0ll){
        ll aa=a&(1ll<<i);
        ll bb=b&(1ll<<i);
        if(aa!=bb && firs) firs=false;
        else if(aa!=bb && !aa && x+(1ll<<i)<=r){
            a^=(1ll<<i);
            b^=(1ll<<i);
            x+=(1ll<<i);
        }
    }
    s(b-a);endll;
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