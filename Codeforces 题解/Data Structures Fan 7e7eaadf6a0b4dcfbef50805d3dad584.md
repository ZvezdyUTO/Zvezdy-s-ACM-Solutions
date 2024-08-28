# Data Structures Fan

所有者: Zvezdy
标签: 位运算, 前缀和&差分
创建时间: 2024年4月29日 18:01

我们可以把异或看成是一堆数通过某种手段杂糅在一起，看成某种表现形式的集合吧，当我们打算将几个新的数加入进去的时候，如果有新的数和原来的数相同的就会消除它们，不同的就可以直接加入进去。

这题的查询太简单了，，就是整个区间上的0位置的数或者1位置上的所有数.假如为离线操作，那我们直接弄一个所有数的异或和，还有所有0位置数的异或和就好了，因为如果要求1位置的异或和，我们只要拿0位置的异或和还有所有位置的异或和进行异或就行。

主要是区间修改操作，它的要求是让一个区间的0和1翻转，那我们直接拿我们维护出来的所有0位置的异或和异或那一段所有数字的区间异或和就行，因为原有的数会被直接消除，而没有的数会被添加进去。为了实现这个操作，我们可以维护区间异或和来优化。

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
#define cd(x) double x; cin>>x
#define pque priority_queue
#define umap unordered_map
#define uset unordered_set
#define endll cout<<endl
#define __ cout<<" "
#define dot pair<int,int>
int m[200001];
void solve(){
    cint(n); FOR(i,1,n) r(m[i]);
    cstring(s);int cnt=0;
    int zero=0;
    for(auto i:s){
        ++cnt;
        if(i=='0') zero^=m[cnt];
        m[cnt]^=m[cnt-1];
    }
    cint(q); while(q--){
        cint(now);
        if(now==2){
            cint(check);
            if(check) s((m[n]^zero));
            else s(zero); __;
        }
        else{
            cint(l); cint(r);
            zero^=m[l-1]^m[r];
        }
    } endll;
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