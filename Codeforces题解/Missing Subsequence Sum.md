# Missing Subsequence Sum

所有者: Zvezdy
标签: 位掩码, 构造
创建时间: 2024年4月28日 11:47

想想多重背包的二进制优化：用2的n次幂可以快速表示出所有的数。

但这题卡了一个数字k，那只要把k的highbit找出来删去就好，小于k大于highbit的那一段数可以用k-1-highbit表示，而再插入k+1和k+highbit就可以弥补后面的数因为缺少highbit引来的空缺

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
vector<int>a;
void solve(){
    cint(n); cint(k);
    int i=1,kk=0;
    while(i*2<=k){
        i*=2;
        ++kk;
    }
    --i; int j=1; a.clear();
    a.push_back(k-1-i);//k-1与i之间的空隙
    ++i; i*=2;
    a.push_back(k+i);
    a.push_back(k+1);
    int num=1;
    FOR(j,0,20){
        if(j!=kk) a.push_back(num);
        num*=2;
    }
    s(a.size());endll;
    for(auto xx:a) s(xx<<" "); endll;
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