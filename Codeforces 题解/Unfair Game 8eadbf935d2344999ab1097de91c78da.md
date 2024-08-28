# Unfair Game

所有者: Zvezdy
标签: 找规律
创建时间: 2024年5月7日 19:02

一个打表的经典情景，手动暴力枚举出所有可能的状况，然后开 if 手动贪心。其实没什么难度，但主要是方法在这里，记录一下当做一个典范吧。

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
const int MAXN=200001;
const int mode=1e9+7;

void solve(){
    cint(a);cint(b);cint(c);cint(d);
    int ans=0;
    if(d%2) --d;
    if(a%2 && b%2 && c%2){
        ++ans;
        --a,--b,--c;
    }
    if(a%2 && b%2 && c%2==0){
        if(c) --c,++ans;
        --a;--b;--c;
    }
    if(a%2 && c%2 && b%2==0){
        if(b) --b,++ans;
        --a;--b;--c;
    }
    if(a%2==0 && b%2 && c%2){
        if(a) --a,++ans;
        --a;--b;--c;
    }
    if(a>0) ans+=(a/2);
    if(b>0) ans+=(b/2);
    if(c>0) ans+=(c/2);
    if(d>0) ans+=(d/2);
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