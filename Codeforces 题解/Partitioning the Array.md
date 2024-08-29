# Partitioning the Array

所有者: Zvezdy
标签: 数学, 暴力枚举
创建时间: 2024年4月19日 11:35

同余中有一个知识：如果x%m==y%m,则m可以整除(x-y)。反过来想，在一组数据中如果它们差分的gcd不为1，就说明那组数中存在一个符合要求的m。

不过在一种分法中有很多组数，根据取模运算的规律，我们模上m的因数也依旧能拿到一样的余数。于是对一组m又求gcd，最后如果不为1就算答案存在。

自己尝试写了一大段史山，屁都没过，参考了一下大佬的代码，直接秒了：

首先根据之前所说，我们需要找到所有差的最大公约数，我发病一组一组求然后再合在一起求了，实际上根据gcd的性质，完全可以杂糅在一起求，也就是开一个 x+1~n 的循环，根本没必要去讨论分成一组以及分成n组的情况，草率了，。。

代码很简单：

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
int n,a[200005];
bool check(int x){
    int g=0;
    FOR(i,x+1,n) g=gcd(g,abs(a[i]-a[i-x]));
    if(g==1) return false;
    return true;
}
void solve(){
    r(n); ll ans=0;
    FOR(i,1,n) r(a[i]);
    FOR(i,1,n){
        if(n%i) continue;
        ans+=check(i);
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
