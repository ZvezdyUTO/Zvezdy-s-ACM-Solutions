# Long Inversions

所有者: Zvezdy
标签: 位运算, 前缀和&差分, 暴力枚举
创建时间: 2024年4月10日 20:02

首先观察数据范围，k≤n≤5000，那么n^2≤ 25 000 000，可以考虑暴力枚举，把k从大到小都枚举一遍。

问题是区间操作，那么一般来说就是差分，不过这题比较特殊，因为它的区间操作是反转01。对于反转，我们可以使用异或运算来实现它。假使我们有一个全为0的所谓“差分”数组，那我们如果把第 $i$ 项和第 $i+k$ 项都改为 1 ，那么当我们对这个数组进行前缀异或的时候，第 $i$ 到 $i+k-1$ 项这k个数都会变为1。

而异或的性质又是，当一个数异或他自己的时候会变成0，异或0则是它自己本身，那我们便可以通过这个所谓差分数组实现区间修改的操作。

在这题中，我们可以这么判断，我们可以从左到右遍历每个数字，如果遇到0就把后面k项全部反转，以此类推看能不能刚好把所有数都变为1。至于反转，我们需要用到我们的差分数组，如果差分数组是0，则代表不反转，如果是1则代表反转，我们只需要对差分数组进行前缀异或操作就可以用它来一一对照原数组。 

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
#define int ll
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
int a[5002];
int f[5002];
void solve(){
    cint(n); cstring(s);
    int it=0;
    FOR(i,1,s.size()){
        a[i]=s[it]-'0';
        ++it;
    }
    ROF(k,n,1){
        FOR(i,1,n) f[i]=0;
        bool end=true;
        FOR(i,1,n){
            f[i]^=f[i-1];
            if(f[i]^a[i]==0){
                f[i]^=1;
                if(i+k-1>n){end=false;break;}
                f[i+k]^=1;
            }
        }
        if(end){s(k);endll;return;}
    }
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