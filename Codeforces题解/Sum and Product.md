# Sum and Product

所有者: Zvezdy
标签: 数学
创建时间: 2024年4月16日 20:20

写红温了，本来按理来说应该是map，但是这题给的逆天数据显然不想让我用map求解。对于这题来说，其实两个数做加法和做乘法是有点数学关系在里面的，比如转化为某方程的两个根。

说的是a[i]+a[j]=x ，a[i]*a[j]=y  通过消元可得 a[j]=x-a[i]，那么a[i]*(x-a[i])=y

化为一元二次方程:  -a[i]^2 + x*a[i] - y = 0

不用管那个a[i]，实际上因为a[i]+a[j]=x所以一个方程的两个根就是a[i]和a[j]

所以只有两个数能够构成这个x和y的方程。

那我们进去找到有多少数对应这两个解就好了，值得注意的是当方程解唯一或者无解时需要有特殊解法。

暴力了，sqrt就sqrt，大不了开long double

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
ld a[200001];
map<ld,ll>num;
void solve(){
    cint(n);
    FOR(i,1,n){r(a[i]);++num[a[i]];}
    cint(q);
    while(q--){
        cld(x); cld(y);
        ld un=pow(x,2)-4*y;
        if(un<0){s("0 ");continue;}
        ld aa=(x-sqrt(un))/2;
        ld bb=(x+sqrt(un))/2;
        if(un==0){
            s(num[aa]*(num[aa]-1)/2);
             __;
        }
        else{
            s(num[aa]*num[bb]);
            __;
        }
    }
    num.clear();
    endll;
}
signed main(){
    ios::sync_with_stdio(false);
    cin.tie(0); cout.tie(0);
//    freopen("test.in", "r", stdin);
//    freopen("test.out", "w", stdout);
    int T; cin>>T;
//    int T=1;
    while(T--){solve();}
    return 0;
}
```