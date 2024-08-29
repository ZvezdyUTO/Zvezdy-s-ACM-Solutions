# Mathematical problem

所有者: Zvezdy
标签: 找规律, 构造
创建时间: 2024年5月9日 11:39

第一眼看到这个题目，毫无头绪，在这种情况下比较好的做法就是找一下题目的重要信息。

可以发现：1.题目给出的奇数为n     2.这几个数字组合的情况下只是各个位上的数字交换顺序   3.n很大，完全不可能用枚举或者常规方法解决。

既然完全不能用常规方法解决，那么就其实可以去找规律了，也就是打表。

那么五位数以内呢，我们打个表看看哪个数字是符合要求的：

```cpp
map<vector<int>,int>mp;
void solve(){
    double cut=100;
    for(double i=10000;i<=99999;++i){
        double num=sqrt(i);
        if(num==cut){//发现完全平方数
            int ts=i; vector<int>now;
            while(ts){
                now.push_back(ts%10);
                ts/=10;
            }
            sort(now.begin(),now.end());
            ++mp[now];
            ++cut;
            if(mp[now]>=5){
                s(i);
                endll;
            }
        }
    }
}
```

发现打出来了：43681,90601,96100

继续打七位数的表，又得到一堆数字：4368100，4532641，7845601，9060100，9132484，9610000，9641025

可以发现，1 9 6 这三个数字比较特殊，很可能就是我们所需要的答案。大胆猜测只要往这三个数字中间塞0就好，当然结尾也可以塞0：

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

void solve(){
    cint(n);
    if(n==1){s(1<<endl);return;}
    FOR(i,0,n/2-1){
        s(1); FOR(j,0,i-1) s(0);
        s(6); FOR(j,0,i-1) s(0);
        s(9); FOR(j,i*2+3,n-1) s(0);
        endll;
    }
    FOR(i,0,n/2-1){
        s(9); FOR(j,0,i-1) s(0);
        s(6); FOR(j,0,i-1) s(0);
        s(1); FOR(j,i*2+3,n-1) s(0);
        endll;
    }
    s(1);s(9);s(6);
    FOR(i,3,n-1) s(0);
    endll;
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
